# Integration Architecture

> How the Go server and C64 native client communicate and work together.

## System Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                         User's Network                              │
│                                                                     │
│   ┌───────────────┐         ┌───────────────┐         ┌──────────┐ │
│   │   PC/Server   │         │  Ultimate II+ │         │   C64    │ │
│   │               │         │  (in C64)     │         │          │ │
│   │ ┌───────────┐ │         │               │         │ ┌──────┐ │ │
│   │ │ Go Server │ │◄───────►│   Network     │◄───────►│ │Client│ │ │
│   │ │ (uploader)│ │ TCP/6465│   Stack       │  Direct │ │ PRG  │ │ │
│   │ └───────────┘ │         │               │   I/O   │ └──────┘ │ │
│   │       │       │         │  ┌─────────┐  │         │          │ │
│   │       │       │         │  │UCI Regs │  │         │          │ │
│   │       ▼       │         │  │$DF1C-1F │  │         │          │ │
│   │ ┌───────────┐ │         │  └─────────┘  │         │          │ │
│   │ │  SQLite   │ │         │       │       │         │          │ │
│   │ │ Database  │ │         │       ▼       │         │          │ │
│   │ └───────────┘ │         │  ┌─────────┐  │         │          │ │
│   │       │       │         │  │ File    │  │         │          │ │
│   │       │       │ REST/FTP│  │ Exec    │  │         │          │ │
│   │       └───────┼────────►│  └─────────┘  │         │          │ │
│   └───────────────┘         └───────────────┘         └──────────┘ │
│                                                                     │
│   ┌───────────────┐                                                 │
│   │  Assembly64   │ (Local storage or network share)                │
│   │  Collection   │                                                 │
│   └───────────────┘                                                 │
└─────────────────────────────────────────────────────────────────────┘
```

## Integration Points

### 1. Protocol Communication (TCP/6465)

**Direction:** C64 Client → Go Server

**Transport:** TCP socket via Ultimate II+ Command Interface

**Protocol:** Line-based, text protocol

| Command Flow | Description |
|--------------|-------------|
| Client sends | `COMMAND args\n` |
| Server responds | `OK count\n` or `ERR message\n` |
| Server sends | `field1\|field2\|...\n` (repeated) |
| Server terminates | `.\n` |

**Commands Supported:**

| Command | Request | Response |
|---------|---------|----------|
| MENU | `MENU [path]` | `type\|name\|path\|count` — path ending in `/A-Z` yields a 27-entry letter grid |
| LETTERS | `LETTERS path` | `letter\|count` (legacy; client now uses MENU `/A-Z`) |
| LISTPATH | `LISTPATH off cnt path [letter]` | `id\|title\|cat\|releases\|trainers` |
| LIST | alias of LISTPATH | same |
| SEARCH | `SEARCH off cnt [cat] query` | `id\|title\|group\|year\|type` |
| INFO | `INFO id` | `LABEL\|value` pairs (variable set) |
| RUN | `RUN id` | `OK` or `ERR` |
| RUNFILE | `RUNFILE MYFILES/<path>` | `OK Running` or `ERR` |
| RELEASES | `RELEASES off cnt path title` | `id\|group\|year\|type\|trainers` |
| QUIT | `QUIT` | `OK Goodbye` then connection closed |

### 2. File Execution (REST API / FTP)

**Direction:** Go Server → Ultimate II+

**Trigger:** Client sends `RUN <id>` command

**Flow:**
```
1. Client: RUN 12345
2. Server: Looks up entry in SQLite
3. Server: Reads file from Assembly64 collection
4. Server: Determines file type (PRG, CRT, D64, SID, etc.)
5. Server: POSTs file to Ultimate REST API:
   - POST /v1/runners:run_prg (for PRG)
   - POST /v1/runners:run_crt (for CRT)
   - POST /v1/runners:run_disk (for D64/G64/D71/D81)
   - POST /v1/runners:sidplay (for SID)
6. Server: Responds OK or ERR to client
7. Ultimate: Executes file, C64 resets into program
```

### 3. Remote Debug Channel (HTTP via Ultimate REST API)

**Direction:** PC tool (`c64uploader debug ...`) ↔ Ultimate II+ ↔ running a64browser

**Transport:** Ultimate's built-in HTTP API (`/v1/machine:readmem`, `/v1/machine:writemem`, `/v1/machine:reset`, etc.). No C64-side networking needed — the debug tool talks to the Ultimate directly, not through the native protocol server.

**Used for:** diagnosing client-side navigation or rendering issues in the a64browser without sitting at the C64. Two reserved scratch bytes in the client act as a one-way control channel:

| Address | Purpose | Producer | Consumer |
|---------|---------|----------|----------|
| `$02A7` | Single-shot key press | `debug press` | `get_key()` / `wait_key()` in the client |
| `$02A8` | Simulated held matrix key | `debug hold` | `get_key()` (bypasses `keyb_poll`) |

Screen inspection reads $0400 (text screen) directly via `machine:readmem` and decodes C64 screen codes to printable ASCII on the PC side — no cooperation from the running client is required.

### 4. Database Synchronization

**Direction:** Assembly64 Collection → SQLite Database

**Trigger:** Manual `sqlitegen` command

**Flow:**
```
1. User runs: ./c64uploader sqlitegen -assembly64 /path/to/collection
2. Server scans Assembly64 directory structure
3. Parses metadata from path names and file structure
4. Generates entries, files, menu_paths tables
5. Builds FTS5 search index
6. Outputs c64uploader.db in collection directory
```

## Data Contracts

### Menu Item (MENU response)

```
type|name|path|count
```

| Field | Type | Description |
|-------|------|-------------|
| type | char | `f`=folder, `l`=list, `D`=MYFILES directory, `F`=MYFILES file, `b`=legacy browse (unused by current server) |
| name | string | Display name. Single character (A..Z, `#`) inside a letter-grid menu, rendered as a grid cell. |
| path | string | Navigation path. Paths ending in `/A-Z` open the letter grid. |
| count | int | Item count (for display only) |

### Entry Item (LISTPATH/SEARCH response)

```
id|title|group|trainers|releases|type
```

| Field | Type | Description |
|-------|------|-------------|
| id | int | Unique entry ID |
| title | string | Entry title |
| group | string | Creator/publisher |
| trainers | int | Trainer count (0 if none) |
| releases | int | Number of releases |
| type | string | File type (prg, d64, etc.) |

### Entry Info (INFO response)

```
field|value
```

Multiple lines with field-value pairs:
- `title|Game Name`
- `group|Publisher`
- `year|1987`
- `type|prg`
- `path|Games/CSDB/G/Game Name`
- etc.

## Memory Constraints

**Server limits:**

- `LISTPATH`, `SEARCH`, `RELEASES`: 20 items per page, regardless of request.
- `MENU`: up to 27 items (only for the A-Z letter grid). All other menus are much smaller.

**Client buffers:**

```c
#define MAX_ITEMS 32          // 27 letter grid cells + headroom
#define LINE_BUFFER_SIZE 128

char item_names[MAX_ITEMS][32];
char menu_paths[MAX_ITEMS][48];
char item_cats[MAX_ITEMS][8];
```

## Error Handling

**Protocol Errors:**
```
ERR message text here
```

Client displays error in status bar and allows retry.

**Connection Errors:**
- Client detects timeout/disconnect
- Shows "Connection lost" message
- Allows reconnect attempt

**File Execution Errors:**
- Server returns `ERR file not found` or similar
- Client displays error, returns to previous screen

## Sequence Diagrams

### Browse and Run

```
C64 Client          Go Server           Ultimate II+
    │                   │                    │
    │──MENU Games/CSDB──►                    │
    │◄──OK 6────────────                     │
    │◄──f|Arcade|...\n──                     │
    │◄──.\n─────────────                     │
    │                   │                    │
    │──LISTPATH 0 20 Games/CSDB/Arcade──────►│
    │◄──OK 20───────────                     │
    │◄──12345|Game|...\n                     │
    │◄──.\n─────────────                     │
    │                   │                    │
    │──RUN 12345────────►                    │
    │                   │──POST /run_prg────►│
    │                   │◄──200 OK──────────│
    │◄──OK──────────────                     │
    │                   │                    │
    ╳ (C64 resets, runs program)             │
```

### Search

```
C64 Client          Go Server
    │                   │
    │──SEARCH 0 20 mario►
    │◄──OK 15───────────
    │◄──entry data lines
    │◄──.\n─────────────
    │                   │
```

## Configuration

### Server Side

```bash
# Start server with database
./c64uploader server -db /path/to/c64uploader.db -assembly64 /path/to/collection
```

Environment:
- `C64U_HOST` - Ultimate hostname (default: `c64u`)

### Client Side

Compile-time defaults in `main.c`:
```c
#define DEFAULT_SERVER_HOST "192.168.2.66"
#define DEFAULT_SERVER_PORT 6465
#define SETTINGS_FILE       "/flash/config/a64browser.cfg"
```

Server host, port, and the autostart flag are overridable at runtime via the in-app config screen (press **F1**); values are persisted to `/flash/config/a64browser.cfg` (three newline-separated lines: host, port, autostart 0/1) and reloaded on next boot.

## Deployment Topology

**Typical Setup:**

```
┌─────────────────────────────────────────┐
│ Home Network (192.168.1.0/24)           │
│                                         │
│  PC (192.168.1.100)                     │
│  └── Go Server (:6465)                  │
│  └── Assembly64 Collection (NAS mount)  │
│                                         │
│  Ultimate II+ (192.168.1.50)            │
│  └── REST API (:80)                     │
│  └── FTP (:21)                          │
│                                         │
│  C64 with Ultimate II+                  │
│  └── C64 Client (a64browser.prg)        │
└─────────────────────────────────────────┘
```
