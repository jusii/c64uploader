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

### Main Menu

On startup, the client connects to the server and displays the main menu with these options:

| Key | Action |
|-----|--------|
| **1** | Browse Top 200 Games |
| **2** | Search Games (simple text search) |
| **3** | Browse Categories (Games, Demos, Music) |
| **4** | Advanced Search (filtered search with multiple criteria) |
| **Q** | Quit |

### Navigation Keys

These keys work throughout the application:

| Key | Action |
|-----|--------|
| **W** | Move cursor up |
| **S** | Move cursor down |
| **N** | Next page |
| **P** | Previous page |
| **Enter** | Select / Run entry |
| **Del** | Go back |
| **I** | Show info for selected entry |

### Browsing Lists

When browsing Top 200, search results, or category listings:
- Use **W/S** to move the cursor up and down
- Use **N/P** to page through results (20 items per page)
- Press **Enter** to run the selected game/demo/music
- Press **I** to view detailed information about the entry

### Search

**Simple Search (option 2):**
- Type your search query and press Enter
- Searches both title and group/publisher names
- Results show: `Name | Group | Year | Type`

**Advanced Search (option 4):**
- Filter by multiple criteria using key=value pairs
- Available filters: category, title, group, file type, Top200 status
- Results are grouped by title - entries with multiple releases show a `>` indicator

### Advanced Search Results

In advanced search results, entries display additional indicators:

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
- Press **Del** to go back to search results

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

Edit `main.c` to set your server IP:
```c
#define SERVER_HOST "192.168.1.100"
#define SERVER_PORT 6400
```

## Credits

- Ultimate II+ library ported from [ultimateii-dos-lib](https://github.com/xlar54/ultimateii-dos-lib) by Scott Hutter, Francesco Sblendorio
- Oscar64 compiler by DrMortalWombat
