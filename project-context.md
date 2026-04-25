# Project Context: C64 Ultimate Uploader

> Critical rules and patterns for AI agents implementing code in this project.

## Project Overview

A bridge system connecting Commodore 64 Ultimate II+ hardware with large Assembly64 software collections. Provides native C64 interface for browsing and launching programs.

**Components:**
- `uploader/` - Go server: protocol server, database generation
- `c64client/` - Native C64 application: runs on actual hardware via Ultimate II+ network

## Critical Constraints

### C64 Client Memory Limits

The C64 has ~38KB usable RAM. These constants are carefully chosen:

```c
#define MAX_ITEMS 32        // Items per menu buffer - must fit 27-cell A-Z letter grid plus headroom
#define LINE_BUFFER_SIZE 128 // TCP line buffer - protocol max line length
```

**Rules:**
- Paginated lists (LIST/LISTPATH/SEARCH/RELEASES) are still 20 per page on the server
- MAX_ITEMS=32 exists specifically so the letter-grid menu (27 cells) fits in `item_names[]`, `menu_paths[]`, etc.
- String buffers: `item_names[32]`, `menu_paths[48]`, `item_cats[8]`
- Total per-item overhead: ~100 bytes x 32 items = ~3KB

### Server Item Limits

The server caps paginated list responses (LIST/LISTPATH/SEARCH/RELEASES) at 20 entries. The MENU response can return up to 27 items for the A-Z letter grid; all other menus are smaller.

### Protocol Response Format

All multi-line responses end with `.\n` terminator:

```
OK <count>\n           # Header with item count
type|data|here\n       # Data lines
.\n                    # Terminator
```

An empty or invalid MENU path still returns `OK 0\n.\n` — never a bare `.\n`, which would deadlock a client waiting on the missing `OK` header.

### Menu Item Types

Menu items have a type code that determines navigation behavior:
- `f` = folder - navigate with MENU command. A path ending in `/A-Z` signals a letter-grid folder; its MENU reply is 27 cells A..Z + `#`, each type `l`.
- `l` = list - load entries with LISTPATH
- `D` = directory inside MYFILES (folder navigation)
- `F` = file inside MYFILES (execute with RUNFILE)
- `b` = legacy browse (older servers used this for Browse A-Z; current client still accepts it, but the server no longer emits `b`)

### Stack-Based Navigation

The C64 client uses a stack for back navigation:
```c
#define MAX_PATH_DEPTH 8
static char menu_stack[MAX_PATH_DEPTH][48];
static int menu_depth = 0;

void push_path(const char *path);
const char *pop_path(void);
```

## File Organization

```
uploader/
  main.go           # CLI entry point, subcommands
  server_sqlite.go  # SQLite-based protocol server
  db.go             # SQLite schema and queries
  dbgen.go          # Helper functions for database generation
  dbgen_sqlite.go   # SQLite database generation
  apiclient.go      # C64 Ultimate REST API client

c64client/
  src/main.c        # Main client application
  src/ultimate.c/h  # Ultimate II+ network library
  Makefile          # Build: make prg/crt/d64
```

## Database: SQLite

**File:** `c64uploader.db` in assembly64 directory

**Key tables:**
- `entries` - All content (Games, Demos, Music, etc.)
- `files` - Files within each entry
- `menu_paths` - Pre-computed navigation hierarchy
- `entries_fts` - Full-text search (FTS5)

**Generation:** `./c64uploader sqlitegen -assembly64 <path>`

See `docs/sqlite-database-schema.md` for full schema.

## Protocol Commands

| Command | Purpose |
|---------|---------|
| MENU [path] | Hierarchical folder navigation (returns type\|name\|path\|count) |
| LETTERS path | Get letter counts for letter picker |
| LISTPATH offset count path [letter] | List entries at path with optional letter filter |
| SEARCH offset count [cat] query | Text search |
| INFO id | Entry details |
| RUN id | Execute entry on C64 |
| RELEASES offset count path title | All releases of a title |
| QUIT | Close connection |

See `uploader/C64PROTOCOL.md` for full specification.

## Build Commands

**Go Server:**
```bash
cd uploader && go build -o c64uploader
```

**C64 Client:**
```bash
cd c64client
make prg    # Build .prg file
make crt    # Build cartridge (auto-start)
make deploy # FTP upload to Ultimate (needs U2P_HOST env)
```

**Compiler:** oscar64 (NOT cc65) - modern high-performance C64 C compiler

## External Dependencies

**Go:**
- `modernc.org/sqlite` - Pure Go SQLite (no CGO)
- `github.com/jlaffaye/ftp` - FTP client

**C64 Ultimate REST API:**
- Endpoints: `/v1/runners:run_prg`, `/v1/runners:run_crt`, etc.
- Default host: `c64u` (configurable)

## Code Patterns

### Title Normalization

Titles are normalized for grouping multiple releases:

```go
func normalizeTitle(title string) string {
    // Lowercase, strip articles, punctuation, common suffixes
    // "The Great Giana Sisters" -> "great giana sisters"
}
```

### Entry Sources

Games, Demos, Music each have multiple sources:
- CSDB, C64.com, Gamebase, HVSC, Guybrush, OneLoad64, etc.

Path structure varies by source - check `dbgen_sqlite.go` for parsing logic.

### Error Handling

Protocol errors return: `ERR <message>\n`

Client should display error and allow retry.

## Testing

**Server:**
```bash
# Test protocol with netcat
echo "MENU" | nc localhost 6465
echo "MENU Games/CSDB" | nc localhost 6465
echo "LETTERS Games/CSDB" | nc localhost 6465
echo "LISTPATH 0 20 Games/CSDB A" | nc localhost 6465
```

**C64 Client:**
- Test in VICE: `make run`
- Debug output: `print_status()` shows in status bar

## Known Issues / Debt

1. FTP package unused but still in go.mod (originally for direct Assembly64 access)
2. dbgen.go contains dead code (JSON generation functions) but helper functions are used by dbgen_sqlite.go

## Performance Notes

- SQLite with WAL mode for concurrent reads
- FTS5 for fast text search
- Pre-computed menu_paths table for navigation
- Grouped queries use normalized_title index
- Server enforces 20-item limit - eliminates client buffer overflow issues
