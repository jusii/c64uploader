# Assembly64 Browser - C64 Client

Native C64 client for browsing the Assembly64 database via Ultimate II+ network interface.

## Requirements

- **oscar64** compiler - https://github.com/drmortalwombat/oscar64
- **Ultimate II+** or **Ultimate 64** with network enabled
- Optionally: VICE emulator for testing

## Building

```bash
# Build PRG file (recommended for FTP/load workflow)
make prg

# Build 16 KB CRT cartridge image (autostart)
make crt

# Build D64 disk image (requires VICE c1541)
make d64
```

Both `prg` and `crt` are produced from the same source; `make crt` adds
`-tf=crt16` to package the binary as a 16 KB autostart cartridge image.
`-dNOFLOAT` is on by default (we never format floats, and dropping the
oscar64 float-printf helpers saves ~1.6 KB so the image fits the 16 KB
cart slot).

### Notes on the cart variant

- The cart contains exactly the same browser as the .prg. There is no
  feature gap.
- Cart targets bypass the C64 KERNAL boot path; the program therefore
  initializes the VIC chip (display on, text mode, default screen
  pointers) and runs `init_state()` to set the few non-zero defaults
  at runtime. Static variables with explicit initializers cannot be
  used in cart builds because oscar64's CRT16 runtime keeps the data
  section in cart ROM (read-only); see [c64client/src/main.c](src/main.c)
  for the pattern.
- 16 KB is a hard limit on the cart slot — keep an eye on the .prg
  size (it tracks .crt-content size) when adding code.

## Running

### In VICE emulator

```bash
make run                # launches x64sc with the .prg
```

### On real hardware — three options

```bash
# 1. Upload the .prg to the Ultimate's filesystem and load it from BASIC
U2P_HOST=192.168.1.x make deploy

# 2. Run the .prg directly via the Ultimate REST API (one-shot)
U2P_HOST=192.168.1.x make runprg

# 3. Run the .crt as a cartridge via the Ultimate REST API
U2P_HOST=192.168.1.x make runcrt

# Equivalent to #3 using the c64uploader CLI
./c64uploader load -host <ultimate-ip> build/a64browser.crt
```

The cartridge form factor is what you want if you ever flash an
EasyFlash / KFF / similar — the C64 boots straight into the browser
on power-on with no PC involvement.

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

On launch the browser silently probes the Ultimate (firmware ID + own IP), loads `/flash/config/a64browser.cfg`, and:

- if `AUTOSTART=YES` and the saved server is reachable → connects and lands on the root category list
- otherwise → shows the **config screen** with diagnostics at the top and editable rows for `SERVER`, `PORT`, `AUTOSTART`, plus `.CONNECT.` and `.SAVE.` actions. Any connection error is printed in the status bar so you know what to fix.

```
ASSEMBLY64 (LOCAL)

ULTIMATE-II DOS V1.2
IP: 192.168.2.64

> SERVER:    192.168.2.66
  PORT:      6465
  AUTOSTART: YES
  .CONNECT.
  .SAVE.
```

| Key | Action |
|-----|--------|
| **W / cursor up**, **S / cursor down** | Move between fields |
| **Enter** on `SERVER` / `PORT` | Edit value (Enter again commits, DEL erases a character) |
| **Space** on `AUTOSTART` | Toggle YES / NO |
| **Enter** on `.CONNECT.` | Connect with current in-memory values (does not write to disk) |
| **Enter** on `.SAVE.` | Write the config file and connect |
| **F1** | Open config from any other page |
| **F7** | Exit — disconnect and pop the Ultimate menu |

The config file is plain text:
```
192.168.2.66
6465
1
```
(host, port, autostart 0/1). It lives at `/flash/config/a64browser.cfg`, which matches the prkl/Spiffy convention; the directory is auto-created on first save.

### Category Tree

Once connected, you land on the root category list (`ASSEMBLY64 - CATEGORIES`). Navigation in menus:

| Key | Action |
|-----|--------|
| **W / cursor up** | Move cursor up |
| **S / cursor down** | Move cursor down |
| **Enter / cursor right** | Enter category or folder |
| **DEL / cursor left** | Back to parent menu |
| **/** | Open search (from root) |
| **F1** | Open config screen |
| **F7** | Exit (disconnect and pop the Ultimate menu) |

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

Press **`/`** from the root menu to open search. The cursor starts in the input box; type to build a query (minimum 3 characters), Tab cycles the category filter (All / Games / Demos / Music). **Enter** or cursor-down switches to the result list; cursor-up at the top of the results (or **DEL**) returns to the input box. Two-mode design keeps held letters from corrupting the query during result navigation.

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

Compile-time defaults in `main.c`:
```c
#define DEFAULT_SERVER_HOST "192.168.2.66"
#define DEFAULT_SERVER_PORT 6465
#define SETTINGS_FILE       "/flash/config/a64browser.cfg"
```

Users change settings at runtime via the config screen (F1) — server host, port, and autostart are persisted to `/flash/config/a64browser.cfg` and reloaded on next launch. Only the compile-time defaults need recompilation.

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
