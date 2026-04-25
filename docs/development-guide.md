# Development Guide

> Getting started with development on the C64 Ultimate Uploader project.

## Prerequisites

### Go Server (uploader/)

- **Go 1.25+** - https://go.dev/dl/
- **SQLite** knowledge (no external SQLite required - uses pure Go implementation)

### C64 Client (c64client/)

- **Oscar64** compiler - https://github.com/drmortalwombat/oscar64 (required, must be on `$PATH` as `oscar64`)
- **VICE** emulator (optional) - https://vice-emu.sourceforge.io/ (only needed for `make d64` and `make run`)
- **c1541** (from VICE, for D64 creation)

#### Installing Oscar64 (Linux / macOS)

```bash
# Build from source — no prebuilt packages
git clone https://github.com/drmortalwombat/oscar64.git ~/tools/oscar64
cd ~/tools/oscar64
make

# Put the compiler on PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$HOME/tools/oscar64/bin:$PATH"

# Verify
which oscar64
oscar64 --version
```

If you install Oscar64 somewhere `oscar64` is not on `$PATH`, set `OSCAR64_INCLUDE` so the Makefile can find the headers:

```bash
export OSCAR64_INCLUDE=$HOME/tools/oscar64/include
```

#### Installing VICE (optional)

```bash
# Debian / Ubuntu
sudo apt install vice

# macOS (Homebrew)
brew install vice
```

Skip VICE if you only deploy to the real Ultimate device via `make runprg` / `make runcrt`.

### Hardware Testing

- **Ultimate II+** or **Ultimate 64** with network enabled
- Network access between development machine and Ultimate

## Environment Setup

### Go Server

```bash
# Clone repository
git clone <repo-url>
cd c64uploader

# Build server
cd uploader
go build -o c64uploader

# Verify
./c64uploader --help
```

### C64 Client

```bash
# Ensure oscar64 is in PATH
which oscar64

# Build PRG
cd c64client
make prg

# Test in VICE
make run
```

### Environment Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `C64U_HOST` | Ultimate II+ hostname | `c64u` or `192.168.1.50` |
| `U2P_HOST` | Alternative for FTP deploy | `192.168.1.50` |

## Building

### Go Server

```bash
cd uploader

# Development build
go build -o c64uploader

# Cross-compile for other platforms
GOOS=linux GOARCH=amd64 go build -o c64uploader-linux
GOOS=darwin GOARCH=amd64 go build -o c64uploader-mac
GOOS=windows GOARCH=amd64 go build -o c64uploader.exe
```

### C64 Client

```bash
cd c64client

# Build PRG (default)
make prg

# Build 16 KB autostart cartridge image (functionally identical to the .prg)
make crt

# Build disk image (requires c1541)
make d64

# Clean build artifacts
make clean
```

Both `prg` and `crt` are produced from the same source. `make crt` adds `-tf=crt16` to package the binary as a 16 KB cartridge image; `-dNOFLOAT` is on by default in the Makefile to keep the binary inside the 16 KB cart slot. See [docs/architecture-c64client.md](architecture-c64client.md#cart-target-constraints) for the cart-specific source conventions (no static initializers, explicit VIC init).

## Running

### Go Server

```bash
# Start TUI (interactive browser)
./c64uploader tui -db /path/to/c64uploader.db

# Start protocol server
./c64uploader server -db /path/to/c64uploader.db -assembly64 /path/to/collection

# Generate database from Assembly64 collection
./c64uploader sqlitegen -assembly64 /path/to/collection

# Upload and run a file (PRG, CRT, D64, ...) from disk or URL
./c64uploader load -host c64u /path/to/game.prg

# POKE a single byte via DMA
./c64uploader poke -host c64u D020,0

# Remote debug the running native client
./c64uploader debug screen -host c64u
./c64uploader debug press  -host c64u down,down,enter
./c64uploader debug scroll-rate -host c64u down 2
```

### C64 Client

```bash
# Run in VICE emulator
make run

# Deploy to Ultimate via FTP
U2P_HOST=192.168.1.50 make deploy

# Execute directly via REST API
U2P_HOST=192.168.1.50 make runprg
```

## Testing

### Protocol Testing

```bash
# Start server (normally run from the repo root so it finds ./myfiles)
cd uploader && go build -o ../c64uploader && cd ..
./c64uploader server -assembly64 ~/Assembly64 &

# Test commands with netcat (multiple probes in one connection)
(printf 'MENU\n'; sleep 0.3;
 printf 'MENU Games/CSDB\n'; sleep 0.3;
 printf 'MENU Games/CSDB/A-Z\n'; sleep 0.3;
 printf 'LISTPATH 0 5 Games/CSDB/A-Z/A\n'; sleep 0.3;
 printf 'SEARCH 0 5 Games mario\n'; sleep 0.3;
 printf 'QUIT\n') | nc -q 1 localhost 6465
```

`MENU Games/CSDB/A-Z` returns the 27-entry letter-grid menu; `LISTPATH 0 5 Games/CSDB/A-Z/A` returns the first five A-titled games.

### C64 Client Testing

```bash
# Test in VICE emulator
make run

# Debug output visible in status bar (row 24)
# Use print_status() in code for debugging
```

### Remote Debugging on Real Hardware

When a bug reproduces only on the real Ultimate and not in VICE, drive the running a64browser from the PC via the Ultimate's HTTP API:

```bash
# Snapshot the text screen as ASCII
./c64uploader debug screen -host c64u

# Inject keys. Named tokens: up down next prev info enter back right tab space q c slash
# Single characters pass through verbatim (use lowercase for nav handlers)
./c64uploader debug press -host c64u down,down,enter

# Peek any global variable — find its address in c64client/build/a64browser.lbl
grep menu_path c64client/build/a64browser.lbl   # e.g. al 6100 .menu_path
./c64uploader debug peekstr -host c64u 6100

# Measure auto-repeat scroll speed under a simulated held key
./c64uploader debug scroll-rate -host c64u down 2
```

Two reserved bytes in the client make this possible: `$02A7 DEBUG_KEY_INJECT` (single-shot key) and `$02A8 DEBUG_HOLD_SCAN` (simulated matrix hold). Both stay zero in normal use.

### Database Testing

```bash
# Generate test database
./c64uploader sqlitegen -assembly64 /path/to/test-collection

# Query database directly
sqlite3 /path/to/c64uploader.db "SELECT COUNT(*) FROM entries"
sqlite3 /path/to/c64uploader.db "SELECT * FROM entries LIMIT 5"
```

## Development Workflow

### Making Changes to Go Server

1. Edit source files in `uploader/`
2. Build: `go build -o c64uploader`
3. Test: Run server and use netcat or TUI
4. Commit changes

### Making Changes to C64 Client

1. Edit source files in `c64client/src/`
2. Build: `make prg`
3. Test: `make run` (VICE) or deploy to real hardware
4. Commit changes

### Protocol Changes

When modifying the protocol:

1. Update server in `server_sqlite.go`
2. Update client in `main.c`
3. Update documentation in `C64PROTOCOL.md`
4. Test both ends thoroughly

## Code Patterns

### Server: Adding a New Command

```go
// In server_sqlite.go, handleConnection()
case "NEWCMD":
    if len(parts) < 2 {
        conn.Write([]byte("ERR missing argument\n"))
        break
    }
    handleNewCommand(conn, parts[1:], index)
```

### Client: Adding a New Screen

```c
// In main.c
case STATE_NEW_SCREEN:
    draw_new_screen();
    handle_new_screen_input();
    break;
```

### Database: Adding a New Table

```go
// In db.go, schema definition
CREATE TABLE IF NOT EXISTS new_table (
    id INTEGER PRIMARY KEY,
    field1 TEXT,
    field2 INTEGER
);
```

## Common Tasks

### Regenerate Database

```bash
./c64uploader sqlitegen -assembly64 /path/to/assembly64
```

### Update Server Configuration

Edit `main.c` in c64client:
```c
#define SERVER_HOST "192.168.1.100"
#define SERVER_PORT 6465
```

### Add New File Type Support

1. Server: Add handler in `apiclient.go`
2. Server: Add MIME type mapping
3. Update `RUN` command handler
4. Test with actual file

## Debugging

### Go Server

```bash
# Enable verbose logging
./c64uploader server -v

# Use debugger
dlv debug ./main.go -- server
```

### C64 Client

```c
// Add debug output
print_status("Debug: value=%d", some_value);
```

### Network Issues

```bash
# Check server is listening
netstat -an | grep 6465

# Test connection
nc -v localhost 6465

# Check Ultimate connectivity
ping $C64U_HOST
curl http://$C64U_HOST/v1/status
```

## Documentation

When making changes:

1. Update `README.md` for user-facing changes
2. Update `uploader/C64PROTOCOL.md` for protocol changes
3. Update `docs/sqlite-database-schema.md` for schema changes
4. Update `project-context.md` for AI agent guidance

## Git Workflow

```bash
# Create feature branch
git checkout -b feature/new-feature

# Make changes and commit
git add -A
git commit -m "Add new feature"

# Push and create PR
git push -u origin feature/new-feature
```

## Troubleshooting

### Go Build Errors

```bash
# Update dependencies
go mod tidy

# Clear module cache
go clean -modcache
```

### C64 Compiler Errors

```bash
# Check oscar64 version
oscar64 --version

# Verify include path
oscar64 -i=/path/to/includes ...
```

### Connection Refused

1. Verify server is running: `ps aux | grep c64uploader`
2. Check port: `netstat -an | grep 6465`
3. Check firewall settings

### Ultimate Not Responding

1. Verify IP address: `ping $C64U_HOST`
2. Check REST API: `curl http://$C64U_HOST/v1/status`
3. Restart Ultimate if needed
