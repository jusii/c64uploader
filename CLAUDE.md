# Claude Code Instructions for c64uploader

## Documentation Requirements

**Always update relevant documentation when making changes:**
- Update `README.md` when adding new commands, flags, or user-facing features
- Update `docs/sqlite-database-schema.md` when changing the database schema or generator
- Update `uploader/C64PROTOCOL.md` when modifying the C64 protocol
- Include command-line usage examples in documentation

## Project Structure

- `uploader/` - Go application source code
- `c64client/` - Native C64 application (Oscar64)
- `docs/` - Documentation files
- `build/` - Build artifacts

## Key Files

- `uploader/main.go` - CLI entry point and command handlers
- `uploader/tui.go` - Terminal UI (Bubbletea)
- `uploader/server_sqlite.go` - C64 protocol server (SQLite backend)
- `uploader/index.go` - Search index and database loading
- `uploader/db.go` - SQLite schema and queries
- `uploader/dbgen_sqlite.go` - SQLite database generator
- `uploader/apiclient.go` - C64 Ultimate REST API client (includes ReadMemory / WriteMemory)
- `uploader/debug.go` - Remote debug subcommand (screen peek, key injection, memory dump)
- `c64client/src/main.c` - Native C64 browser (page state machine, letter grid, protocol parser)
- `c64client/src/ultimate.{c,h}` - UCI library (TCP sockets, DOS ops, hardware ID)

## Build Commands

```bash
# Build Go application
cd uploader && go build .

# Build C64 client
cd c64client && make
```
