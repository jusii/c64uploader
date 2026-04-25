# Assembly64 Browser - C64 Client

Native C64 client for browsing the Assembly64 database via Ultimate II+ network interface.

## Requirements

- **oscar64** compiler - https://github.com/drmortalwombat/oscar64
- **Ultimate II+** or **Ultimate 64** with network enabled
- Optionally: VICE emulator for testing

## Building

```bash
# Build PRG file
make prg

# Build CRT cartridge
make crt

# Build D64 disk image (requires VICE c1541)
make d64
```

## Running

### In VICE emulator
```bash
make run
```

### On real hardware
1. Copy `build/a64browser.prg` to your Ultimate II+ USB drive
2. Or use FTP: `U2P_HOST=192.168.1.x make deploy`

## Project Structure

```
c64client/
├── src/
│   ├── main.c        - Main client application
│   ├── ultimate.h    - Ultimate II+ library header
│   └── ultimate.c    - Ultimate II+ library (ported from cc65)
├── build/            - Output directory
├── Makefile
└── README.md
```

## Ultimate II+ Library

The `ultimate.h/c` library provides access to Ultimate II+ Command Interface:

### Network functions
- `uci_tcp_connect(host, port)` - Connect to TCP server
- `uci_socket_read(socket, length)` - Read from socket
- `uci_socket_write(socket, data)` - Write to socket
- `uci_socket_close(socket)` - Close connection

### Convenience functions
- `uci_tcp_nextchar(socket)` - Read single character
- `uci_tcp_nextline(socket, buffer)` - Read line

### DOS functions
- `uci_identify()` - Check Ultimate presence
- `uci_getipaddress()` - Get IP address
- `uci_change_dir(path)` - Change directory
- `uci_open_file(attrib, name)` - Open file
- etc.

## Usage Guide

### Startup and Connect

On launch you see a splash screen that reports Ultimate detection, the configured server IP, and the C64's IP address:

```
C=CONFIG, ANY OTHER KEY=CONNECT
```

- Press **C** to open Settings and edit the server IP (saved to `/Usb1/a64browser.cfg`)
- Press any other key to connect

### Category Tree

Once connected, you land on the root category list (`ASSEMBLY64 - CATEGORIES`). Navigation in menus:

| Key | Action |
|-----|--------|
| **W / cursor up** | Move cursor up |
| **S / cursor down** | Move cursor down |
| **Enter / cursor right** | Enter category or folder |
| **DEL / cursor left** | Back to parent menu |
| **/** | Open advanced search |
| **C** | Settings |
| **Q** | Quit (root only) |

The tree is: **Category → Source → [Browse A-Z, Top 200, Top 500, ...]**, e.g. `Games → CSDB → Browse A-Z`.

### A-Z Letter Grid

Selecting **Browse A-Z** opens a 27-cell grid (A..Z plus `#` for non-letter titles):

```
> A   B   C   D   E   F   G   H   I
  J   K   L   M   N   O   P   Q   R
  S   T   U   V   W   X   Y   Z   #
```

| Key | Action |
|-----|--------|
| **W / cursor up** | Move up one grid row (-9 cells) |
| **S / cursor down** | Move down one grid row (+9 cells) |
| **cursor right / D** | Move right within the row |
| **cursor left / A** | Move left within the row; on column 0 (A, J, S) wall-bumps back to the source menu |
| **Enter** | Enter the selected letter's entry list |
| **DEL** | Back to source menu |

### Browsing Entry Lists

When viewing a list of entries (from a letter, a Top 200, a search result, etc.):

| Key | Action |
|-----|--------|
| **W/S or cursor keys** | Move cursor; auto-pages at top/bottom |
| **N / P** | Next / previous page (20 per page) |
| **Enter** | Run entry (or open Releases if multiple versions exist) |
| **cursor right** | Open Releases for a grouped entry |
| **I** | Show info (title, group, year, type, top200, rating) |
| **DEL / cursor left** | Back to parent menu |

Entries display additional indicators:

| Indicator | Meaning |
|-----------|---------|
| **>** (green) | Multiple releases — press cursor-right to view them |
| **+N** (green) | Trainer count |
| **&D** | Documentation available |

### Search

- **`/` from root** opens **Advanced Search** with filters for category, source, title, group, and type. Use **W/S** to move between fields, **Space** to toggle/cycle option fields, **Enter** to edit a text field or trigger the search when on `.SEARCH.`.
- Simple search (typing directly in a list page) searches the current view's scope.

### Grouped Entry Indicators

In category browsing and advanced search results, entries display additional indicators:

| Indicator | Meaning |
|-----------|---------|
| **+N** (green) | Trainer count (e.g., +3 means 3 trainers available) |
| **>** (green arrow) | Multiple releases exist - press **>** key to see all releases |

When viewing a grouped entry:
- Press **>** to expand and see all releases of that title
- Each release shows the cracker group and trainer count

### Releases View

When expanding a grouped entry (pressing **>**), you see all releases:
- Shows cracker/release group name
- Displays trainer count (+N) if available
- Press **Enter** to run a specific release
- Press **Del** to go back to the previous list

### Info Screen

Press **I** on any entry to see detailed information:
- Title, Group, Year
- File type and size
- Category
- Top 200 rank (if applicable)
- Trainer information (for games)

Press any key to return to the previous screen.

### Running Programs

When you press Enter on an entry:
1. The server uploads the file to your Ultimate II+
2. The program is automatically executed
3. Different file types are handled appropriately:
   - **PRG**: Loaded and run directly
   - **D64/G64/D71/D81**: Disk mounted, first program auto-loaded
   - **CRT**: Cartridge mounted
   - **SID**: Music played via Ultimate's SID player

### Tips

- The client remembers your position when paging through results
- Search is case-insensitive
- In advanced search, use `top200=1` to show only Top 200 entries
- Trainer indicators help you find versions with cheats/trainers

## Server Protocol

See [`../uploader/C64PROTOCOL.md`](../uploader/C64PROTOCOL.md) for details.

## Configuration

Default server host is set in `main.c`:
```c
#define DEFAULT_SERVER_HOST "192.168.2.66"
#define SERVER_PORT 6465
#define SETTINGS_FILE "/Usb1/a64browser.cfg"
```

Users typically change the server IP at runtime via the Settings screen (press **C** on the splash screen) rather than by recompiling. The setting is persisted to the Ultimate's filesystem and reloaded on next launch.

## Debug Hooks

The client reserves two KERNAL scratch bytes for remote driving via the Ultimate's HTTP API (see `c64uploader debug` in the top-level README):

| Address | Name | Purpose |
|---------|------|---------|
| `$02A7` | `DEBUG_KEY_INJECT` | Single-shot key press consumed by `get_key()` / `wait_key()` |
| `$02A8` | `DEBUG_HOLD_SCAN` | Simulated matrix-level held key (bypasses `keyb_poll()`) |

Both bytes are zero in normal operation. They let a PC tool peek the text screen, inject keys, and measure auto-repeat timing without physical access to the keyboard.

## Credits

- Ultimate II+ library ported from [ultimateii-dos-lib](https://github.com/xlar54/ultimateii-dos-lib) by Scott Hutter, Francesco Sblendorio
- Oscar64 compiler by DrMortalWombat
