# Project Overview: C64 Ultimate Uploader

> A bridge system connecting Commodore 64 Ultimate II+ hardware with large Assembly64 software collections.

## What Is This Project?

The C64 Ultimate Uploader enables Commodore 64 users to browse and run programs from the Assembly64 collection directly on their C64 hardware. It provides a native C64 interface that connects via the Ultimate II+ network cartridge to a backend server running on a PC or NAS.

## Key Features

- **Native C64 Interface**: Full-featured browser running on actual C64 hardware
- **Large Collection Support**: Browse 100,000+ entries from Assembly64
- **Multiple Content Types**: Games, Demos, Music (SID), Intros, Graphics, Discmags
- **Full-Text Search**: Fast search across titles and groups
- **Letter Grid Navigation**: A-Z + `#` 3x9 grid picker for entering long browse lists quickly
- **My Files**: Personal directory for user-uploaded PRGs / D64s served over the same protocol
- **Grouped Entries**: See all releases of the same title together
- **Direct Execution**: One-click launch of any program
- **Cartridge Build**: Same source produces a 16 KB autostart `.crt` so the C64 can boot straight into the browser via the Ultimate's cartridge slot (or a flashed EasyFlash) — no PC-side launch step.
- **Remote Debugging**: Drive the native client from the PC (`c64uploader debug`) via the Ultimate HTTP API for screen-peek + key-inject investigations

## System Requirements

### Server Side
- Any computer that can run Go (Linux, macOS, Windows)
- Assembly64 collection (local or network share)
- Network connectivity to Ultimate II+

### Client Side
- Commodore 64 with Ultimate II+ or Ultimate 64
- Network connectivity
- `a64browser.prg` (loadable at runtime) **or** `a64browser.crt` (autostart cartridge)

## Architecture

```
┌─────────────────┐         ┌─────────────────┐
│   Commodore 64  │◄───────►│   Go Server     │
│   + Ultimate    │ TCP/6465│   (uploader/)   │
│                 │         │                 │
│  ┌───────────┐  │         │  ┌───────────┐  │
│  │ C64 Client│  │         │  │  SQLite   │  │
│  │  (native) │  │         │  │  Database │  │
│  └───────────┘  │         │  └───────────┘  │
└─────────────────┘         │        │        │
                            │        ▼        │
                            │  ┌───────────┐  │
                            │  │Assembly64 │  │
                            │  │Collection │  │
                            │  └───────────┘  │
                            └─────────────────┘
```

## Components

### Go Server (uploader/)

| Component | Description |
|-----------|-------------|
| Protocol Server | TCP server handling C64 client requests |
| SQLite Database | Pre-indexed content database with FTS5 search |
| Terminal UI | BubbleTea-based TUI for PC browsing |
| File Execution | REST API/FTP integration with Ultimate |

### C64 Client (c64client/)

| Component | Description |
|-----------|-------------|
| Menu System | Hierarchical navigation via path trimming (no explicit nav stack) |
| Letter Grid | 3x9 A-Z + `#` picker rendered in-place for Browse A-Z folders |
| Search Interface | Simple and advanced search |
| Entry Browser | List view with pagination, auto-repeat scrolling |
| Info Display | Entry details screen |
| Debug Hooks | `$02A7` / `$02A8` scratch bytes let the PC tool drive the client over HTTP |

## Technology Stack

| Part | Technologies |
|------|-------------|
| Server | Go 1.25, Bubbletea, modernc.org/sqlite |
| Client | Oscar64 C compiler, Ultimate II+ UCI |
| Protocol | Custom line-based TCP protocol |
| Database | SQLite with FTS5 full-text search |

## Quick Start

### 1. Generate Database
```bash
cd uploader
go build -o c64uploader
./c64uploader sqlitegen -assembly64 /path/to/assembly64
```

### 2. Start Server
```bash
./c64uploader server -db /path/to/c64uploader.db -assembly64 /path/to/assembly64
```

### 3. Build and Deploy Client
```bash
cd c64client
make prg
U2P_HOST=192.168.1.50 make deploy   # or: ./c64uploader load build/a64browser.prg
```

### 4. Run on C64 and Configure Server
Load `a64browser.prg` on your C64 with Ultimate II+. On first boot the browser shows the **config screen** with diagnostics (Ultimate firmware ID, C64 IP) and three editable fields: `SERVER`, `PORT`, `AUTOSTART`. Use `.SAVE.` to persist to `/flash/config/a64browser.cfg`; once `AUTOSTART=YES` the browser connects silently on subsequent boots. **F1** opens the config screen at any time, **F7** disconnects and pops the Ultimate menu.

## Content Sources

The Assembly64 collection includes content from:

- **Games**: CSDB, Gamebase, OneLoad64, Guybrush
- **Demos**: CSDB, Pouet
- **Music**: HVSC (High Voltage SID Collection)
- **Intros**: CSDB
- **Graphics**: CSDB
- **Discmags**: CSDB

## Documentation Index

- [Architecture: Go Server](./architecture-uploader.md)
- [Architecture: C64 Client](./architecture-c64client.md)
- [Integration Architecture](./integration-architecture.md)
- [Development Guide](./development-guide.md)
- [Protocol Specification](../uploader/C64PROTOCOL.md)
- [Database Schema](./sqlite-database-schema.md)
- [Source Tree](./source-tree-analysis.md)

## Related Resources

- [Ultimate II+ Documentation](https://ultimate64.com/Documentation)
- [Oscar64 Compiler](https://github.com/drmortalwombat/oscar64)
- [Assembly64](https://assembly64.com/)
- [CSDB](https://csdb.dk/)
