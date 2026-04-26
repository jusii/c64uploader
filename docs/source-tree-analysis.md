# Source Tree Analysis

> Annotated directory structure for the C64 Ultimate Uploader project.

## Project Root

```
c64uploader/
├── uploader/                    # Go server application
│   ├── main.go                  # CLI entry point, subcommand routing
│   ├── apiclient.go             # Ultimate II+ REST API (incl. readmem/writemem) and FTP client
│   ├── server_sqlite.go         # TCP protocol server (main server logic)
│   ├── index.go                 # Search index loading and management
│   ├── db.go                    # SQLite schema and query definitions
│   ├── tui.go                   # Bubbletea terminal UI
│   ├── d64.go                   # D64/G64 disk image parser
│   ├── dbgen_sqlite.go          # SQLite database generator
│   ├── debug.go                 # Remote debug subcommand (screen peek, key inject, scroll-rate, peek)
│   ├── spiffy.go                # Spiffy-compatible HTTP API (/leet/search/) for the
│   │                            #   Ultimate firmware's stock Assembly64 browser
│   ├── web.go                   # Mobile-friendly web UI handlers (/, /static/*, /api/*)
│   │                            #   co-hosted on the spiffy listener
│   ├── web/                     # Embedded web assets (//go:embed):
│   │   ├── index.html           #   single-page UI shell
│   │   └── static/              #   app.js + style.css
│   ├── scanner.go               # Filesystem scanner used by dbgen
│   ├── testclient.go            # Scratch TCP client for protocol debugging (`// +build ignore`)
│   ├── go.mod                   # Go module definition
│   ├── go.sum                   # Dependency checksums
│   ├── C64PROTOCOL.md           # Protocol specification (TCP line protocol)
│   └── SPIFFY_HTTP_API.md       # HTTP API spec served by spiffy.go
│
├── c64client/                   # Native C64 application
│   ├── src/
│   │   ├── main.c               # Main application
│   │   ├── ultimate.c           # UCI library implementation
│   │   └── ultimate.h           # UCI library header
│   ├── build/                   # Compiled output (gitignored)
│   ├── dist/                    # Prebuilt PRG + EasyFlash CRT (tracked)
│   ├── Makefile                 # Build system
│   └── README.md                # Client documentation
│
├── docs/                        # Generated documentation
│   ├── index.md                 # Master documentation index
│   ├── architecture-uploader.md # Go server architecture
│   ├── architecture-c64client.md# C64 client architecture
│   ├── integration-architecture.md # Integration docs
│   ├── sqlite-database-schema.md# Database schema reference
│   ├── source-tree-analysis.md  # This file
│   ├── system-diagram.png       # System architecture diagram
│   └── project-scan-report.json # Documentation workflow state
│
├── _bmad/                       # BMAD framework (AI development tools)
├── _bmad-output/                # BMAD artifacts
│   ├── planning-artifacts/      # Design documents
│   └── implementation-artifacts/# Tech specs
│
├── README.md                    # Project overview
├── CLAUDE.md                    # Claude Code instructions
├── project-context.md           # AI agent development guide
├── c64uploader                  # Compiled Go binary
└── games.json                   # Legacy data file (unused)
```

## Critical Directories

### uploader/ (Go Server)

**Entry Point:** `main.go`

| File | Purpose | Key Functions |
|------|---------|---------------|
| main.go | CLI routing | `main()`, `run{TUI,Load,FTP,Poke,Server,SQLiteGen,Debug}` |
| server_sqlite.go | Protocol server | `handleC64ConnectionSQLite`, `HandleMenu`, `HandleListPath`, `getLetterGridMenu` |
| apiclient.go | Ultimate API | `runPRG`, `runCRT`, `runDiskImage`, `WriteMemory`, `ReadMemory`, `MenuButton`, `Reboot` |
| db.go | Database layer | Schema, `OpenDB()`, queries |
| tui.go | Terminal UI | Bubbletea model, views |
| index.go | Index loading | `LoadIndex()`, search |
| d64.go | Disk parsing | `ReadD64()`, PRG extraction |
| dbgen_sqlite.go | DB generation | `GenerateSQLiteDB` |
| debug.go | Remote debug | `runDebug`, `injectKey`, `measureScrollRate`, `hexDump`, screen-code decoding |
| spiffy.go | Spiffy HTTP API | `startSpiffyHTTP`, `handlePresets`, `handleSearch`, `handleEntries`, `handleBin` |
| web.go | Mobile web UI handlers | `registerWebRoutes`, `handleIndex`, `apiMenu`, `apiList`, `apiSearch`, `apiInfo`, `apiRun` |

### c64client/src/ (C64 Native)

**Entry Point:** `main.c`

| File | Purpose | Key Components |
|------|---------|----------------|
| main.c | Full application | State machine, UI, protocol |
| ultimate.c | UCI library | TCP, DOS, hardware interface |
| ultimate.h | UCI header | Register definitions, prototypes |

### docs/ (Documentation)

| File | Purpose | Audience |
|------|---------|----------|
| index.md | Master index | All users |
| architecture-*.md | Technical arch | Developers |
| integration-architecture.md | System integration | Developers |
| sqlite-database-schema.md | DB reference | Developers |

## Entry Points

### Go Server

```bash
# Main entry
./c64uploader <command> [flags]

# Commands
./c64uploader tui                            # Terminal UI
./c64uploader server                         # TCP protocol server
./c64uploader load <file|url>                # Upload and run a file
./c64uploader ftp <file|url> <dest>          # Upload via FTP
./c64uploader poke <address>,<value>         # Write a byte via DMA
./c64uploader sqlitegen -assembly64 <path>   # Generate database
./c64uploader debug <sub>                    # Remote debug (screen/press/hold/scroll-rate/peek/reset/reboot/menu/info)
```

### C64 Client

```bash
# Build
cd c64client && make prg

# Run in emulator
make run

# Deploy to Ultimate
U2P_HOST=192.168.1.x make deploy
```

## File Relationships

```
main.go
  ├── imports → db.go (database functions)
  ├── imports → index.go (search index)
  ├── imports → tui.go (TUI mode)
  ├── imports → server_sqlite.go (server mode)
  └── imports → apiclient.go (file execution)

server_sqlite.go
  ├── imports → db.go (queries)
  ├── imports → apiclient.go (RUN command)
  └── imports → d64.go (disk parsing)

dbgen_sqlite.go
  └── imports → db.go (schema, queries)
```

## Build Artifacts

### Go Server

```
uploader/
  └── c64uploader          # Compiled binary (Linux)
```

### C64 Client

```
c64client/build/             # Build output (gitignored)
  ├── a64browser.prg         # PRG executable (16953 bytes)
  ├── a64browser.crt         # CRT16 (currently overflows 16 KB)
  ├── a64browser-ef.crt      # EasyFlash cartridge (16480 bytes, REU-aware subtype 1)
  └── a64browser.d64         # Disk image

c64client/dist/              # Prebuilt artifacts (tracked in git)
  ├── a64browser.prg
  └── a64browser-ef.crt
```

## Configuration Files

| File | Purpose | Format |
|------|---------|--------|
| go.mod | Go dependencies | Go module |
| Makefile | C64 build | Make |
| CLAUDE.md | AI instructions | Markdown |
| project-context.md | Development guide | Markdown |

## Data Files

| File | Location | Purpose |
|------|----------|---------|
| c64uploader.db | Assembly64 dir | SQLite database |
| games.json | Project root | Legacy (unused) |
| *.d64, *.prg, etc. | Assembly64 | Content files |

## Integration Points

```
uploader/server_sqlite.go  ←─────────────→  c64client/src/main.c
        │                     TCP/6465              │
        │                                           │
        ▼                                           ▼
    SQLite DB                               Ultimate II+
   (c64uploader.db)                         (UCI registers)
```
