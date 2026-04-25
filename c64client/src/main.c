/*****************************************************************
 * Assembly64 Browser - C64 Client
 *
 * Native C64 client for browsing Assembly64 database via
 * Ultimate II+ network interface.
 *****************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <c64/vic.h>
#include <c64/keyboard.h>
#include "ultimate.h"

// Server configuration
#define DEFAULT_SERVER_HOST "192.168.2.66"
#define SERVER_PORT 6465  // Native protocol port
#define SETTINGS_FILE "/Usb1/a64browser.cfg"

// Settings structure
static char server_host[32] = DEFAULT_SERVER_HOST;

// Screen dimensions
#define SCREEN_WIDTH  40
#define SCREEN_HEIGHT 25
#define LIST_HEIGHT   18  // Lines available for list display

// UI state
static byte socket_id = 0;
static bool connected = false;

// Pages: 0=cats, 1=list, 2=search, 3=settings, 6=info, 7=releases.
// Page 4 / 5 (advanced search) are gone — replaced by the simple typed-query
// search at PAGE_SEARCH that drives the existing server SEARCH command.
#define PAGE_CATS        0
#define PAGE_LIST        1
#define PAGE_SEARCH      2
#define PAGE_SETTINGS    3
#define PAGE_INFO        6
#define PAGE_RELEASES    7

// Navigation uses path trimming - no stack needed
// The menu path hierarchy IS the navigation history:
//   "" -> "Games" -> "Games/CSDB" -> entries
// Going back = trim last path component

// Menu/list state. 27 must fit (A-Z + '#' letter grid); server still pages
// regular lists at 20 entries per page, so headroom here is cheap.
#define MAX_ITEMS 32
static char item_names[MAX_ITEMS][32];
static long item_ids[MAX_ITEMS];
static int  item_count = 0;
static long total_count = 0;
static int  cursor = 0;
static int  offset = 0;
static int  current_page = PAGE_CATS;

// Current category
static char current_category[48];  // Path for LISTPATH/RELEASES

// Menu navigation state
static char menu_path[64];              // Current path like "Games/CSDB/All"
static char menu_paths[MAX_ITEMS][48];  // Path for each menu item
static char menu_types[MAX_ITEMS];      // 'f'=folder, 'l'=list

// Forward declarations for navigation functions
void go_back(void);
void draw_list(const char *title);
void draw_releases(void);
void do_releases(const char *category, const char *title, int start);
void run_myfile(const char *path);
static bool is_letter_grid(void);
void update_letter_grid_cursor(int old_cursor, int new_cursor);

// Simple search state. Server SEARCH command takes "<offset> <count>
// [category] <query>" and returns id|name|group|year|type rows. Tab (C= key
// in PETSCII, scancode 0x0F) cycles search_category through these labels.
static const char *search_cat_names[] = {"All", "Games", "Demos", "Music"};
static char search_query[24];
static byte search_query_len = 0;
static byte search_category = 0;
// Debounce: every typed/deleted char in the search box updates the input
// row immediately for visual feedback but defers the server SEARCH command
// until JIFFY_LOW reaches search_due_jiffy. Each new keystroke pushes the
// deadline forward, so a quick burst of typing/deleting only fires one query.
#define SEARCH_DEBOUNCE_JIFFIES 100  // ~2s of quiet before the query fires
#define SEARCH_MIN_QUERY_LEN     3  // server SEARCH only fires once query is this long
static bool search_pending = false;
static byte search_due_jiffy = 0;

// Settings edit state
static int  settings_cursor = 0;  // Which setting is selected
static int  settings_edit_pos = 0;  // Cursor position in edit field
static bool settings_editing = false;  // Are we editing a field?

// Line buffer for protocol
static char line_buffer[128];

// Info screen state
static int info_return_page = PAGE_CATS;  // Page to return to after info
#define MAX_INFO_LINES 12
static char info_labels[MAX_INFO_LINES][8];   // "NAME", "GROUP", etc.
static char info_values[MAX_INFO_LINES][32];  // The values
static int  info_line_count = 0;

// Grouped results state (for advanced search)
static int  item_counts[MAX_ITEMS];    // Release count per grouped entry
static char item_cats[MAX_ITEMS][8];   // Category per grouped entry
static int  item_trainers[MAX_ITEMS];  // Trainer count per entry (-1=unknown, 0=none, >0=count)

// Releases page state
static char releases_title[32];        // Title being viewed
static char releases_category[48];     // Path or category of releases
static int  releases_return_page = PAGE_LIST;  // Where to return (PAGE_LIST or PAGE_SEARCH)
static int  releases_return_offset = 0;  // Offset to restore when returning
static int  releases_return_cursor = 0;  // Cursor position within page to restore

// When entering a LIST from a menu (including the A-Z letter grid), remember
// where the cursor was so go_back can put it back rather than snap to item 0.
static int  menu_return_cursor = 0;

// VIC chip at $D000
#define vic (*(struct VIC *)0xd000)

// Screen memory
#define SCREEN_RAM ((char*)0x0400)
#define COLOR_RAM  ((char*)0xD800)

//-----------------------------------------------------------------------------
// Screen utilities
//-----------------------------------------------------------------------------

void clear_screen(void)
{
    memset(SCREEN_RAM, ' ', 1000);
    memset(COLOR_RAM, 14, 1000);  // Light blue
}

void print_at(byte x, byte y, const char *text)
{
    char *pos = SCREEN_RAM + y * 40 + x;
    while (*text)
    {
        char c = *text++;
        // Convert ASCII to PETSCII screen codes
        if (c >= 'a' && c <= 'z')
            c = c - 'a' + 1;
        else if (c >= 'A' && c <= 'Z')
            c = c - 'A' + 1;
        else if (c == '|')
            c = ' ';  // Replace pipe separator with space
        *pos++ = c;
    }
}

void print_at_color(byte x, byte y, const char *text, byte color)
{
    char *pos = SCREEN_RAM + y * 40 + x;
    char *col = COLOR_RAM + y * 40 + x;
    while (*text)
    {
        char c = *text++;
        if (c >= 'a' && c <= 'z')
            c = c - 'a' + 1;
        else if (c >= 'A' && c <= 'Z')
            c = c - 'A' + 1;
        else if (c == '|')
            c = ' ';
        *pos++ = c;
        *col++ = color;
    }
}

void clear_line(byte y)
{
    memset(SCREEN_RAM + y * 40, ' ', 40);
}

void print_status(const char *msg)
{
    clear_line(24);
    print_at(0, 24, msg);
}

//-----------------------------------------------------------------------------
// Settings
//-----------------------------------------------------------------------------

void load_settings(void)
{
    // Make sure we're targeting DOS
    uci_settarget(UCI_TARGET_DOS1);

    // Try to open settings file for reading
    uci_open_file(0x01, SETTINGS_FILE);  // 0x01 = read
    if (!uci_success())
        return;  // No settings file, use defaults

    // Read server host
    uci_read_file(31);

    // Wait for data to be available (with timeout)
    int timeout = 1000;
    while (!uci_isdataavailable() && timeout > 0)
        timeout--;

    int len = uci_readdata();
    uci_readstatus();
    uci_accept();

    if (len > 0)
    {
        // Copy until newline or end
        int i = 0;
        while (i < 31 && i < len && uci_data[i] != 0 && uci_data[i] != '\n' && uci_data[i] != '\r')
        {
            server_host[i] = uci_data[i];
            i++;
        }
        server_host[i] = 0;
    }

    uci_close_file();
}

void save_settings(void)
{
    // Make sure we're targeting DOS, not network
    uci_settarget(UCI_TARGET_DOS1);

    // Delete existing file first (ignore errors)
    uci_delete_file(SETTINGS_FILE);

    // Open settings file for writing (0x06 = create + write)
    uci_open_file(0x06, SETTINGS_FILE);
    if (!uci_success())
        return;

    // Write server host
    uci_write_file((uint8_t*)server_host, strlen(server_host));
    uci_close_file();
}

//-----------------------------------------------------------------------------
// Network
//-----------------------------------------------------------------------------

bool connect_to_server(void)
{
    print_status("connecting...");

    socket_id = uci_tcp_connect(server_host, SERVER_PORT);

    if (!uci_success())
    {
        print_status("connect failed!");
        return false;
    }

    connected = true;

    // Read greeting line "OK c64uploader"
    uci_tcp_nextline(socket_id, line_buffer, sizeof(line_buffer));

    print_status("connected!");
    return true;
}

void disconnect_from_server(void)
{
    if (connected)
    {
        uci_socket_write(socket_id, "QUIT\n");
        uci_socket_close(socket_id);
        connected = false;
    }
}

//-----------------------------------------------------------------------------
// Protocol
//-----------------------------------------------------------------------------

// Forward declarations
void load_list_path(const char *path, int start);

// Check if server response is an error
static bool is_error_response(void)
{
    return line_buffer[0] == 'E' && line_buffer[1] == 'R';
}

void send_command(const char *cmd)
{
    if (!connected)
        return;
    uci_socket_write(socket_id, cmd);
    uci_socket_write_char(socket_id, '\n');
}

// Read a line from server, returns length
int read_line(void)
{
    return uci_tcp_nextline(socket_id, line_buffer, sizeof(line_buffer));
}

// Parse "OK n total" response, returns n
int parse_ok_count(void)
{
    // line_buffer contains "OK n total"
    char *p = line_buffer + 3;  // Skip "OK "
    return atoi(p);
}

// Load menu from server and display it
// Sets menu_path, item_names, menu_paths, menu_types, item_count
void load_menu(const char *path)
{
    // Callers typically pass menu_paths[cursor] as `path`, and the parser
    // loop below overwrites menu_paths[] with the new server response. Snapshot
    // into a local buffer so the final strncpy into menu_path survives.
    char saved_path[64];
    strncpy(saved_path, path, 63);
    saved_path[63] = 0;

    print_status("loading...");

    // Build MENU command
    char cmd[80];
    if (saved_path[0])
        sprintf(cmd, "MENU %s", saved_path);
    else
        strcpy(cmd, "MENU");

    send_command(cmd);
    read_line();  // "OK n"

    if (is_error_response())
    {
        item_count = 0;
        total_count = 0;
        print_status(line_buffer);
        return;
    }

    item_count = 0;
    total_count = parse_ok_count();

    // Read menu lines until "."
    // Format: type|name|path|count
    while (item_count < MAX_ITEMS)
    {
        read_line();
        if (line_buffer[0] == '.')
            break;

        // Parse "type|name|path|count"
        char *type = line_buffer;
        char *name = strchr(type, '|');
        if (!name) continue;
        *name++ = 0;

        char *mpath = strchr(name, '|');
        if (!mpath) continue;
        *mpath++ = 0;

        char *count = strchr(mpath, '|');
        if (!count) continue;
        *count++ = 0;

        strncpy(item_names[item_count], name, 31);
        item_names[item_count][31] = 0;
        strncpy(menu_paths[item_count], mpath, 47);
        menu_paths[item_count][47] = 0;
        menu_types[item_count] = type[0];  // 'f' or 'l'
        item_ids[item_count] = atol(count);  // Store count
        item_count++;
    }

    // Save current path (from our snapshot, since menu_paths[] was rewritten)
    strncpy(menu_path, saved_path, 63);
    menu_path[63] = 0;

    cursor = 0;
    offset = 0;
    current_page = PAGE_CATS;
    print_status("ready");
}

// Trim last path component: "Games/CSDB" -> "Games", "Games" -> ""
static void trim_path(char *path)
{
    char *last = strrchr(path, '/');
    if (last)
        *last = 0;
    else
        path[0] = 0;
}

// Navigate back - uses path hierarchy instead of a stack
// Menu paths are hierarchical: "" -> "Games" -> "Games/CSDB"
// Going back = trim last component and reload
void go_back(void)
{
    if (current_page == PAGE_RELEASES)
    {
        // Releases -> back to entry list. Restore both the page offset and
        // the cursor position so the user lands on the same row they entered
        // releases from (load_list_path resets cursor to 0, so set it after).
        load_list_path(current_category, releases_return_offset);
        if (releases_return_cursor < item_count)
            cursor = releases_return_cursor;
        current_page = PAGE_LIST;
        draw_list(current_category);
    }
    else if (current_page == PAGE_LIST)
    {
        // Entry list -> back to parent menu. menu_path was set by the last
        // successful load_menu (the parent we came from), so just reload it.
        // Works whether the list lives directly under that menu (old Browse
        // A-Z) or one level deeper (new A-Z/letter layout), and avoids the
        // invalid "MENU Category/Source/A-Z/K" call that would stall the
        // client because the server has no menu at that leaf path.
        load_menu(menu_path);
        if (menu_return_cursor < item_count)
            cursor = menu_return_cursor;
        draw_list(menu_path[0] ? menu_path : "assembly64 - categories");
    }
    else if (current_page == PAGE_CATS)
    {
        // Menu -> back to parent menu (trim path)
        if (menu_path[0] == 0)
            return;  // Already at root, can't go back

        trim_path(menu_path);
        load_menu(menu_path);
        draw_list(menu_path[0] ? menu_path : "assembly64 - categories");
    }
}

// Reset to root menu
void load_categories(void)
{
    load_menu("");
}

// Load entries by path using LISTPATH command
void load_list_path(const char *path, int start)
{
    print_status("loading...");

    char cmd[96];
    sprintf(cmd, "LISTPATH %d 20 %s", start, path);
    send_command(cmd);
    read_line();  // "OK n total"

    if (is_error_response())
    {
        item_count = 0;
        total_count = 0;
        cursor = 0;
        print_status(line_buffer);
        return;
    }

    // Parse "OK n total"
    char *p = line_buffer + 3;
    int n = atoi(p);
    p = strchr(p, ' ');
    if (p)
        total_count = atol(p + 1);

    item_count = 0;
    offset = start;

    // Read entry lines until "."
    // Format: ID|Name|Category|Count|Trainers (grouped by title)
    while (item_count < MAX_ITEMS && item_count < n)
    {
        read_line();
        if (line_buffer[0] == '.')
            break;

        char *id_str = line_buffer;
        char *name = strchr(id_str, '|');
        if (!name) continue;
        *name++ = 0;

        char *cat = strchr(name, '|');
        if (!cat) continue;
        *cat++ = 0;

        char *count = strchr(cat, '|');
        if (!count) continue;
        *count++ = 0;

        char *trainers = strchr(count, '|');
        if (trainers) *trainers++ = 0;

        item_ids[item_count] = atol(id_str);
        strncpy(item_names[item_count], name, 31);
        item_names[item_count][31] = 0;
        strncpy(item_cats[item_count], cat, 7);
        item_cats[item_count][7] = 0;
        item_counts[item_count] = atoi(count);  // Number of releases
        item_trainers[item_count] = trainers ? atoi(trainers) : -1;
        item_count++;
    }

    cursor = 0;
    print_status("ready");
}

// Run selected entry
void run_entry(long id)
{
    print_status("running...");

    char cmd[32];
    sprintf(cmd, "RUN %ld", id);
    send_command(cmd);

    read_line();  // "OK Running xxx" or "ERR xxx"
    print_status(line_buffer);
}

// Run file from MYFILES directory
void run_myfile(const char *path)
{
    print_status("running...");

    char cmd[64];
    sprintf(cmd, "RUNFILE %s", path);
    send_command(cmd);

    read_line();  // "OK Running xxx" or "ERR xxx"
    print_status(line_buffer);
}

// Drive the existing server SEARCH command. Response is one row per result,
// "id|name|group|year|type" — we only render id+name; the rest is dropped on
// the floor. category=0 ("All") sends no category arg, so the server runs
// across all categories.
void do_search(const char *query, int start)
{
    char cmd[64];
    if (search_category == 0)
        sprintf(cmd, "SEARCH %d 20 %s", start, query);
    else
        sprintf(cmd, "SEARCH %d 20 %s %s", start, search_cat_names[search_category], query);
    send_command(cmd);
    read_line();
    if (is_error_response()) {
        item_count = 0;
        total_count = 0;
        cursor = 0;
        print_status(line_buffer);
        return;
    }
    char *p = line_buffer + 3;
    int n = atoi(p);
    p = strchr(p, ' ');
    if (p)
        total_count = atol(p + 1);
    item_count = 0;
    offset = start;
    while (item_count < MAX_ITEMS && item_count < n) {
        read_line();
        if (line_buffer[0] == '.')
            break;
        char *id_str = line_buffer;
        char *name = strchr(id_str, '|');
        if (!name)
            continue;
        *name++ = 0;
        item_ids[item_count] = atol(id_str);
        char *end = strchr(name, '|');
        if (end)
            *end = 0;
        strncpy(item_names[item_count], name, 31);
        item_names[item_count][31] = 0;
        item_count++;
    }
    {
        int safety = 100;
        while (line_buffer[0] != '.' && safety-- > 0)
            read_line();
    }
    cursor = 0;
}

// Fetch releases for a specific title
void do_releases(const char *category, const char *title, int start)
{
    print_status("loading releases...");

    // Save title and category/path for display
    strncpy(releases_title, title, 31);
    releases_title[31] = 0;
    strncpy(releases_category, category, 47);
    releases_category[47] = 0;

    // Build command: "RELEASES offset count category title"
    char cmd[128];
    sprintf(cmd, "RELEASES %d 20 %s %s", start, category, title);

    send_command(cmd);
    read_line();  // "OK n total"

    if (is_error_response())
    {
        item_count = 0;
        total_count = 0;
        cursor = 0;
        print_status(line_buffer);
        return;
    }

    // Parse "OK n total"
    char *p = line_buffer + 3;
    int n = atoi(p);
    p = strchr(p, ' ');
    if (p)
        total_count = atol(p + 1);

    item_count = 0;
    offset = start;

    // Read entry lines until "."
    // Releases format: "id|group|year|type|trainers"
    while (item_count < MAX_ITEMS && item_count < n)
    {
        read_line();
        if (line_buffer[0] == '.')
            break;

        // Parse "id|group|year|type|trainers"
        char *id_str = line_buffer;
        char *grp = strchr(id_str, '|');
        if (grp)
        {
            *grp++ = 0;
            item_ids[item_count] = atol(id_str);

            // Find year (next |)
            char *year = strchr(grp, '|');
            if (year)
            {
                *year++ = 0;
                // Find type (next |)
                char *type = strchr(year, '|');
                if (type)
                {
                    *type++ = 0;
                    // Find trainers (next |)
                    char *trn = strchr(type, '|');
                    if (trn)
                    {
                        *trn++ = 0;
                        item_trainers[item_count] = atoi(trn);
                    }
                    else
                    {
                        item_trainers[item_count] = -1;
                    }
                }
                else
                {
                    item_trainers[item_count] = -1;
                }
            }
            else
            {
                item_trainers[item_count] = -1;
            }

            // Display group name
            strncpy(item_names[item_count], grp, 31);
            item_names[item_count][31] = 0;
            item_count++;
        }
    }

    // Consume remaining lines until "."
    {
        int safety = 100;
        while (line_buffer[0] != '.' && safety-- > 0)
            read_line();
    }

    cursor = 0;
    print_status("ready");
}

// Fetch info for an entry
bool fetch_info(long id)
{
    print_status("loading info...");

    char cmd[32];
    sprintf(cmd, "INFO %ld", id);
    send_command(cmd);
    read_line();  // "OK" or "ERR ..."

    if (line_buffer[0] == 'E')
    {
        print_status(line_buffer);
        return false;
    }

    info_line_count = 0;

    // Read field lines until "."
    while (info_line_count < MAX_INFO_LINES)
    {
        read_line();
        if (line_buffer[0] == '.')
            break;

        // Parse "LABEL|value"
        char *sep = strchr(line_buffer, '|');
        if (sep)
        {
            *sep = 0;
            // Only add if value is non-empty
            if (sep[1] != 0)
            {
                strncpy(info_labels[info_line_count], line_buffer, 7);
                info_labels[info_line_count][7] = 0;
                strncpy(info_values[info_line_count], sep + 1, 31);
                info_values[info_line_count][31] = 0;
                info_line_count++;
            }
        }
    }

    // Consume any remaining lines
    {
        int safety = 100;
        while (line_buffer[0] != '.' && safety-- > 0)
            read_line();
    }

    print_status("ready");
    return info_line_count > 0;
}

//-----------------------------------------------------------------------------
// Keyboard input
//-----------------------------------------------------------------------------

// Debug injection: uploader writes a semantic key code into $02A7 (reserved
// unused KERNAL scratch byte) and get_key() consumes it as if the user pressed
// a key. Non-zero value is returned verbatim and then cleared.
#define DEBUG_KEY_INJECT (*(volatile byte *)0x02A7)

// Debug hold-key: if $02A8 is non-zero, pretend that scancode (low 6 bits,
// bit 6 = shift qualifier) is being held on the keyboard matrix. Lets the
// uploader measure auto-repeat timing without a physical key press.
#define DEBUG_HOLD_SCAN (*(volatile byte *)0x02A8)

// Press-then-auto-repeat state. Jiffy clock low byte at $A2 ticks at 50 Hz
// PAL and wraps every ~5s; all comparisons use modular byte arithmetic, so
// short intervals (<128 ticks) behave correctly across wrap.
#define JIFFY_LOW  (*(volatile byte *)0xA2)
#define KEY_INITIAL_DELAY 20  // ~400ms between fresh press and first auto-repeat
#define KEY_REPEAT_RATE    4  // ~80ms between repeats (~12 Hz)

static byte last_key_scan = 0xFF;  // 0xFF = no key being tracked
static byte next_fire_jiffy = 0;

char get_key(void)
{
    byte injected = DEBUG_KEY_INJECT;
    if (injected)
    {
        DEBUG_KEY_INJECT = 0;
        // Drop physical tracking so a held key after injection doesn't
        // immediately auto-repeat on the same scancode.
        last_key_scan = 0xFF;
        return (char)injected;
    }

    byte k;
    bool shift;
    byte hold = DEBUG_HOLD_SCAN;
    if (hold)
    {
        // Simulated held key: skip matrix poll entirely.
        k = hold & 0x3f;
        shift = (hold & 0x40) != 0;

        byte now = JIFFY_LOW;
        if (k != last_key_scan)
        {
            last_key_scan = k;
            next_fire_jiffy = now + KEY_INITIAL_DELAY;
        }
        else
        {
            if ((byte)(now - next_fire_jiffy) >= 128)
                return 0;
            next_fire_jiffy = now + KEY_REPEAT_RATE;
        }
    }
    else
    {
        keyb_poll();

        // Oscar64's keyb_poll() is an edge detector: keyb_key is only non-zero
        // on the frame a key transitions from up to down. For held-key auto-
        // repeat we have to check keyb_matrix (level state) via key_pressed().
        byte now = JIFFY_LOW;

        if (keyb_key & KSCAN_QUAL_DOWN)
        {
            // Fresh press edge: fire immediately, arm initial delay.
            k = keyb_key & 0x3f;
            shift = (keyb_key & KSCAN_QUAL_SHIFT) != 0;
            last_key_scan = k;
            next_fire_jiffy = now + KEY_INITIAL_DELAY;
        }
        else if (last_key_scan != 0xFF && key_pressed(last_key_scan))
        {
            // Same scan code still held. Only the pure-navigation keys
            // auto-repeat — held letter keys must NOT spam the search box
            // with duplicate characters, and held action keys (Enter, DEL,
            // /, Q, C) shouldn't either. Cursor up/down/left/right and W/S
            // cover all the cases where holding actually helps (list scroll,
            // grid scroll).
            if (last_key_scan != KSCAN_W && last_key_scan != KSCAN_S &&
                last_key_scan != KSCAN_CSR_DOWN && last_key_scan != KSCAN_CSR_RIGHT)
                return 0;
            if ((byte)(now - next_fire_jiffy) >= 128)
                return 0;
            next_fire_jiffy = now + KEY_REPEAT_RATE;
            k = last_key_scan;
            shift = key_shift();
        }
        else
        {
            // Released or no key at all: drop tracking.
            last_key_scan = 0xFF;
            return 0;
        }
    }

    {
        // Always handle these
        if (k == KSCAN_RETURN) return '\r';
        if (k == KSCAN_DEL) return 8;  // Backspace

        // In category menu
        if (current_page == PAGE_CATS)
        {
            if (is_letter_grid())
            {
                // Grid mode: cursor right/left navigate the grid instead of
                // entering a folder / going back. Back still works via DEL.
                if (k == KSCAN_W || (k == KSCAN_CSR_DOWN && shift)) return 'u';
                if (k == KSCAN_S || k == KSCAN_CSR_DOWN) return 'd';
                if (k == KSCAN_CSR_RIGHT && !shift) return 'r';
                if (k == KSCAN_CSR_RIGHT && shift) return 'l';
                if (k == KSCAN_A) return 'l';
                if (k == KSCAN_D) return 'r';
            }
            else
            {
                if (k == KSCAN_Q) return 'q';
                if (k == KSCAN_C) return 'c';  // Settings
                if (k == KSCAN_W) return 'u';
                if (k == KSCAN_CSR_DOWN && shift) return 'u';
                if (k == KSCAN_S || k == KSCAN_CSR_DOWN) return 'd';
                if (k == KSCAN_SLASH) return '/';
                if (k == KSCAN_CSR_RIGHT && !shift) return '>';  // Right = enter category
                if (k == KSCAN_CSR_RIGHT && shift) return 8;  // Left = back
            }
        }
        // In list view
        else if (current_page == PAGE_LIST)
        {
            if (k == KSCAN_W || (k == KSCAN_CSR_DOWN && shift)) return 'u';
            if (k == KSCAN_S || k == KSCAN_CSR_DOWN) return 'd';
            if (k == KSCAN_N) return 'n';
            if (k == KSCAN_P) return 'p';
            if (k == KSCAN_I) return 'i';  // Info
            if (k == KSCAN_CSR_RIGHT && !shift) return '>';  // Right = releases
            if (k == KSCAN_CSR_RIGHT && shift) return 8;  // Left = back
        }
        // In settings
        else if (current_page == PAGE_SETTINGS)
        {
            if (!settings_editing)
            {
                if (k == KSCAN_W || (k == KSCAN_CSR_DOWN && shift)) return 'u';
                if (k == KSCAN_S || k == KSCAN_CSR_DOWN) return 'd';
                if (k == KSCAN_CSR_RIGHT && shift) return 8;  // Left = back
            }
            else
            {
                // Editing mode - return typed characters
                if (k < 64)
                {
                    byte c = (byte)keyb_codes[shift ? k + 64 : k];
                    if (c >= '0' && c <= '9') return c;
                    if (c == '.') return '.';
                }
            }
        }
        // In simple search (typed query + result list)
        else if (current_page == PAGE_SEARCH)
        {
            if (k == KSCAN_CSR_RIGHT && shift) return 8;  // Left = back
            if (k == 0x0F) return '\t';  // C= = cycle category
            if (item_count > 0) {
                if (k == KSCAN_W || (k == KSCAN_CSR_DOWN && shift)) return 'u';
                if (k == KSCAN_S || k == KSCAN_CSR_DOWN) return 'd';
                if (k == KSCAN_N) return 'n';
                if (k == KSCAN_P) return 'p';
                if (k == KSCAN_I) return 'i';
                if (k == KSCAN_CSR_RIGHT && !shift) return '\r';
            }
            if (k < 64) {
                byte c = (byte)keyb_codes[shift ? k + 64 : k];
                if (c >= 'a' && c <= 'z') return c - 32;
                if ((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9')) return c;
            }
        }
        // In releases page
        else if (current_page == PAGE_RELEASES)
        {
            if (k == KSCAN_W || (k == KSCAN_CSR_DOWN && shift)) return 'u';
            if (k == KSCAN_S || k == KSCAN_CSR_DOWN) return 'd';
            if (k == KSCAN_N) return 'n';
            if (k == KSCAN_P) return 'p';
            if (k == KSCAN_I) return 'i';  // Info
            if (k == KSCAN_CSR_RIGHT && shift) return 8;  // Left = back
        }
        // In info screen - any key returns
        else if (current_page == PAGE_INFO)
        {
            return 'x';  // Any key = exit info
        }
    }
    return 0;
}

void wait_key(void)
{
    keyb_poll();
    while (keyb_key & KSCAN_QUAL_DOWN)
        keyb_poll();
    while (!(keyb_key & KSCAN_QUAL_DOWN))
    {
        if (DEBUG_KEY_INJECT)
        {
            DEBUG_KEY_INJECT = 0;
            return;
        }
        keyb_poll();
    }
}

//-----------------------------------------------------------------------------
// UI Drawing
//-----------------------------------------------------------------------------

// Draw a single item line (for partial updates)
// row_offset: 4 for normal lists, 2 for adv results
void draw_item_at(int i, bool selected, byte row_offset)
{
    byte y = i + row_offset;
    clear_line(y);
    if (selected)
    {
        print_at_color(0, y, ">", 1);  // White
        print_at_color(2, y, item_names[i], 1);
    }
    else
    {
        print_at_color(2, y, item_names[i], 14);  // Light blue (default)
    }
}

// Draw item for normal list pages (row offset 4) - plain version
void draw_item(int i, bool selected)
{
    draw_item_at(i, selected, 4);
}

// Draw item for grouped list pages (row offset 4) with trainer/release indicators
void draw_grouped_item(int i, bool selected)
{
    byte y = i + 4;  // Row offset 4 for list pages
    clear_line(y);
    byte color = selected ? 1 : 14;

    if (selected)
        print_at_color(0, y, ">", 1);

    print_at_color(2, y, item_names[i], color);

    int name_len = strlen(item_names[i]);
    int x = 2 + name_len + 1;

    // Show trainer count if > 0
    if (item_trainers[i] > 0)
    {
        char trn[6];
        sprintf(trn, "+%d", item_trainers[i]);
        print_at_color(x, y, trn, 13);  // Light green
        x += strlen(trn) + 1;
    }

    // Show ">" indicator for grouped entries (count > 1)
    if (item_counts[i] > 1)
    {
        print_at_color(x, y, ">", 5);  // Green arrow
    }
}

// Update cursor for grouped list pages (preserves trainer/release indicators)
void update_grouped_cursor(int old_cursor, int new_cursor)
{
    if (old_cursor >= 0 && old_cursor < item_count)
        draw_grouped_item(old_cursor, false);
    if (new_cursor >= 0 && new_cursor < item_count)
        draw_grouped_item(new_cursor, true);
}

// Update cursor display without full redraw (only redraws 2 lines)
void update_cursor_at(int old_cursor, int new_cursor, byte row_offset)
{
    if (old_cursor >= 0 && old_cursor < item_count)
        draw_item_at(old_cursor, false, row_offset);
    if (new_cursor >= 0 && new_cursor < item_count)
        draw_item_at(new_cursor, true, row_offset);
}

// Update cursor for normal list pages (row offset 4)
void update_cursor(int old_cursor, int new_cursor)
{
    update_cursor_at(old_cursor, new_cursor, 4);
}

// Letter-grid layout: 3 rows x 9 cols (A..Z + '#' = 27 cells). Each cell is
// 4 chars wide starting at column 2. Cells are repainted individually on
// cursor move via draw_letter_cell to avoid full screen redraws.
#define LETTER_GRID_COLS 9
#define LETTER_GRID_X0   2
#define LETTER_GRID_Y0   3
#define LETTER_GRID_STEP_X 4
#define LETTER_GRID_STEP_Y 2

// True when the current menu should be rendered as a letter grid rather than
// a vertical list. The server marks this by making the menu_path end with
// "/A-Z".
static bool is_letter_grid(void)
{
    int len = strlen(menu_path);
    return len >= 4 && strcmp(menu_path + len - 4, "/A-Z") == 0;
}

static void draw_letter_cell(int idx, bool selected)
{
    byte x = LETTER_GRID_X0 + (idx % LETTER_GRID_COLS) * LETTER_GRID_STEP_X;
    byte y = LETTER_GRID_Y0 + (idx / LETTER_GRID_COLS) * LETTER_GRID_STEP_Y;
    // 1-char name; cell payload is space+letter+space to cleanly erase any
    // previous '>' when the cursor moves through.
    char buf[4];
    buf[0] = selected ? '>' : ' ';
    buf[1] = ' ';
    buf[2] = item_names[idx][0];
    buf[3] = 0;
    print_at_color(x, y, buf, selected ? 1 : 14);
}

void update_letter_grid_cursor(int old_cursor, int new_cursor)
{
    if (old_cursor >= 0 && old_cursor < item_count)
        draw_letter_cell(old_cursor, false);
    if (new_cursor >= 0 && new_cursor < item_count)
        draw_letter_cell(new_cursor, true);
}

static void draw_letter_grid(const char *title)
{
    clear_screen();
    print_at_color(0, 0, title, 7);  // Yellow
    for (int i = 0; i < item_count; i++)
        draw_letter_cell(i, i == cursor);
    print_at(0, 23, "arrows:move enter:sel del:back");
}

void draw_list(const char *title)
{
    if (current_page == PAGE_CATS && is_letter_grid())
    {
        draw_letter_grid(title);
        return;
    }

    clear_screen();

    // Title
    print_at_color(0, 0, title, 7);  // Yellow

    // Search input row (PAGE_SEARCH only): "[CAT] query_"
    if (current_page == PAGE_SEARCH)
    {
        print_at(0, 1, "[");
        print_at_color(1, 1, search_cat_names[search_category], 5);
        int x = 1 + strlen(search_cat_names[search_category]);
        print_at(x, 1, "] ");
        x += 2;
        print_at(x, 1, search_query);
        print_at(x + search_query_len, 1, "_");
    }

    // Info line
    if (item_count > 0)
    {
        char info[40];
        sprintf(info, "%d-%d of %ld", offset + 1, offset + item_count, total_count);
        print_at(0, 2, info);
    }
    // Draw items
    for (int i = 0; i < item_count && i < LIST_HEIGHT; i++)
    {
        // Use grouped item drawing for PAGE_LIST (shows trainer/release count)
        if (current_page == PAGE_LIST)
        {
            draw_grouped_item(i, i == cursor);
        }
        else
        {
            byte y = i + 4;
            if (i == cursor)
            {
                // Highlight selected item
                print_at_color(0, y, ">", 1);  // White
                print_at_color(2, y, item_names[i], 1);
            }
            else
            {
                print_at(2, y, item_names[i]);
            }
        }
    }

    // Help line
    if (current_page == PAGE_CATS)
        print_at(0, 23, "w/s:move enter:sel /:search c:cfg q:quit");
    else if (current_page == PAGE_LIST)
        print_at(0, 23, "w/s:move enter:run >:rel i:info del:bk n/p:pg");
    else if (current_page == PAGE_SEARCH)
        print_at(0, 23, "type:search c=:cat enter:run i:info del:bk");
}

// Repaint just the search input row (row 1). Cheap; safe to call on every
// keystroke for instant typing feedback without triggering a full redraw or
// a server round-trip.
static void draw_search_input(void)
{
    clear_line(1);
    print_at(0, 1, "[");
    print_at_color(1, 1, search_cat_names[search_category], 5);
    int x = 1 + strlen(search_cat_names[search_category]);
    print_at(x, 1, "] ");
    x += 2;
    print_at(x, 1, search_query);
    print_at(x + search_query_len, 1, "_");
}

// Mark the current query as needing a server search after the debounce
// window expires. Called from typed-char, backspace, and Tab handlers.
static void mark_search_pending(void)
{
    search_pending = true;
    search_due_jiffy = JIFFY_LOW + SEARCH_DEBOUNCE_JIFFIES;
}

void draw_settings(void)
{
    clear_screen();
    print_at_color(0, 0, "settings", 7);  // Yellow

    // Server IP field
    byte y = 4;
    if (settings_cursor == 0)
    {
        print_at_color(0, y, ">", 1);
        print_at_color(2, y, "server:", 1);
        if (settings_editing)
        {
            print_at_color(10, y, server_host, 5);  // Green when editing
            // Show cursor
            print_at_color(10 + settings_edit_pos, y, "_", 5);
        }
        else
        {
            print_at_color(10, y, server_host, 1);
        }
    }
    else
    {
        print_at_color(2, y, "server:", 14);
        print_at_color(10, y, server_host, 14);
    }

    // Save button
    y = 6;
    if (settings_cursor == 1)
    {
        print_at_color(0, y, ">", 1);
        print_at_color(2, y, "[save]", 1);
    }
    else
    {
        print_at_color(2, y, "[save]", 14);
    }

    // Help
    if (settings_editing)
        print_at(0, 23, "type ip  enter:done  del:erase");
    else
        print_at(0, 23, "w/s:move enter:edit/save del:back");
}

// Draw item for releases list with trainer count
void draw_release_item_at(int i, bool selected)
{
    byte y = i + 2;  // Row offset 2 for releases
    clear_line(y);
    byte color = selected ? 1 : 14;

    if (selected)
        print_at_color(0, y, ">", 1);

    print_at_color(2, y, item_names[i], color);

    // Show trainer count if > 0
    if (item_trainers[i] > 0)
    {
        int name_len = strlen(item_names[i]);
        char trn[6];
        sprintf(trn, "+%d", item_trainers[i]);
        print_at_color(2 + name_len + 1, y, trn, 13);  // Light green
    }
}

// Update cursor for releases list (preserves trainer indicator)
void update_releases_cursor(int old_cursor, int new_cursor)
{
    if (old_cursor >= 0 && old_cursor < item_count)
        draw_release_item_at(old_cursor, false);
    if (new_cursor >= 0 && new_cursor < item_count)
        draw_release_item_at(new_cursor, true);
}

void draw_releases(void)
{
    clear_screen();

    // Title: "Title (count)"
    char title[48];
    sprintf(title, "%s (%ld)", releases_title, total_count);
    print_at_color(0, 0, title, 7);  // Yellow

    // Draw items starting at row 2
    int max_display = 19;
    for (int i = 0; i < item_count && i < max_display; i++)
    {
        draw_release_item_at(i, i == cursor);
    }

    // Help line at row 23
    print_at(0, 23, "w/s:move enter:run i:info del:back n/p:pg");
}

void draw_info(void)
{
    clear_screen();
    print_at_color(0, 0, "entry info", 7);  // Yellow

    // Draw all info fields with labels
    for (int i = 0; i < info_line_count; i++)
    {
        byte y = 2 + i;
        // Label in cyan
        print_at_color(2, y, info_labels[i], 3);
        print_at_color(2 + strlen(info_labels[i]), y, ":", 3);
        // Value in white
        print_at_color(10, y, info_values[i], 1);
    }

    // Help line
    print_at(0, 23, "press any key to return");
}

//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------

int main(void)
{
    // Initialize menu state
    menu_path[0] = 0;

    // Set up screen
    vic.color_border = VCOL_BLACK;
    vic.color_back = VCOL_BLACK;

    clear_screen();
    print_at(0, 0, "assembly64 browser");
    print_at(0, 2, "checking ultimate...");

    // Check Ultimate II+ is present
    uci_identify();
    if (!uci_success())
    {
        print_at(0, 4, "ultimate ii+ not found!");
        print_at(0, 6, "press any key to exit");
        wait_key();
        return 1;
    }

    print_at(0, 4, "ultimate ii+ detected");
    print_at(0, 6, "loading settings...");
    load_settings();

    print_at(0, 8, "server: ");
    print_at(8, 8, server_host);

    print_at(0, 10, "getting ip address...");
    uci_getipaddress();
    if (uci_success())
    {
        print_at(0, 12, "ip: ");
        print_at(4, 12, uci_data);
    }

    print_at(0, 14, "c=config, any other key=connect");

    // Wait for keypress and check if it's 'c' for config
    bool need_config = false;
    keyb_poll();
    while (keyb_key & KSCAN_QUAL_DOWN)
        keyb_poll();

    byte injected_splash = 0;
    while (!injected_splash && !(keyb_key & KSCAN_QUAL_DOWN))
    {
        injected_splash = DEBUG_KEY_INJECT;
        if (injected_splash)
            DEBUG_KEY_INJECT = 0;
        else
            keyb_poll();
    }

    if (injected_splash)
    {
        if (injected_splash == 'c' || injected_splash == 'C')
            need_config = true;
    }
    else
    {
        byte k = keyb_key & 0x3f;
        if (k == KSCAN_C)
            need_config = true;
    }

    if (need_config)
    {
        // Go to settings
        current_page = PAGE_SETTINGS;
        settings_cursor = 0;
        settings_editing = false;
        settings_edit_pos = strlen(server_host);
        draw_settings();

        // Settings loop - exit when user presses backspace from non-edit mode
        while (current_page == PAGE_SETTINGS)
        {
            char key = get_key();
            if (key == 'u' && !settings_editing && settings_cursor > 0)
            {
                settings_cursor--;
                draw_settings();
            }
            else if (key == 'd' && !settings_editing && settings_cursor < 1)
            {
                settings_cursor++;
                draw_settings();
            }
            else if (key == '\r')
            {
                if (settings_cursor == 0)
                {
                    settings_editing = !settings_editing;
                    if (settings_editing)
                        settings_edit_pos = strlen(server_host);
                    draw_settings();
                }
                else if (settings_cursor == 1)
                {
                    print_status("saving...");
                    save_settings();
                    print_status("saved! connecting...");
                    current_page = PAGE_CATS;  // Exit settings loop
                }
            }
            else if (key == 8)  // Backspace
            {
                if (settings_editing && settings_edit_pos > 0)
                {
                    settings_edit_pos--;
                    server_host[settings_edit_pos] = 0;
                    draw_settings();
                }
                else if (!settings_editing)
                {
                    current_page = PAGE_CATS;  // Exit settings, try connect
                }
            }
            else if (settings_editing && ((key >= '0' && key <= '9') || key == '.'))
            {
                if (settings_edit_pos < 30)
                {
                    server_host[settings_edit_pos++] = key;
                    server_host[settings_edit_pos] = 0;
                    draw_settings();
                }
            }
        }
    }

    // Connect to server
    if (!connect_to_server())
    {
        print_at(0, 12, "press any key to exit");
        wait_key();
        return 1;
    }

    // Load categories
    load_categories();
    draw_list("assembly64 - categories");

    bool running = true;

    while (running)
    {
        // Fire a deferred search once the debounce window has expired and
        // no further keystroke has pushed search_due_jiffy forward. This
        // turns auto-repeat-held DEL or fast typing from "one server query
        // per keystroke" into "one server query after typing stops".
        if (search_pending && current_page == PAGE_SEARCH)
        {
            byte now = JIFFY_LOW;
            if ((byte)(now - search_due_jiffy) < 128)
            {
                search_pending = false;
                if (search_query_len >= SEARCH_MIN_QUERY_LEN)
                    do_search(search_query, 0);
                else {
                    item_count = 0;
                    total_count = 0;
                }
                draw_list("assembly64 - search");
            }
        }

        char key = get_key();

        if (key != 0)
        {
            // Get current title
            const char *title = "assembly64 - categories";
            if (current_page == PAGE_LIST)
                title = current_category;

            switch (key)
            {
            case 'q':
                if (current_page == PAGE_CATS)
                    running = false;
                break;

            case 'c':  // Settings
                if (current_page == PAGE_CATS)
                {
                    current_page = PAGE_SETTINGS;
                    settings_cursor = 0;
                    settings_editing = false;
                    settings_edit_pos = strlen(server_host);
                    draw_settings();
                }
                break;

            case '/':  // Open simple search (typed query against server SEARCH)
                if (current_page == PAGE_CATS)
                {
                    current_page = PAGE_SEARCH;
                    search_query[0] = 0;
                    search_query_len = 0;
                    search_category = 0;
                    search_pending = false;
                    item_count = 0;
                    total_count = 0;
                    cursor = 0;
                    offset = 0;
                    draw_list("assembly64 - search");
                }
                break;

            case '\t':  // Cycle category filter while in search
                if (current_page == PAGE_SEARCH)
                {
                    search_category = (search_category + 1) & 3;  // 0..3
                    draw_search_input();
                    if (search_query_len >= SEARCH_MIN_QUERY_LEN)
                        mark_search_pending();
                }
                break;

            case 'u':  // Up (W key or cursor up)
                if (current_page == PAGE_SETTINGS)
                {
                    if (settings_cursor > 0)
                    {
                        settings_cursor--;
                        draw_settings();
                    }
                }
                else if (current_page == PAGE_SEARCH)
                {
                    if (cursor > 0)
                    {
                        int old = cursor;
                        cursor--;
                        update_cursor(old, cursor);
                    }
                    else if (offset > 0)
                    {
                        int new_offset = offset - 20;
                        if (new_offset < 0) new_offset = 0;
                        do_search(search_query, new_offset);
                        cursor = item_count - 1;
                        if (cursor > LIST_HEIGHT - 1) cursor = LIST_HEIGHT - 1;
                        draw_list("assembly64 - search");
                    }
                }
                else if (current_page == PAGE_RELEASES)
                {
                    if (cursor > 0)
                    {
                        int old = cursor;
                        cursor--;
                        update_releases_cursor(old, cursor);
                    }
                    else if (offset > 0)
                    {
                        int new_offset = offset - 20;
                        if (new_offset < 0) new_offset = 0;
                        do_releases(releases_category, releases_title, new_offset);
                        cursor = item_count - 1;
                        if (cursor > 18) cursor = 18;
                        draw_releases();
                    }
                }
                else if (current_page == PAGE_LIST)
                {
                    if (cursor > 0)
                    {
                        int old = cursor;
                        cursor--;
                        update_grouped_cursor(old, cursor);
                    }
                    else if (offset > 0)
                    {
                        // At top of list, go to previous page
                        int new_offset = offset - 20;
                        if (new_offset < 0) new_offset = 0;
                        load_list_path(current_category, new_offset);
                        cursor = item_count - 1;
                        if (cursor > LIST_HEIGHT - 1) cursor = LIST_HEIGHT - 1;
                        draw_list(current_category);
                    }
                }
                else if (current_page == PAGE_CATS && is_letter_grid())
                {
                    // Letter grid: step up one row (= -LETTER_GRID_COLS).
                    if (cursor >= LETTER_GRID_COLS)
                    {
                        int old = cursor;
                        cursor -= LETTER_GRID_COLS;
                        update_letter_grid_cursor(old, cursor);
                    }
                }
                else if (cursor > 0)
                {
                    int old = cursor;
                    cursor--;
                    update_cursor(old, cursor);
                }
                break;

            case 'd':  // Down (S key or cursor down)
                if (current_page == PAGE_SETTINGS)
                {
                    if (settings_cursor < 1)  // 2 items: server, save
                    {
                        settings_cursor++;
                        draw_settings();
                    }
                }
                else if (current_page == PAGE_SEARCH)
                {
                    int max_visible = LIST_HEIGHT - 1;
                    if (cursor < item_count - 1 && cursor < max_visible)
                    {
                        int old = cursor;
                        cursor++;
                        update_cursor(old, cursor);
                    }
                    else if (offset + item_count < total_count)
                    {
                        do_search(search_query, offset + 20);
                        cursor = 0;
                        draw_list("assembly64 - search");
                    }
                }
                else if (current_page == PAGE_RELEASES)
                {
                    int max_visible = 18;
                    if (cursor < item_count - 1 && cursor < max_visible)
                    {
                        int old = cursor;
                        cursor++;
                        update_releases_cursor(old, cursor);
                    }
                    else if (offset + item_count < total_count)
                    {
                        do_releases(releases_category, releases_title, offset + 20);
                        cursor = 0;
                        draw_releases();
                    }
                }
                else if (current_page == PAGE_LIST)
                {
                    // Max visible is LIST_HEIGHT - 1 (0 to 17 for 18 items)
                    int max_visible = LIST_HEIGHT - 1;
                    if (cursor < item_count - 1 && cursor < max_visible)
                    {
                        int old = cursor;
                        cursor++;
                        update_grouped_cursor(old, cursor);
                    }
                    else if (offset + item_count < total_count)
                    {
                        // At bottom, go to next page
                        load_list_path(current_category, offset + 20);
                        cursor = 0;
                        draw_list(current_category);
                    }
                }
                else if (current_page == PAGE_CATS && is_letter_grid())
                {
                    // Letter grid: step down one row (= +LETTER_GRID_COLS).
                    if (cursor + LETTER_GRID_COLS < item_count)
                    {
                        int old = cursor;
                        cursor += LETTER_GRID_COLS;
                        update_letter_grid_cursor(old, cursor);
                    }
                }
                else if (cursor < item_count - 1)
                {
                    int old = cursor;
                    cursor++;
                    update_cursor(old, cursor);
                }
                break;

            case 'l':  // Grid left (letter grid only)
                if (current_page == PAGE_CATS && is_letter_grid())
                {
                    if (cursor % LETTER_GRID_COLS == 0)
                    {
                        // Left edge: "wall bump" exits the grid back to its
                        // parent menu, mirroring how DEL behaves.
                        go_back();
                    }
                    else
                    {
                        int old = cursor;
                        cursor--;
                        update_letter_grid_cursor(old, cursor);
                    }
                }
                break;

            case 'r':  // Grid right (letter grid only)
                if (current_page == PAGE_CATS && is_letter_grid() && cursor + 1 < item_count)
                {
                    int old = cursor;
                    cursor++;
                    update_letter_grid_cursor(old, cursor);
                }
                break;

            case '>':  // Right arrow - enter menu item or releases
                if (current_page == PAGE_CATS && item_count > 0)
                {
                    if (menu_types[cursor] == 'f' || menu_types[cursor] == 'D')
                    {
                        // Folder or Directory - navigate into it
                        load_menu(menu_paths[cursor]);
                        draw_list(item_names[0] ? menu_path : "assembly64");
                    }
                    else if (menu_types[cursor] == 'F')
                    {
                        // File in MYFILES - run it directly
                        run_myfile(menu_paths[cursor]);
                    }
                    else
                    {
                        // List or Browse (type 'l' or 'b') - load entries
                        menu_return_cursor = cursor;
                        strcpy(current_category, menu_paths[cursor]);
                        load_list_path(current_category, 0);
                        current_page = PAGE_LIST;
                        draw_list(current_category);
                    }
                }
                else if (current_page == PAGE_LIST && item_count > 0)
                {
                    // Enter releases sub-list if count > 1
                    if (item_counts[cursor] > 1)
                    {
                        strncpy(releases_title, item_names[cursor], 31);
                        releases_title[31] = 0;
                        strncpy(releases_category, current_category, 47);
                        releases_category[47] = 0;
                        releases_return_page = PAGE_LIST;
                        releases_return_offset = offset;
                        releases_return_cursor = cursor;
                        do_releases(releases_category, releases_title, 0);
                        current_page = PAGE_RELEASES;
                        draw_releases();
                    }
                    else
                    {
                        // Single release - just run it
                        run_entry(item_ids[cursor]);
                    }
                }
                break;

            case '\r':  // Enter
                if (current_page == PAGE_CATS && item_count > 0)
                {
                    // Select menu item
                    if (menu_types[cursor] == 'f' || menu_types[cursor] == 'D')
                    {
                        // Folder or Directory - navigate into it
                        load_menu(menu_paths[cursor]);
                        draw_list(menu_path[0] ? menu_path : "assembly64 - categories");
                    }
                    else if (menu_types[cursor] == 'F')
                    {
                        // File in MYFILES - run it directly
                        run_myfile(menu_paths[cursor]);
                    }
                    else
                    {
                        // List or Browse (type 'l' or 'b') - load entries
                        menu_return_cursor = cursor;
                        strcpy(current_category, menu_paths[cursor]);
                        load_list_path(current_category, 0);
                        current_page = PAGE_LIST;
                        draw_list(current_category);
                    }
                }
                else if (current_page == PAGE_SETTINGS)
                {
                    if (settings_cursor == 0)
                    {
                        // Toggle edit mode on server field
                        settings_editing = !settings_editing;
                        if (settings_editing)
                            settings_edit_pos = strlen(server_host);
                        draw_settings();
                    }
                    else if (settings_cursor == 1)
                    {
                        // Save settings
                        print_status("saving...");
                        save_settings();
                        print_status("saved!");
                        // Go back to categories
                        current_page = PAGE_CATS;
                        draw_list("assembly64 - categories");
                    }
                }
                else if (current_page == PAGE_RELEASES && item_count > 0)
                {
                    // Run selected release
                    run_entry(item_ids[cursor]);
                }
                else if (item_count > 0)
                {
                    // Run entry (page 1 or 2)
                    run_entry(item_ids[cursor]);
                }
                break;

            case 8:  // Backspace
                if (current_page == PAGE_SETTINGS)
                {
                    if (settings_editing && settings_edit_pos > 0)
                    {
                        // Delete last char from server_host
                        settings_edit_pos--;
                        server_host[settings_edit_pos] = 0;
                        draw_settings();
                    }
                    else if (!settings_editing)
                    {
                        // Go back to categories
                        current_page = PAGE_CATS;
                        draw_list("assembly64 - categories");
                    }
                }
                else if (current_page == PAGE_LIST || current_page == PAGE_CATS)
                {
                    // Go back
                    go_back();
                }
                else if (current_page == PAGE_SEARCH)
                {
                    if (search_query_len > 0)
                    {
                        search_query_len--;
                        search_query[search_query_len] = 0;
                        draw_search_input();
                        // Defer the actual SEARCH; quick repeated DELs (auto-
                        // repeat held) don't queue server round-trips.
                        if (search_query_len >= SEARCH_MIN_QUERY_LEN)
                            mark_search_pending();
                        else {
                            search_pending = false;
                            item_count = 0;
                            total_count = 0;
                        }
                    }
                    else
                    {
                        load_categories();
                        draw_list("assembly64 - categories");
                    }
                }
                else if (current_page == PAGE_RELEASES)
                {
                    // Go back
                    go_back();
                }
                break;

            case 'n':  // Next page
                if (current_page == PAGE_LIST && offset + item_count < total_count)
                {
                    load_list_path(current_category, offset + 20);
                    draw_list(current_category);
                }
                else if (current_page == PAGE_SEARCH && offset + item_count < total_count)
                {
                    do_search(search_query, offset + 20);
                    draw_list("assembly64 - search");
                }
                else if (current_page == PAGE_RELEASES && offset + item_count < total_count)
                {
                    do_releases(releases_category, releases_title, offset + 20);
                    draw_releases();
                }
                break;

            case 'p':  // Previous page
                if (current_page == PAGE_LIST && offset > 0)
                {
                    int new_offset = offset - 20;
                    if (new_offset < 0) new_offset = 0;
                    load_list_path(current_category, new_offset);
                    draw_list(current_category);
                }
                else if (current_page == PAGE_SEARCH && offset > 0)
                {
                    int new_offset = offset - 20;
                    if (new_offset < 0) new_offset = 0;
                    do_search(search_query, new_offset);
                    draw_list("assembly64 - search");
                }
                else if (current_page == PAGE_RELEASES && offset > 0)
                {
                    int new_offset = offset - 20;
                    if (new_offset < 0) new_offset = 0;
                    do_releases(releases_category, releases_title, new_offset);
                    draw_releases();
                }
                break;

            case 'i':  // Info
                if ((current_page == PAGE_LIST || current_page == PAGE_SEARCH ||
                     current_page == PAGE_RELEASES) && item_count > 0)
                {
                    // Remember where to return
                    info_return_page = current_page;
                    // Fetch and display info
                    if (fetch_info(item_ids[cursor]))
                    {
                        current_page = PAGE_INFO;
                        draw_info();
                    }
                }
                break;

            case 'x':  // Exit info screen
                if (current_page == PAGE_INFO)
                {
                    current_page = info_return_page;
                    if (current_page == PAGE_LIST)
                        draw_list(current_category);
                    else if (current_page == PAGE_SEARCH)
                        draw_list("assembly64 - search");
                    else if (current_page == PAGE_RELEASES)
                        draw_releases();
                }
                break;

            default:
                // Typed alphanumeric in search mode → grow query and defer
                // the SEARCH command behind the debounce timer. Input row is
                // repainted immediately so typing feels responsive.
                if (current_page == PAGE_SEARCH &&
                    ((key >= 'A' && key <= 'Z') || (key >= '0' && key <= '9')))
                {
                    if (search_query_len < (int)sizeof(search_query) - 1)
                    {
                        search_query[search_query_len++] = key;
                        search_query[search_query_len] = 0;
                        draw_search_input();
                        if (search_query_len >= SEARCH_MIN_QUERY_LEN)
                            mark_search_pending();
                    }
                }
                // Typed character in settings edit mode
                else if (current_page == PAGE_SETTINGS && settings_editing &&
                         ((key >= '0' && key <= '9') || key == '.'))
                {
                    if (settings_edit_pos < 30)
                    {
                        server_host[settings_edit_pos++] = key;
                        server_host[settings_edit_pos] = 0;
                        draw_settings();
                    }
                }
                break;
            }
        }
    }

    disconnect_from_server();
    clear_screen();
    print_at(0, 0, "goodbye!");

    return 0;
}
