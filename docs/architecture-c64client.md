# Architecture: C64 Native Client (c64client)

> Native Commodore 64 application for browsing Assembly64 content via Ultimate II+ network interface.

## Executive Summary

The c64client is a native C64 application compiled with Oscar64 that provides a full-featured browser interface running directly on Commodore 64 hardware. It communicates with the Go server over TCP via the Ultimate II+ Command Interface (UCI).

## Technology Stack

| Category | Technology | Purpose |
|----------|------------|---------|
| Language | C (Oscar64) | C64-optimized C compiler |
| Target | 6502 CPU | Commodore 64 processor |
| Hardware | Ultimate II+ | Network-enabled cartridge |
| Network | TCP/IP | Via UCI API |
| Build | Make | Multi-target build system |
| Testing | VICE (x64sc) | C64 emulator |

## Architecture Pattern

**Single-file Embedded Application with Hardware Abstraction**

```
┌─────────────────────────────────────────────────────┐
│                   main.c (~2330 LOC)                │
│  ┌─────────────────────────────────────────────────┐│
│  │  Application Layer                              ││
│  │  - Menu system, navigation, search              ││
│  │  - VIC-II screen handling                       ││
│  │  - User input processing                        ││
│  └─────────────────────────────────────────────────┘│
│  ┌─────────────────────────────────────────────────┐│
│  │  Protocol Layer                                 ││
│  │  - TCP line buffering                           ││
│  │  - Command/response parsing                     ││
│  │  - Field extraction                             ││
│  └─────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────┐
│           ultimate.c/h (UCI Library)               │
│  - TCP socket management                           │
│  - DOS operations                                  │
│  - Hardware identification                         │
└─────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────┐
│        Ultimate II+ Command Interface (UCI)        │
│        Memory-mapped registers at $DF1C-$DF1F      │
└─────────────────────────────────────────────────────┘
```

## Source Structure

```
c64client/
├── src/
│   ├── main.c        # Main application (~2330 lines)
│   ├── ultimate.c    # UCI library implementation
│   └── ultimate.h    # UCI library header
├── build/            # Output directory
└── Makefile          # Build system
```

## Memory Constraints

**Critical Constants (main.c):**
```c
#define MAX_ITEMS 20         // Items per screen page
#define LINE_BUFFER_SIZE 128 // TCP line buffer
#define MAX_PATH_DEPTH 8     // Navigation stack depth
```

**Per-item Memory:**
- `item_names[20][32]` = 640 bytes
- `menu_paths[20][48]` = 960 bytes
- `item_cats[20][8]` = 160 bytes
- Total per-screen: ~2KB

**Total usable RAM:** ~38KB (C64 has 64KB, minus OS, screen, etc.)

## Key Components

### Main Application (main.c)

**State Management:**
```c
enum AppState {
    STATE_MAIN_MENU,
    STATE_BROWSE_MENU,
    STATE_BROWSE_LIST,
    STATE_SEARCH_RESULTS,
    STATE_RELEASES,
    STATE_INFO,
    STATE_SETTINGS
};
```

**Navigation Stack:**
```c
static char menu_stack[MAX_PATH_DEPTH][48];
static int menu_depth = 0;

void push_path(const char *path);
const char *pop_path(void);
```

**Screen Areas:**
- Title bar (row 0)
- Content area (rows 1-22)
- Status bar (row 24)

### UCI Library (ultimate.c/h)

**Network Functions:**
```c
unsigned char uci_tcp_connect(const char *host, unsigned short port);
unsigned char uci_socket_read(unsigned char socket, unsigned short length);
void uci_socket_write(unsigned char socket, const char *data);
void uci_socket_close(unsigned char socket);
```

**Convenience Functions:**
```c
char uci_tcp_nextchar(unsigned char socket);
int uci_tcp_nextline(unsigned char socket, char *buffer);
```

**DOS Functions:**
```c
unsigned char uci_identify(void);
char* uci_getipaddress(void);
void uci_change_dir(const char *path);
unsigned char uci_open_file(unsigned char attrib, const char *name);
```

### Screen Handling

**VIC-II Direct Access:**
```c
#define SCREEN_RAM  ((unsigned char*)0x0400)
#define COLOR_RAM   ((unsigned char*)0xD800)

void print_at(int x, int y, const char *text);
void clear_line(int y);
void set_color(int x, int y, unsigned char color);
```

**Custom Character Display:**
- Reverse video for selection
- Color coding: Green for trainers, White for normal
- Special characters for indicators (>, +)

### Protocol Communication

**Request Format:**
```c
void send_command(const char *cmd) {
    uci_socket_write(socket, cmd);
    uci_socket_write(socket, "\n");
}
```

**Response Parsing:**
```c
// Read header: "OK <count>" or "ERR <message>"
uci_tcp_nextline(socket, buffer);

// Parse fields: "type|field1|field2|..."
while (uci_tcp_nextline(socket, buffer) > 0) {
    if (buffer[0] == '.') break;  // End marker
    parse_fields(buffer);
}
```

## User Interface

### Main Menu
```
┌──────────────────────────────────┐
│ ASSEMBLY64 BROWSER               │
├──────────────────────────────────┤
│ 1. Browse Categories             │
│ 2. Search                        │
│ 3. Advanced Search               │
│ 4. Settings                      │
│                                  │
│ Q. Quit                          │
└──────────────────────────────────┘
```

### Navigation Keys

| Key | Action |
|-----|--------|
| W/S | Cursor up/down |
| N/P | Next/previous page |
| Enter | Select/Run |
| Del | Go back |
| I | Show info |
| > | View releases |
| Q | Quit |

### Visual Indicators

| Indicator | Meaning |
|-----------|---------|
| `>` (green) | Multiple releases available |
| `+N` (green) | Trainer count |
| `[f]` | Folder item |
| `[b]` | Browse item |
| `[l]` | List item |

## Data Flow

```
┌────────────────────┐
│   User Input       │
│   (keyboard)       │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│   State Machine    │
│   (main.c)         │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐     TCP/6465    ┌────────────────────┐
│   Protocol Layer   │◄───────────────►│   Go Server        │
│   (command/parse)  │                 │   (uploader)       │
└─────────┬──────────┘                 └────────────────────┘
          │
          ▼
┌────────────────────┐
│   UCI Library      │
│   (ultimate.c)     │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│   Ultimate II+     │
│   Hardware         │
└────────────────────┘
```

## Build System

**Targets:**
```makefile
make prg      # Build .prg file (default)
make crt      # Build 16KB cartridge
make d64      # Build disk image (requires c1541)
make run      # Run in VICE emulator
make deploy   # FTP upload to Ultimate
make runprg   # Execute via REST API
make runcrt   # Execute cartridge via REST API
```

**Compiler Flags:**
- `-n` - Native code generation (faster)
- `-O2` - Optimization level 2
- `-tm=c64` - Target machine: Commodore 64
- `-tf=crt16` - 16KB cartridge format

## Configuration

**Compile-time (main.c):**
```c
#define SERVER_HOST "192.168.1.100"
#define SERVER_PORT 6465
```

**Runtime Settings:**
- Server IP (stored in settings)
- Color scheme preferences

## Testing

**In VICE emulator:**
```bash
make run  # Launches x64sc with built PRG
```

**On real hardware:**
1. `make deploy` - Upload via FTP
2. `make runprg` - Execute via REST API

## Performance Considerations

- **Minimal memory footprint:** 20 items max per screen
- **No dynamic allocation:** All buffers statically sized
- **Direct hardware access:** VIC-II and UCI registers
- **Line buffering:** Protocol designed for limited memory
- **Server-enforced limits:** No overflow possible

## Known Limitations

1. **Memory:** 20 items per screen maximum
2. **Line length:** 128 bytes max per protocol line
3. **Path depth:** 8 levels maximum navigation
4. **Network:** Requires Ultimate II+ or Ultimate 64
5. **Display:** 40 columns x 25 rows (standard C64)
