# C64 Protocol Specification

**Current version**: 2.0

## Overview

The C64 protocol is a simple, line-based text protocol designed for low-bandwidth communication between Commodore 64 clients and the `c64uploader` server.
The protocol uses TCP connections with plain text commands and responses, making it easy to implement on resource-constrained 8-bit systems.

## Connection Flow

1. Client establishes TCP connection to server (default port 6465)
2. Server sends greeting: `OK c64uploader\n`
3. Client sends commands, server responds
4. Connection remains open until client sends `QUIT` or timeout occurs (5 minutes of inactivity)
5. Server sends goodbye message and closes connection

## Protocol Characteristics

- **Line-based**: Each command and response line is terminated by `\n` (newline)
- **Text-based**: All data is transmitted as ASCII text
- **Stateless**: Each command is independent
- **Connection timeout**: 5 minutes of inactivity
- **Item limit**: Server never sends more than 20 items per response (C64 memory constraint)
- **Response terminator**: All multi-line responses end with `.\n`

## Command Format

Commands are case-insensitive and follow this general format:
```
COMMAND [arg1] [arg2] [arg3]
```

Arguments are separated by whitespace.

## Response Format

All responses start with either `OK` or `ERR`:

### Success Response
```
OK [additional data]\n
[payload lines...]\n
.\n
```

### Error Response
```
ERR [error message]\n
```

The `.` (period) character on its own line indicates the end of multi-line responses.

---

## Command Reference

### 1. MENU - Navigate Menu Hierarchy

The `MENU` command navigates the hierarchical menu structure. It returns menu items with their types, allowing the client to display and navigate through categories, sources, and browse options.

#### Syntax
```
MENU [path]
```

#### Arguments
- `path`: (Optional) Menu path to navigate to. If empty, returns root menu.

#### Response Format
```
OK <count>\n
<type>|<name>|<path>|<count>\n
<type>|<name>|<path>|<count>\n
...
.\n
```

- `count`: Number of items returned (max 20)
- `type`: Item type code:
  - `f` = folder (navigate deeper with MENU)
  - `b` = browse (use LETTERS command for letter picker)
  - `l` = list (use LISTPATH to get entries)
- `name`: Display name for the item
- `path`: Full path for this item (used in subsequent commands)
- `count`: Number of entries (for display purposes)

#### Examples

**Example 1: Root menu**

Request:
```
MENU
```

Response:
```
OK 6
f|Games|Games|25000
f|Demos|Demos|15000
f|Music|Music|50000
f|Intros|Intros|3000
f|Graphics|Graphics|1500
f|Discmags|Discmags|500
.
```

**Example 2: Games source menu**

Request:
```
MENU Games/CSDB
```

Response:
```
OK 3
b|Browse A-Z|Games/CSDB|8500
l|Top 200|Games/CSDB/Top200|200
l|By Year|Games/CSDB/ByYear|8500
.
```

---

### 2. LETTERS - Get Letter Counts for Browse

The `LETTERS` command returns available first letters and their entry counts for the letter picker UI. Used when the client selects a type `b` (browse) item.

#### Syntax
```
LETTERS <path>
```

#### Arguments
- `path`: The browse path (from MENU response)

#### Response Format
```
OK <count>\n
<letter>|<count>\n
<letter>|<count>\n
...
.\n
```

- `count`: Number of letters with entries
- `letter`: Single character (A-Z or # for non-alphabetic)
- `count`: Number of entries starting with that letter

#### Example

Request:
```
LETTERS Games/CSDB
```

Response:
```
OK 27
#|42
A|523
B|412
C|389
D|256
E|178
...
Z|23
.
```

---

### 3. LISTPATH - List Entries at Path

The `LISTPATH` command retrieves entries at a specific path with optional letter filtering. Used for browsing entries grouped by title.

#### Syntax
```
LISTPATH <offset> <count> <path> [letter]
```

#### Arguments
- `offset`: Starting index, 0-based
- `count`: Number of entries to return (max 20)
- `path`: Path to list entries from
- `letter`: (Optional) Filter to entries starting with this letter (A-Z or # for non-alpha)

#### Response Format
```
OK <returned> <total>\n
<id>|<name>|<category>|<release_count>|<trainers>\n
...
.\n
```

- `returned`: Number of entries in this response
- `total`: Total entries matching the query
- `id`: Entry ID (for RUN/INFO commands)
- `name`: Entry title
- `category`: Category abbreviation
- `release_count`: Number of releases for this title
- `trainers`: Trainer count (-1 if unknown)

#### Examples

**Example 1: All entries at path**

Request:
```
LISTPATH 0 20 Games/CSDB
```

Response:
```
OK 20 8500
12345|Arkanoid|Games|3|2
12346|Boulder Dash|Games|5|0
...
.
```

**Example 2: Entries starting with 'A'**

Request:
```
LISTPATH 0 20 Games/CSDB A
```

Response:
```
OK 20 523
12345|Arkanoid|Games|3|2
12350|Ace of Aces|Games|2|0
...
.
```

---

### 4. RELEASES - Get All Releases of a Title

The `RELEASES` command retrieves all variant releases of a specific title. Used when an entry has multiple releases (release_count > 1).

#### Syntax
```
RELEASES <offset> <count> <path> <title>
```

#### Arguments
- `offset`: Starting index, 0-based
- `count`: Number of entries to return (max 20)
- `path`: Category/source path
- `title`: Exact title to match

#### Response Format
```
OK <returned> <total>\n
<id>|<group>|<year>|<type>|<trainers>\n
...
.\n
```

- `id`: Entry ID (for RUN/INFO commands)
- `group`: Release group/publisher
- `year`: Release year
- `type`: File type (prg, d64, crt, etc.)
- `trainers`: Trainer count

#### Example

Request:
```
RELEASES 0 20 Games/CSDB Arkanoid
```

Response:
```
OK 3 3
12345|Imagine|1987|d64|0
12346|Triangle|1988|prg|2
12347|Nostalgia|2010|prg|0
.
```

---

### 5. SEARCH - Search Entries

The `SEARCH` command performs a text search across entry titles and groups.

#### Syntax
```
SEARCH <offset> <count> [category] <query>
```

#### Arguments
- `offset`: Starting index, 0-based
- `count`: Number of results to return (max 20)
- `category`: (Optional) Category filter (Games, Demos, Music)
- `query`: Search term (case-insensitive)

#### Response Format
```
OK <returned> <total>\n
<id>|<name>|<group>|<year>|<type>\n
...
.\n
```

#### Example

Request:
```
SEARCH 0 20 Games ninja
```

Response:
```
OK 5 5
12400|Last Ninja|System 3|1987|d64
12401|Last Ninja 2|System 3|1988|d64
12402|Last Ninja 3|System 3|1991|d64
12403|Ninja|Sculptured|1986|prg
12404|Shadow Ninja|Natsume|1990|d64
.
```

---

### 6. INFO - Get Entry Details

The `INFO` command retrieves detailed metadata for a specific entry.

#### Syntax
```
INFO <id>
```

#### Arguments
- `id`: Entry ID (from LISTPATH, RELEASES, or SEARCH)

#### Response Format
```
OK\n
NAME|<name>\n
GROUP|<group>\n
YEAR|<year>\n
CAT|<category>\n
TYPE|<file_type>\n
PATH|<relative_path>\n
.\n
```

#### Example

Request:
```
INFO 12400
```

Response:
```
OK
NAME|Last Ninja
GROUP|System 3
YEAR|1987
CAT|Games
TYPE|d64
PATH|Games/L/Last_Ninja.d64
.
```

---

### 7. RUN - Execute Entry

The `RUN` command uploads and executes an entry on the C64 Ultimate hardware.

#### Syntax
```
RUN <id>
```

#### Arguments
- `id`: Entry ID

#### Response Format
```
OK Running <entry_name>\n
```

or

```
ERR <error_message>\n
```

#### Behavior by File Type

- **PRG files**: Loaded into memory and executed
- **CRT files**: Cartridge image is mounted
- **SID files**: Music is played via Ultimate's SID player
- **D64/G64/D71/D81**: Disk image mounted, first program loaded and run

---

### 8. RUNFILE - Execute File from My Files

The `RUNFILE` command uploads and executes a file from the user's personal `myfiles/` directory.

#### Syntax
```
RUNFILE MYFILES/<path>
```

#### Arguments
- `path`: Path to file within myfiles directory (e.g., `MYFILES/games/mygame.prg`)

#### Response Format
```
OK Running\n
```

or

```
ERR <error_message>\n
```

#### Errors
- `ERR Usage: RUNFILE <path>` - Missing path argument
- `ERR Invalid MYFILES path` - Path doesn't start with MYFILES/
- `ERR Invalid path` - Path traversal attempt or invalid path
- `ERR Invalid file type` - File extension not supported
- `ERR File not found` - File doesn't exist
- `ERR Failed to run: <reason>` - Ultimate API error

#### Supported File Types
Same as RUN: .prg, .crt, .sid, .d64, .g64, .d71, .d81, .t64, .tap

#### Example

Request:
```
RUNFILE MYFILES/games/mygame.prg
```

Response:
```
OK Running
```

---

### 9. QUIT - Close Connection

The `QUIT` command closes the connection gracefully.

#### Syntax
```
QUIT
```

#### Response
```
OK Goodbye\n
```

Server closes connection after sending this response.

---

## Navigation Flow

The typical navigation flow for the C64 client:

1. **Root Menu**: `MENU` -> displays categories (Games, Demos, Music, etc.)
2. **Category Menu**: `MENU Games` -> displays sources (CSDB, Gamebase, etc.)
3. **Source Menu**: `MENU Games/CSDB` -> displays navigation options
4. **Letter Picker**: `LETTERS Games/CSDB` -> user selects a letter
5. **Entry List**: `LISTPATH 0 20 Games/CSDB A` -> displays entries starting with 'A'
6. **Releases**: `RELEASES 0 20 Games/CSDB "Arkanoid"` -> shows all versions
7. **Run**: `RUN 12345` -> executes the selected entry

## Memory Constraints

The C64 client has limited memory (MAX_ITEMS = 20). The server enforces this limit:
- MENU responses: max 20 items
- LETTERS responses: max 27 items (A-Z + #)
- LISTPATH/RELEASES/SEARCH responses: max 20 items per page

Pagination is handled client-side using offset/count parameters.
