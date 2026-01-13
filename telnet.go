// Telnet server for browsing Assembly64 collections remotely.
// Allows connecting from CCGMS on C64 Ultimate or standard telnet clients.
package main

import (
	"fmt"
	"log/slog"
	"net"
	"os"
	"path/filepath"
	"strings"
	"sync/atomic"
	"time"
)

// ANSI escape codes for terminal rendering.
const (
	ansiReset     = "\033[0m"
	ansiBold      = "\033[1m"
	ansiReverse   = "\033[7m"
	ansiMagenta   = "\033[35m"
	ansiCyan      = "\033[36m"
	ansiGray      = "\033[90m"
	ansiRed       = "\033[31m"
	ansiGreen     = "\033[32m"
	ansiHome      = "\033[H"        // Cursor to top-left
	ansiClear     = "\033[2J\033[H" // Full screen clear + cursor home
	ansiClearLine = "\033[K"        // Clear from cursor to end of line
)

// Server limits.
const (
	maxConnections = 10              // Maximum concurrent connections
	readTimeout    = 5 * time.Minute // Idle timeout per connection
)

// UI page states.
const (
	pageMenu   = iota // Main menu - select category or search
	pageBrowse        // Browse entries in selected category
	pageSearch        // Search input mode
)

// TelnetModel holds state for a telnet session.
type TelnetModel struct {
	index          *SearchIndex
	apiClient      *APIClient
	assembly64Path string

	// UI state.
	page          int      // Current page (pageMenu, pageBrowse, pageSearch)
	needsClear    bool     // Next render should do full clear
	menuCursor    int      // Cursor position in menu
	menuItems     []string // Menu items (categories + Search)

	// Browse/search state.
	selectedCategory string
	searchQuery      string
	filteredResults  []int
	cursor           int
	scrollOffset     int

	// Display.
	width         int
	height        int
	statusMessage string
	err           error
}

// NewTelnetModel creates a new telnet session model.
func NewTelnetModel(index *SearchIndex, apiClient *APIClient, assembly64Path string) *TelnetModel {
	// Build menu items: categories + Search option.
	menuItems := make([]string, len(index.CategoryOrder)+1)
	copy(menuItems, index.CategoryOrder)
	menuItems[len(menuItems)-1] = "Search"

	return &TelnetModel{
		index:          index,
		apiClient:      apiClient,
		assembly64Path: assembly64Path,
		page:           pageMenu,
		menuCursor:     0,
		menuItems:      menuItems,
		width:          40,
		height:         25,
	}
}

// applyFilters filters entries based on category and search query.
func (m *TelnetModel) applyFilters() {
	m.filteredResults = make([]int, 0)
	query := strings.ToLower(m.searchQuery)

	for i, entry := range m.index.Entries {
		// Category filter (skip if searching or "All").
		if m.page == pageBrowse && m.selectedCategory != "All" {
			if entry.CategoryName != m.selectedCategory {
				continue
			}
		}

		// Search filter.
		if query != "" {
			nameMatch := strings.Contains(strings.ToLower(entry.Name), query)
			groupMatch := strings.Contains(strings.ToLower(entry.Group), query)
			if !nameMatch && !groupMatch {
				continue
			}
		}

		m.filteredResults = append(m.filteredResults, i)
	}

	// Reset cursor if out of bounds.
	if m.cursor >= len(m.filteredResults) {
		m.cursor = 0
		m.scrollOffset = 0
	}
}

// adjustScroll adjusts scroll offset to keep cursor visible.
func (m *TelnetModel) adjustScroll(viewHeight int) {
	if m.cursor < m.scrollOffset {
		m.scrollOffset = m.cursor
	} else if m.cursor >= m.scrollOffset+viewHeight {
		m.scrollOffset = m.cursor - viewHeight + 1
	}
}

// loadSelectedEntry loads the selected entry to C64 Ultimate.
func (m *TelnetModel) loadSelectedEntry() error {
	if len(m.filteredResults) == 0 {
		return fmt.Errorf("no entry selected")
	}

	entry := m.index.Entries[m.filteredResults[m.cursor]]

	// Read file.
	data, err := os.ReadFile(entry.FullPath)
	if err != nil {
		return fmt.Errorf("read: %w", err)
	}

	// Call appropriate API based on file type.
	switch entry.FileType {
	case "d64", "d71", "d81", "g64", "g71":
		err = m.apiClient.runDiskImage(data, entry.FileType, filepath.Base(entry.FullPath))
	case "prg":
		err = m.apiClient.runPRG(data)
	case "crt":
		err = m.apiClient.runCRT(data)
	default:
		return fmt.Errorf("unsupported: %s", entry.FileType)
	}

	if err != nil {
		return fmt.Errorf("load: %w", err)
	}

	m.statusMessage = fmt.Sprintf("Loaded: %s", entry.Name)
	m.err = nil
	return nil
}

// startTelnetServer starts the telnet server.
func startTelnetServer(c64Host string, port int, assembly64Path string) error {
	if port < 1 || port > 65535 {
		return fmt.Errorf("invalid port %d: must be between 1 and 65535", port)
	}

	index, err := loadAssembly64Index(assembly64Path)
	if err != nil {
		return fmt.Errorf("failed to load Assembly64 database from %s: %w", assembly64Path, err)
	}
	slog.Info("Loaded Assembly64 index", "entries", len(index.Entries))

	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		return fmt.Errorf("failed to start listener: %w", err)
	}
	defer listener.Close()

	slog.Info("Telnet server listening", "port", port)
	fmt.Printf("Telnet server listening on :%d\n", port)

	var activeConns int32

	for {
		conn, err := listener.Accept()
		if err != nil {
			slog.Error("Accept error", "error", err)
			continue
		}

		if atomic.LoadInt32(&activeConns) >= maxConnections {
			slog.Warn("Connection rejected: max connections reached", "remote", conn.RemoteAddr())
			conn.Write([]byte("Server busy, try again later.\r\n"))
			conn.Close()
			continue
		}

		atomic.AddInt32(&activeConns, 1)
		slog.Info("Client connected", "remote", conn.RemoteAddr(), "active", atomic.LoadInt32(&activeConns))

		go func(c net.Conn) {
			defer atomic.AddInt32(&activeConns, -1)
			handleConnection(c, index, c64Host, assembly64Path)
		}(conn)
	}
}

// handleConnection handles a single telnet connection.
func handleConnection(conn net.Conn, index *SearchIndex, c64Host string, assembly64Path string) {
	defer conn.Close()
	defer slog.Info("Client disconnected", "remote", conn.RemoteAddr())

	// Send telnet negotiation for character mode.
	if _, err := conn.Write([]byte{255, 251, 1}); err != nil {
		return
	}
	if _, err := conn.Write([]byte{255, 251, 3}); err != nil {
		return
	}
	if _, err := conn.Write([]byte{255, 252, 34}); err != nil {
		return
	}

	apiClient := NewAPIClient(c64Host)
	model := NewTelnetModel(index, apiClient, assembly64Path)

	// Clear screen on connect - use multiple methods for compatibility.
	// Form feed (ASCII 12) is widely supported for screen clear.
	if _, err := conn.Write([]byte{12}); err != nil {
		slog.Debug("Write error", "error", err)
		return
	}
	if err := renderScreen(conn, model); err != nil {
		slog.Debug("Write error", "error", err)
		return
	}

	for {
		conn.SetReadDeadline(time.Now().Add(readTimeout))

		action, err := readInput(conn)
		if err != nil {
			if netErr, ok := err.(net.Error); ok && netErr.Timeout() {
				slog.Debug("Connection timed out", "remote", conn.RemoteAddr())
			} else {
				slog.Debug("Read error", "error", err)
			}
			return
		}

		if action == "" {
			continue
		}

		cont, redraw := handleInput(model, action, conn)
		if !cont {
			return
		}

		if redraw {
			if err := renderScreen(conn, model); err != nil {
				slog.Debug("Write error", "error", err)
				return
			}
		}
	}
}

// renderScreen renders the UI based on current page.
func renderScreen(conn net.Conn, m *TelnetModel) error {
	var b strings.Builder

	// Use form feed clear when needed (page transitions), otherwise home.
	if m.needsClear {
		b.WriteByte(12) // Form feed - clears screen on C64U
		m.needsClear = false
	} else {
		b.WriteString(ansiHome)
	}

	switch m.page {
	case pageMenu:
		renderMenuPage(&b, m)
	case pageBrowse:
		renderBrowsePage(&b, m)
	case pageSearch:
		renderSearchPage(&b, m)
	}

	_, err := conn.Write([]byte(b.String()))
	return err
}

// renderMenuPage renders the main menu.
func renderMenuPage(b *strings.Builder, m *TelnetModel) {
	// Title.
	b.WriteString(ansiBold + ansiMagenta + "Assembly64 Browser" + ansiReset + ansiClearLine + "\r\n")
	b.WriteString(ansiGray + "Select category:" + ansiReset + ansiClearLine + "\r\n" + ansiClearLine + "\r\n")

	// Menu items.
	for i, item := range m.menuItems {
		if i == m.menuCursor {
			b.WriteString(ansiBold + ansiMagenta + "> " + item + ansiReset + ansiClearLine + "\r\n")
		} else {
			b.WriteString("  " + item + ansiClearLine + "\r\n")
		}
	}

	// Help.
	b.WriteString(ansiClearLine + "\r\n" + ansiGray + "Arrows Enter Q:Quit" + ansiReset + ansiClearLine)
}

// renderBrowsePage renders the browse entries page.
func renderBrowsePage(b *strings.Builder, m *TelnetModel) {
	// Title with category.
	b.WriteString(ansiBold + ansiMagenta)
	b.WriteString(m.selectedCategory)
	b.WriteString(ansiReset)
	b.WriteString(ansiGray + fmt.Sprintf(" [%d]", len(m.filteredResults)) + ansiReset)
	b.WriteString(ansiClearLine + "\r\n")

	// Results list.
	viewHeight := m.height - 4
	if viewHeight < 5 {
		viewHeight = 5
	}

	if len(m.filteredResults) == 0 {
		b.WriteString(ansiGray + "No entries" + ansiReset + "\r\n")
	} else {
		m.adjustScroll(viewHeight)
		start := m.scrollOffset
		end := min(start+viewHeight, len(m.filteredResults))

		for i := start; i < end; i++ {
			entry := m.index.Entries[m.filteredResults[i]]
			line := formatEntryTelnet(entry, i == m.cursor, m.width)
			b.WriteString(line + ansiClearLine + "\r\n")
		}
	}

	// Status line.
	if m.err != nil {
		b.WriteString(ansiRed + m.err.Error() + ansiReset)
	} else if m.statusMessage != "" {
		b.WriteString(ansiGreen + m.statusMessage + ansiReset)
	}
	b.WriteString(ansiClearLine + "\r\n")

	// Help.
	b.WriteString(ansiGray + "Arrows Enter BS:Back Q:Quit" + ansiReset)
}

// renderSearchPage renders the search input page.
func renderSearchPage(b *strings.Builder, m *TelnetModel) {
	// Title.
	b.WriteString(ansiBold + ansiMagenta + "Search" + ansiReset + "\r\n")

	// Search input.
	b.WriteString(ansiCyan + ">" + ansiReset + " ")
	b.WriteString(m.searchQuery)
	b.WriteString(ansiReverse + " " + ansiReset) // Cursor.
	b.WriteString(ansiClearLine + "\r\n\r\n")

	// Results (if any search performed).
	if m.searchQuery != "" {
		b.WriteString(ansiGray + fmt.Sprintf("[%d results]", len(m.filteredResults)) + ansiReset + "\r\n")

		viewHeight := m.height - 7
		if viewHeight < 5 {
			viewHeight = 5
		}

		if len(m.filteredResults) > 0 {
			m.adjustScroll(viewHeight)
			start := m.scrollOffset
			end := min(start+viewHeight, len(m.filteredResults))

			for i := start; i < end; i++ {
				entry := m.index.Entries[m.filteredResults[i]]
				line := formatEntryTelnet(entry, i == m.cursor, m.width)
				b.WriteString(line + ansiClearLine + "\r\n")
			}
		}
	} else {
		b.WriteString(ansiGray + "Type to search, Enter to load" + ansiReset + "\r\n")
	}

	// Status line.
	if m.err != nil {
		b.WriteString(ansiRed + m.err.Error() + ansiReset)
	} else if m.statusMessage != "" {
		b.WriteString(ansiGreen + m.statusMessage + ansiReset)
	}
	b.WriteString(ansiClearLine + "\r\n")

	// Help.
	b.WriteString(ansiGray + "Type Arrows Enter BS:Back Q:Quit" + ansiReset)
}

// formatEntryTelnet formats a single entry for telnet display.
// No ANSI colors on entries for faster C64U rendering.
func formatEntryTelnet(entry ReleaseEntry, selected bool, width int) string {
	cursor := " "
	if selected {
		cursor = ">"
	}

	ext := "." + entry.FileType
	name := entry.Name

	if width <= 40 {
		maxNameLen := width - 2 - len(ext)
		if maxNameLen < 8 {
			maxNameLen = 8
		}
		if len(name) > maxNameLen {
			name = name[:maxNameLen-2] + ".."
		}
		return fmt.Sprintf("%s%s%s", cursor, name, ext)
	}

	// 80-col mode.
	maxNameLen := 30
	if len(name) > maxNameLen {
		name = name[:maxNameLen-3] + "..."
	}
	meta := ""
	if entry.Group != "" || entry.Year != "" {
		meta = fmt.Sprintf("(%s, %s)", entry.Group, entry.Year)
	}
	return fmt.Sprintf("%s %-32s %-25s %s", cursor, name, meta, ext)
}

// readInput reads input from the connection and returns an action string.
func readInput(conn net.Conn) (string, error) {
	buf := make([]byte, 32)
	n, err := conn.Read(buf)
	if err != nil {
		return "", err
	}

	if n == 0 {
		return "", nil
	}

	data := buf[:n]
	slog.Debug("readInput: raw bytes", "count", n, "hex", fmt.Sprintf("%x", data))

	// Handle telnet IAC sequences.
	if data[0] == 255 {
		conn.SetReadDeadline(time.Now().Add(100 * time.Millisecond))
		more := make([]byte, 8)
		n2, _ := conn.Read(more)
		conn.SetReadDeadline(time.Time{})
		if n2 > 0 {
			slog.Debug("readInput: IAC sequence", "hex", fmt.Sprintf("%x", append(data, more[:n2]...)))
		}
		return "", nil
	}

	// Skip stray IAC command bytes.
	if data[0] >= 251 && data[0] <= 254 {
		return "", nil
	}

	// Handle control characters.
	switch data[0] {
	case '\t':
		return "tab", nil
	case '\r', '\n':
		return "enter", nil
	case 127, 8:
		return "backspace", nil
	case 12:
		return "refresh", nil
	}

	// Skip IAC option bytes.
	if len(data) == 1 && data[0] <= 50 {
		return "", nil
	}

	// Parse escape sequences.
	if data[0] == 27 {
		if len(data) == 1 {
			conn.SetReadDeadline(time.Now().Add(50 * time.Millisecond))
			more := make([]byte, 8)
			n2, _ := conn.Read(more)
			if n2 > 0 {
				data = append(data, more[:n2]...)
			} else {
				return "quit", nil
			}
		}

		if len(data) >= 3 && data[1] == '[' {
			switch data[2] {
			case 'A':
				return "up", nil
			case 'B':
				return "down", nil
			case 'C':
				return "right", nil
			case 'D':
				return "left", nil
			case 'H':
				return "home", nil
			case 'F':
				return "end", nil
			case '5':
				if len(data) >= 4 && data[3] == '~' {
					return "pgup", nil
				}
			case '6':
				if len(data) >= 4 && data[3] == '~' {
					return "pgdown", nil
				}
			case '1':
				if len(data) >= 4 && data[3] == '~' {
					return "home", nil
				}
			case '4':
				if len(data) >= 4 && data[3] == '~' {
					return "end", nil
				}
			}
		}
		return "", nil
	}

	// Quit commands.
	switch data[0] {
	case 'q', 'Q':
		return "quit", nil
	}

	// Printable character.
	if data[0] >= 32 && data[0] <= 126 {
		return string(data[0]), nil
	}

	return "", nil
}

// handleInput processes user input based on current page.
func handleInput(m *TelnetModel, action string, conn net.Conn) (bool, bool) {
	// Clear status on any action except enter.
	if action != "enter" {
		m.statusMessage = ""
		m.err = nil
	}

	switch m.page {
	case pageMenu:
		return handleMenuInput(m, action)
	case pageBrowse:
		return handleBrowseInput(m, action, conn)
	case pageSearch:
		return handleSearchInput(m, action, conn)
	}
	return true, false
}

// handleMenuInput handles input on the main menu page.
func handleMenuInput(m *TelnetModel, action string) (bool, bool) {
	switch action {
	case "quit":
		return false, false

	case "up":
		if m.menuCursor > 0 {
			m.menuCursor--
		}
		return true, true

	case "down":
		if m.menuCursor < len(m.menuItems)-1 {
			m.menuCursor++
		}
		return true, true

	case "enter":
		selected := m.menuItems[m.menuCursor]
		if selected == "Search" {
			// Go to search page.
			m.page = pageSearch
			m.needsClear = true
			m.searchQuery = ""
			m.filteredResults = nil
			m.cursor = 0
			m.scrollOffset = 0
		} else {
			// Go to browse page with selected category.
			m.page = pageBrowse
			m.needsClear = true
			m.selectedCategory = selected
			m.cursor = 0
			m.scrollOffset = 0
			m.applyFilters()
		}
		return true, true
	}

	return true, false
}

// handleBrowseInput handles input on the browse page.
func handleBrowseInput(m *TelnetModel, action string, conn net.Conn) (bool, bool) {
	switch action {
	case "quit":
		return false, false

	case "backspace":
		// Go back to menu.
		m.page = pageMenu
		m.needsClear = true
		return true, true

	case "up":
		if m.cursor > 0 {
			m.cursor--
		}
		return true, true

	case "down":
		if len(m.filteredResults) > 0 && m.cursor < len(m.filteredResults)-1 {
			m.cursor++
		}
		return true, true

	case "pgup":
		m.cursor = max(0, m.cursor-10)
		return true, true

	case "pgdown":
		if len(m.filteredResults) > 0 {
			m.cursor = min(len(m.filteredResults)-1, m.cursor+10)
		}
		return true, true

	case "home":
		m.cursor = 0
		m.scrollOffset = 0
		return true, true

	case "end":
		if len(m.filteredResults) > 0 {
			m.cursor = len(m.filteredResults) - 1
		}
		return true, true

	case "enter":
		if len(m.filteredResults) > 0 {
			m.statusMessage = "Loading..."
			renderScreen(conn, m)
			if err := m.loadSelectedEntry(); err != nil {
				m.err = err
				m.statusMessage = ""
			}
		}
		return true, true
	}

	return true, false
}

// handleSearchInput handles input on the search page.
func handleSearchInput(m *TelnetModel, action string, conn net.Conn) (bool, bool) {
	switch action {
	case "quit":
		return false, false

	case "backspace":
		if len(m.searchQuery) > 0 {
			// Remove last character from search.
			m.searchQuery = m.searchQuery[:len(m.searchQuery)-1]
			m.needsClear = true // Clear because results list changes
			m.cursor = 0
			m.scrollOffset = 0
			m.applyFilters()
			return true, true
		} else {
			// Empty search - go back to menu.
			m.page = pageMenu
			m.needsClear = true
			return true, true
		}

	case "up":
		if m.cursor > 0 {
			m.cursor--
		}
		return true, true

	case "down":
		if len(m.filteredResults) > 0 && m.cursor < len(m.filteredResults)-1 {
			m.cursor++
		}
		return true, true

	case "pgup":
		m.cursor = max(0, m.cursor-10)
		return true, true

	case "pgdown":
		if len(m.filteredResults) > 0 {
			m.cursor = min(len(m.filteredResults)-1, m.cursor+10)
		}
		return true, true

	case "enter":
		if len(m.filteredResults) > 0 {
			m.statusMessage = "Loading..."
			renderScreen(conn, m)
			if err := m.loadSelectedEntry(); err != nil {
				m.err = err
				m.statusMessage = ""
			}
		}
		return true, true

	default:
		// Printable character - add to search query.
		if len(action) == 1 && action[0] >= 32 && action[0] <= 126 {
			m.searchQuery += action
			m.needsClear = true // Clear because results list changes
			m.cursor = 0
			m.scrollOffset = 0
			m.applyFilters()
			return true, true
		}
	}

	return true, false
}
