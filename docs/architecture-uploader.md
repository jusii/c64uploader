# Architecture: Go Server (uploader)

> Go CLI application providing database generation, terminal UI, and TCP protocol server for C64 clients.

## Executive Summary

The uploader component is a multi-mode Go application that serves as the backend for the C64 Ultimate Uploader system. It provides:
- **TUI mode**: Interactive terminal interface for browsing Assembly64 content
- **Server mode**: TCP protocol server for C64 native clients
- **Database generation**: SQLite database creation from Assembly64 collection
- **File execution**: Upload and run programs on C64 Ultimate hardware

## Technology Stack

| Category | Technology | Purpose |
|----------|------------|---------|
| Language | Go 1.25.4 | Primary language |
| TUI | Bubbletea + Lipgloss | Terminal UI framework |
| Database | modernc.org/sqlite | Pure Go SQLite (no CGO required) |
| FTP | jlaffaye/ftp | File upload to Ultimate II+ |
| Protocol | Custom line-based TCP | Communication with C64 clients |

## Architecture Pattern

**CLI with Subcommands + TCP Server**

```
┌─────────────────────────────────────────────────────────┐
│                    main.go (CLI Entry)                   │
├─────────┬─────────┬─────────┬─────────┬─────────┬───────┤
│   tui   │  load   │   ftp   │  poke   │ server  │sqlitegen│
└────┬────┴────┬────┴────┬────┴────┬────┴────┬────┴────┬──┘
     │         │         │         │         │         │
     ▼         ▼         ▼         ▼         ▼         ▼
  tui.go   apiclient  apiclient apiclient  server   dbgen_
           .go        .go       .go       _sqlite   sqlite
                                          .go       .go
```

## Source Structure

```
uploader/
├── main.go           # CLI entry point, subcommand routing
├── apiclient.go      # Ultimate II+ REST API and FTP client
├── server_sqlite.go  # TCP protocol server (SQLite backend)
├── index.go          # Search index and database loading
├── db.go             # SQLite schema definitions and queries
├── tui.go            # Bubbletea terminal UI
├── d64.go            # D64 disk image parser
├── dbgen.go          # Database generation helpers
└── dbgen_sqlite.go   # SQLite database generator
```

## Key Components

### CLI Entry Point (main.go)

Commands:
- `tui` - Interactive terminal browser (default)
- `load <id>` - Run entry by ID
- `ftp <file>` - Upload file to Ultimate via FTP
- `poke <file>` - Upload and execute via REST API
- `server` - Start TCP protocol server
- `sqlitegen` - Generate SQLite database from Assembly64

### TCP Protocol Server (server_sqlite.go)

Line-based protocol on port 6465:

| Command | Purpose |
|---------|---------|
| `MENU [path]` | Hierarchical folder navigation |
| `LETTERS path` | Letter picker counts |
| `LISTPATH offset count path [letter]` | List entries |
| `SEARCH offset count [cat] query` | Full-text search |
| `INFO id` | Entry details |
| `RUN id` | Execute program |
| `RELEASES offset count path title` | Multiple releases |
| `QUIT` | Close connection |

**Response Format:**
```
OK <count>
type|field1|field2|...
...
.
```

### Terminal UI (tui.go)

Bubbletea-based TUI with two search modes:
- **Normal mode**: Simple text search
- **Advanced mode**: Filtered search with multiple criteria

Features:
- Pagination (20 items per page)
- Entry info display
- Direct program execution
- Category browsing

### Database Layer (db.go)

SQLite schema with FTS5 full-text search:

**Tables:**
- `entries` - All content (Games, Demos, Music, etc.)
- `files` - Files within entries
- `menu_paths` - Pre-computed navigation hierarchy
- `entries_fts` - Full-text search index

**Key queries:**
- Menu navigation via `menu_paths` table
- Full-text search via `entries_fts`
- Grouped entries via `normalized_title`

### File Execution (apiclient.go)

Two methods:
1. **REST API** - POST to `/v1/runners:run_prg`, `:run_crt`, etc.
2. **FTP** - Upload to Ultimate storage, then execute

Supported file types:
- PRG, CRT (direct execution)
- D64, G64, D71, D81 (disk mount + autoload)
- SID (music playback)

## Data Flow

```
┌──────────────┐    TCP/6465    ┌─────────────────┐
│  C64 Client  │◄──────────────►│  Protocol       │
│  (Ultimate)  │                │  Server         │
└──────────────┘                └────────┬────────┘
                                         │
                                         ▼
                                ┌─────────────────┐
                                │  SQLite DB      │
                                │  - entries      │
                                │  - files        │
                                │  - menu_paths   │
                                │  - entries_fts  │
                                └─────────────────┘
                                         │
                                         ▼
┌──────────────┐    REST/FTP    ┌─────────────────┐
│  Assembly64  │◄──────────────►│  File Server    │
│  Collection  │                │  (execution)    │
└──────────────┘                └─────────────────┘
```

## Configuration

**Environment Variables:**
- `C64U_HOST` - Ultimate II+ hostname (default: `c64u`)
- `C64U_DB` - SQLite database path
- `U2P_HOST` - Alternative Ultimate hostname for FTP

**Flags:**
- `-db <path>` - Database file path
- `-assembly64 <path>` - Assembly64 collection path
- `-host <ip>` - Server bind address

## Dependencies

**Direct:**
- `github.com/charmbracelet/bubbletea` - TUI framework
- `github.com/charmbracelet/lipgloss` - TUI styling
- `github.com/jlaffaye/ftp` - FTP client
- `modernc.org/sqlite` - Pure Go SQLite

**Indirect:**
- Terminal handling (coninput, termenv, ansi)
- UUID generation (google/uuid)
- Color handling (go-colorful)

## Build

```bash
cd uploader
go build -o c64uploader
```

## Testing

```bash
# Protocol testing with netcat
echo "MENU" | nc localhost 6465
echo "SEARCH 0 20 mario" | nc localhost 6465
```

## Performance Considerations

- **WAL mode** enabled for concurrent SQLite reads
- **FTS5** for fast full-text search
- **Pre-computed menu_paths** for O(1) navigation
- **20-item limit** enforced server-side (C64 memory constraint)
- **Normalized titles** indexed for grouped queries
