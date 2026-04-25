# C64 Ultimate Uploader - Documentation Index

> Master documentation index for AI-assisted development

**Generated:** 2026-01-28
**Scan Level:** Exhaustive
**Repository Type:** Multi-part (Go server + C64 native client)

---

## Project Overview

| Property | Value |
|----------|-------|
| **Type** | Multi-part (server + embedded client) |
| **Primary Languages** | Go 1.25, C (Oscar64) |
| **Architecture** | TCP protocol server + native C64 application |
| **Database** | SQLite with FTS5 full-text search |
| **Hardware** | Ultimate II+ / Ultimate 64 cartridge |

### Parts

| Part | Type | Root | Description |
|------|------|------|-------------|
| uploader | CLI/Backend | `uploader/` | Go server with TUI, protocol server, DB generator |
| c64client | Embedded | `c64client/` | Native C64 browser application |

---

## Quick Reference

### Go Server (uploader)

- **Tech Stack:** Go 1.26, Bubbletea, Lipgloss, modernc.org/sqlite
- **Entry Point:** `uploader/main.go`
- **Commands:** `tui`, `server`, `load`, `ftp`, `poke`, `sqlitegen`, `debug`
- **Architecture:** CLI with subcommands + TCP protocol server + HTTP-driven remote debug channel

### C64 Client (c64client)

- **Tech Stack:** Oscar64 C compiler, Ultimate II+ UCI
- **Entry Point:** `c64client/src/main.c`
- **Build:** `make prg` / `make crt` / `make d64`
- **Architecture:** Single-file embedded application

---

## Generated Documentation

### Architecture

- [Project Overview](./project-overview.md) - High-level system description
- [Architecture: Go Server](./architecture-uploader.md) - Server component architecture
- [Architecture: C64 Client](./architecture-c64client.md) - Native client architecture
- [Integration Architecture](./integration-architecture.md) - How parts communicate

### Development

- [Development Guide](./development-guide.md) - Setup, build, test instructions
- [Source Tree Analysis](./source-tree-analysis.md) - Annotated directory structure

### Reference

- [Database Schema](./sqlite-database-schema.md) - SQLite tables and queries
- [Protocol Specification](../uploader/C64PROTOCOL.md) - TCP protocol commands

---

## Existing Documentation

| Document | Location | Description |
|----------|----------|-------------|
| [Main README](../README.md) | Project root | User-facing project overview |
| [C64 Client README](../c64client/README.md) | c64client/ | Client usage guide |
| [Protocol Spec](../uploader/C64PROTOCOL.md) | uploader/ | TCP protocol specification |
| [Project Context](../project-context.md) | Project root | AI agent development guide |
| [Claude Instructions](../CLAUDE.md) | Project root | Claude Code configuration |
| [System Diagram](./system-diagram.png) | docs/ | Architecture diagram |

---

## Getting Started

### For Developers

1. Read [Project Overview](./project-overview.md) for system understanding
2. Review [Integration Architecture](./integration-architecture.md) for component relationships
3. Follow [Development Guide](./development-guide.md) for setup instructions
4. Check [Source Tree Analysis](./source-tree-analysis.md) for code navigation

### For AI Agents

1. Load this index as primary context
2. Reference [Project Context](../project-context.md) for development rules
3. Use architecture docs for component-specific work
4. Check protocol spec before modifying server/client communication

### Quick Commands

```bash
# Build Go server
cd uploader && go build -o c64uploader

# Generate database
./c64uploader sqlitegen -assembly64 /path/to/collection

# Start server
./c64uploader server -db /path/to/c64uploader.db

# Build C64 client
cd c64client && make prg

# Test in VICE
make run
```

---

## Technology Summary

| Category | Technology | Purpose |
|----------|------------|---------|
| Server Language | Go 1.25 | Backend implementation |
| Client Language | C (Oscar64) | Native C64 code |
| TUI Framework | Bubbletea | Terminal user interface |
| Database | SQLite (modernc.org) | Content index with FTS5 |
| Protocol | Custom TCP | Client-server communication |
| Hardware API | UCI | Ultimate II+ Command Interface |
| File Transfer | REST/FTP | Program execution on Ultimate |

---

## Integration Points

| From | To | Method | Purpose |
|------|-----|--------|---------|
| C64 Client | Go Server | TCP/6465 | Protocol commands |
| Go Server | Ultimate II+ | REST API | File execution |
| Go Server | Assembly64 | File system | Content access |
| C64 Client | Ultimate II+ | UCI registers | Network I/O |
| Debug Tool (PC) | Ultimate II+ | HTTP (machine:readmem/writemem/reset) | Remote client driving ($02A7/$02A8 scratch bytes) |

---

## Key Constraints

- **Memory:** C64 has ~38KB usable RAM
- **Items per paginated list page:** 20 (LISTPATH/SEARCH/RELEASES)
- **Items per menu page:** up to 27 (A-Z letter grid); client buffers 32 max
- **Line buffer:** 128 bytes maximum
- **Display:** 40x25 characters
- **Path length:** 64 bytes (menu_path) / 48 bytes (current_category, menu_paths[i])

---

## Related Resources

- [Ultimate II+ Documentation](https://ultimate64.com/Documentation)
- [Oscar64 Compiler](https://github.com/drmortalwombat/oscar64)
- [Assembly64](https://assembly64.com/)
- [Bubbletea Framework](https://github.com/charmbracelet/bubbletea)

---

*Documentation generated by BMAD Document Project workflow*
