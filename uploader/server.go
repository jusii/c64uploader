// C64 protocol server for C64 client.
// Simple line-based protocol optimized for low-bandwidth C64 communication.
package main

import (
	"bufio"
	"fmt"
	"log/slog"
	"net"
	"os"
	"strconv"
	"strings"
	"time"
)

// C64 protocol commands:
// CATS                         - List categories (legacy)
// LIST <cat> <offset> <n>      - List n entries from category starting at offset (legacy)
// SEARCH <off> <n> <query>     - Search all entries (query can be multi-word)
// SEARCH <off> <n> <cat> <q>   - Search within category (cat=All for all)
// INFO <id>                    - Get entry details
// RUN <id>                     - Download and run entry
// RELEASES <off> <n> <title>   - List all releases of a title (for grouped results)
// MENU [path]                  - Get menu entries at path (hierarchical navigation)
// LISTPATH <off> <n> <path>    - List entries matching path prefix
// QUIT                         - Close connection

const (
	c64ReadTimeout = 5 * time.Minute
	c64PageSize    = 20 // Default entries per page
)

// StartC64Server starts the C64 protocol server.
func StartC64Server(port int, index *SearchIndex, apiClient *APIClient, assembly64Path string) error {
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		return fmt.Errorf("failed to start C64 server: %w", err)
	}

	slog.Info("C64 protocol server listening", "port", port)
	fmt.Printf("C64 protocol server listening on :%d\n", port)

	go func() {
		for {
			conn, err := listener.Accept()
			if err != nil {
				slog.Error("Accept error", "error", err)
				continue
			}
			go handleC64Connection(conn, index, apiClient, assembly64Path)
		}
	}()

	return nil
}

func handleC64Connection(conn net.Conn, index *SearchIndex, apiClient *APIClient, assembly64Path string) {
	defer conn.Close()

	remoteAddr := conn.RemoteAddr().String()
	slog.Info("C64 client connected", "remote", remoteAddr)

	// Send greeting
	conn.Write([]byte("OK Assembly64 Browser\n"))

	reader := bufio.NewReader(conn)

	for {
		conn.SetReadDeadline(time.Now().Add(c64ReadTimeout))

		line, err := reader.ReadString('\n')
		if err != nil {
			slog.Debug("C64 client disconnected", "remote", remoteAddr, "error", err)
			return
		}

		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}

		slog.Debug("C64 command", "remote", remoteAddr, "cmd", line)

		response := handleC64Command(line, index, apiClient, assembly64Path, conn)
		if response == "QUIT" {
			conn.Write([]byte("OK Goodbye\n"))
			return
		}
		conn.Write([]byte(response))
	}
}

func handleC64Command(line string, index *SearchIndex, apiClient *APIClient, assembly64Path string, conn net.Conn) string {
	parts := strings.Fields(line)
	if len(parts) == 0 {
		return "ERR Empty command\n"
	}

	cmd := strings.ToUpper(parts[0])

	switch cmd {
	case "CATS":
		return handleCats(index)

	case "LIST":
		if len(parts) < 4 {
			return "ERR Usage: LIST <category> <offset> <count> [grouped=1]\n"
		}
		category := parts[1]
		offset, _ := strconv.Atoi(parts[2])
		count, _ := strconv.Atoi(parts[3])
		// Check for grouped=1 parameter
		grouped := false
		if len(parts) >= 5 && strings.EqualFold(parts[4], "grouped=1") {
			grouped = true
		}
		return handleList(index, category, offset, count, grouped)

	case "SEARCH":
		if len(parts) < 4 {
			return "ERR Usage: SEARCH <offset> <count> [category] <query>\n"
		}
		offset, _ := strconv.Atoi(parts[1])
		count, _ := strconv.Atoi(parts[2])
		// Check if parts[3] is a known category
		category := ""
		queryStart := 3
		potentialCat := parts[3]
		for _, cat := range index.CategoryOrder {
			if strings.EqualFold(cat, potentialCat) {
				category = cat
				queryStart = 4
				break
			}
		}
		if queryStart > len(parts) {
			return "ERR Usage: SEARCH <offset> <count> [category] <query>\n"
		}
		// Query is all remaining parts joined with spaces
		query := strings.Join(parts[queryStart:], " ")
		return handleSearch(index, query, category, offset, count)

	case "INFO":
		if len(parts) < 2 {
			return "ERR Usage: INFO <id>\n"
		}
		id, err := strconv.Atoi(parts[1])
		if err != nil {
			return "ERR Invalid ID\n"
		}
		return handleInfo(index, id)

	case "RUN":
		if len(parts) < 2 {
			return "ERR Usage: RUN <id>\n"
		}
		id, err := strconv.Atoi(parts[1])
		if err != nil {
			return "ERR Invalid ID\n"
		}
		return handleRun(index, apiClient, assembly64Path, id)

	case "ADVSEARCH":
		// ADVSEARCH offset count key=value key=value ...
		// Keys: cat, title, group, type, top200, grouped
		if len(parts) < 3 {
			return "ERR Usage: ADVSEARCH <offset> <count> [key=value ...]\n"
		}
		offset, _ := strconv.Atoi(parts[1])
		count, _ := strconv.Atoi(parts[2])
		// Parse key=value pairs
		params := make(map[string]string)
		for i := 3; i < len(parts); i++ {
			if idx := strings.Index(parts[i], "="); idx > 0 {
				key := strings.ToLower(parts[i][:idx])
				value := parts[i][idx+1:]
				params[key] = value
			}
		}
		return handleAdvSearch(index, params, offset, count)

	case "RELEASES":
		// RELEASES offset count category title - List all releases of a specific title
		if len(parts) < 5 {
			return "ERR Usage: RELEASES <offset> <count> <category> <title>\n"
		}
		offset, _ := strconv.Atoi(parts[1])
		count, _ := strconv.Atoi(parts[2])
		category := parts[3]
		// Title is all remaining parts joined (may contain spaces)
		title := strings.Join(parts[4:], " ")
		return handleReleases(index, category, title, offset, count)

	case "MENU":
		// MENU [path] - Get menu entries at path for hierarchical navigation
		path := ""
		if len(parts) >= 2 {
			path = strings.Join(parts[1:], " ")
		}
		return handleMenu(index, path)

	case "LISTPATH":
		// LISTPATH offset count path - List entries matching path prefix
		if len(parts) < 4 {
			return "ERR Usage: LISTPATH <offset> <count> <path>\n"
		}
		offset, _ := strconv.Atoi(parts[1])
		count, _ := strconv.Atoi(parts[2])
		path := strings.Join(parts[3:], " ")
		return handleListPath(index, path, offset, count)

	case "QUIT":
		return "QUIT"

	default:
		return fmt.Sprintf("ERR Unknown command: %s\n", cmd)
	}
}

func handleCats(index *SearchIndex) string {
	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d\n", len(index.CategoryOrder)))
	for _, cat := range index.CategoryOrder {
		count := len(index.ByCategory[cat])
		b.WriteString(fmt.Sprintf("%s|%d\n", cat, count))
	}
	b.WriteString(".\n")
	return b.String()
}

func handleList(index *SearchIndex, category string, offset, count int, grouped bool) string {
	// Find matching category (case-insensitive)
	var matchedCat string
	for _, cat := range index.CategoryOrder {
		if strings.EqualFold(cat, category) {
			matchedCat = cat
			break
		}
	}
	if matchedCat == "" {
		return fmt.Sprintf("ERR Unknown category: %s\n", category)
	}

	entries := index.ByCategory[matchedCat]

	// If not grouped, return flat list (original behavior)
	if !grouped {
		total := len(entries)
		if offset >= total {
			return fmt.Sprintf("OK 0 %d\n.\n", total)
		}

		end := offset + count
		if count == 0 || end > total {
			end = total
		}

		var b strings.Builder
		b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

		for i := offset; i < end; i++ {
			idx := entries[i]
			entry := index.Entries[idx]
			// Format: ID|Name|Group|Year|Type
			b.WriteString(fmt.Sprintf("%d|%s|%s|%s|%s\n",
				idx, entry.Name, entry.Group, entry.Year, entry.FileType))
		}
		b.WriteString(".\n")
		return b.String()
	}

	// Grouped mode: group by normalized title within category
	seen := make(map[string]int) // "category:normalized_title" -> index in grouped slice
	var groupedEntries []groupedEntry

	for _, idx := range entries {
		entry := index.Entries[idx]
		norm := normalizeTitle(entry.Name)
		// Include category in key to prevent cross-category grouping
		groupKey := entry.CategoryName + ":" + norm

		// Get trainer count for this entry
		trainers := -1
		if entry.Crack != nil {
			trainers = entry.Crack.Trainers
		}

		if existingIdx, ok := seen[groupKey]; ok {
			groupedEntries[existingIdx].Count++
			if trainers > groupedEntries[existingIdx].MaxTrainers {
				groupedEntries[existingIdx].MaxTrainers = trainers
			}
		} else {
			seen[groupKey] = len(groupedEntries)
			groupedEntries = append(groupedEntries, groupedEntry{
				NormalizedTitle: norm,
				DisplayTitle:    entry.Name,
				Category:        matchedCat,
				FirstID:         idx,
				Count:           1,
				MaxTrainers:     trainers,
			})
		}
	}

	total := len(groupedEntries)
	if offset >= total {
		return fmt.Sprintf("OK 0 %d\n.\n", total)
	}

	end := offset + count
	if count == 0 || end > total {
		end = total
	}

	// Debug: log the first few entries being returned
	if offset == 0 && len(groupedEntries) > 0 {
		for i := 0; i < 3 && i < len(groupedEntries); i++ {
			g := groupedEntries[i]
			entry := index.Entries[g.FirstID]
			slog.Info("LIST grouped entry", "position", i, "id", g.FirstID, "name", g.DisplayTitle,
				"listCategory", g.Category, "entryCategory", entry.CategoryName, "path", entry.Path)
		}
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

	for i := offset; i < end; i++ {
		g := groupedEntries[i]
		// Format: ID|Name|Category|Count|Trainers (same as ADVSEARCH grouped)
		b.WriteString(fmt.Sprintf("%d|%s|%s|%d|%d\n",
			g.FirstID, g.DisplayTitle, g.Category, g.Count, g.MaxTrainers))
	}
	b.WriteString(".\n")
	return b.String()
}

func handleSearch(index *SearchIndex, query string, category string, offset, count int) string {
	query = strings.ToLower(query)
	var results []int

	// If category is specified and not "All", filter by category
	filterByCategory := category != "" && !strings.EqualFold(category, "All")

	for i, entry := range index.Entries {
		// Skip if category filter is active and doesn't match
		if filterByCategory && !strings.EqualFold(entry.CategoryName, category) {
			continue
		}
		if strings.Contains(strings.ToLower(entry.Name), query) ||
			strings.Contains(strings.ToLower(entry.Group), query) {
			results = append(results, i)
		}
	}

	total := len(results)
	if offset >= total {
		return fmt.Sprintf("OK 0 %d\n.\n", total)
	}

	// If count is 0, return all results from offset
	end := offset + count
	if count == 0 || end > total {
		end = total
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

	for i := offset; i < end; i++ {
		idx := results[i]
		entry := index.Entries[idx]
		b.WriteString(fmt.Sprintf("%d|%s|%s|%s|%s\n",
			idx, entry.Name, entry.Group, entry.Year, entry.FileType))
	}
	b.WriteString(".\n")
	return b.String()
}

func handleAdvSearch(index *SearchIndex, params map[string]string, offset, count int) string {
	var results []int

	// Extract filter parameters
	category := params["cat"]
	source := strings.ToLower(params["source"])
	title := strings.ToLower(params["title"])
	group := strings.ToLower(params["group"])
	fileType := strings.ToLower(params["type"])
	top200Only := params["top200"] == "1"
	grouped := params["grouped"] == "1"

	for i, entry := range index.Entries {
		// Category filter
		if category != "" && !strings.EqualFold(category, "All") {
			if !strings.EqualFold(entry.CategoryName, category) {
				continue
			}
		}

		// Source filter - check path for source identifier
		if source != "" {
			if !matchSource(entry.Path, source) {
				continue
			}
		}

		// Title filter (partial match)
		if title != "" && !strings.Contains(strings.ToLower(entry.Name), title) {
			continue
		}

		// Group filter (partial match)
		if group != "" && !strings.Contains(strings.ToLower(entry.Group), group) {
			continue
		}

		// File type filter (exact match)
		if fileType != "" && !strings.EqualFold(entry.FileType, fileType) {
			continue
		}

		// Top200 filter
		if top200Only && entry.Top200Rank == 0 {
			continue
		}

		results = append(results, i)
	}

	// If grouped mode, aggregate by normalized title
	if grouped {
		return handleGroupedResults(index, results, category, offset, count)
	}

	total := len(results)
	if offset >= total {
		return fmt.Sprintf("OK 0 %d\n.\n", total)
	}

	// If count is 0, return all results from offset
	end := offset + count
	if count == 0 || end > total {
		end = total
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

	for i := offset; i < end; i++ {
		idx := results[i]
		entry := index.Entries[idx]
		b.WriteString(fmt.Sprintf("%d|%s|%s|%s|%s\n",
			idx, entry.Name, entry.Group, entry.Year, entry.FileType))
	}
	b.WriteString(".\n")
	return b.String()
}

// handleGroupedResults groups matching entries by normalized title.
func handleGroupedResults(index *SearchIndex, results []int, category string, offset, count int) string {
	// Group by normalized title within each category, preserving order of first occurrence
	seen := make(map[string]int) // "category:normalized_title" -> index in grouped slice
	var grouped []groupedEntry

	for _, idx := range results {
		entry := index.Entries[idx]
		norm := normalizeTitle(entry.Name)
		// Include category in key to prevent cross-category grouping
		groupKey := entry.CategoryName + ":" + norm

		// Get trainer count for this entry (-1 = unknown, 0 = none or non-game)
		trainers := -1
		if entry.Crack != nil {
			trainers = entry.Crack.Trainers
		}

		if existingIdx, ok := seen[groupKey]; ok {
			// Increment count for existing group
			grouped[existingIdx].Count++
			// Track max trainers
			if trainers > grouped[existingIdx].MaxTrainers {
				grouped[existingIdx].MaxTrainers = trainers
			}
		} else {
			// New group
			seen[groupKey] = len(grouped)
			grouped = append(grouped, groupedEntry{
				NormalizedTitle: norm,
				DisplayTitle:    entry.Name,
				Category:        entry.CategoryName,
				FirstID:         idx,
				Count:           1,
				MaxTrainers:     trainers,
			})
		}
	}

	total := len(grouped)
	if offset >= total {
		return fmt.Sprintf("OK 0 %d\n.\n", total)
	}

	end := offset + count
	if count == 0 || end > total {
		end = total
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

	for i := offset; i < end; i++ {
		g := grouped[i]
		// Format: ID|Name|Category|Count|Trainers
		// ID is first entry's ID (used for single releases), Count indicates if grouped
		// Trainers: -1=unknown, 0=none, >0=trainer count
		b.WriteString(fmt.Sprintf("%d|%s|%s|%d|%d\n",
			g.FirstID, g.DisplayTitle, g.Category, g.Count, g.MaxTrainers))
	}
	b.WriteString(".\n")
	return b.String()
}

func handleInfo(index *SearchIndex, id int) string {
	if id < 0 || id >= len(index.Entries) {
		return "ERR Invalid ID\n"
	}

	entry := index.Entries[id]
	var b strings.Builder
	b.WriteString("OK\n")
	b.WriteString(fmt.Sprintf("NAME|%s\n", entry.Name))
	b.WriteString(fmt.Sprintf("GROUP|%s\n", entry.Group))
	b.WriteString(fmt.Sprintf("YEAR|%s\n", entry.Year))
	b.WriteString(fmt.Sprintf("CAT|%s\n", entry.CategoryName))
	b.WriteString(fmt.Sprintf("TYPE|%s\n", entry.FileType))
	b.WriteString(fmt.Sprintf("PATH|%s\n", entry.Path))

	// Games-specific: trainer info
	if strings.EqualFold(entry.CategoryName, "Games") {
		if entry.Crack != nil {
			b.WriteString(fmt.Sprintf("TRAINER|%d\n", entry.Crack.Trainers))
		} else {
			b.WriteString("TRAINER|unknown\n")
		}
	}

	b.WriteString(".\n")
	return b.String()
}

func handleRun(index *SearchIndex, apiClient *APIClient, assembly64Path string, id int) string {
	if id < 0 || id >= len(index.Entries) {
		return "ERR Invalid ID\n"
	}

	entry := index.Entries[id]

	// Debug: log exactly what entry is being run
	slog.Info("RUN command", "id", id, "name", entry.Name, "category", entry.CategoryName, "path", entry.Path)

	// Use FullPath which was computed during indexing
	fullPath := entry.FullPath
	if fullPath == "" {
		return "ERR Entry has no file path\n"
	}

	// Read file
	fileData, err := readFile(fullPath)
	if err != nil {
		slog.Error("Failed to read file", "path", fullPath, "error", err)
		return fmt.Sprintf("ERR Cannot read file: %s\n", err)
	}

	// Run based on file type
	var runErr error
	switch strings.ToLower(entry.FileType) {
	case "prg":
		runErr = apiClient.runPRG(fileData)
	case "crt":
		runErr = apiClient.runCRT(fileData)
	case "sid":
		runErr = apiClient.runSID(fileData)
	case "d64", "g64", "d71", "d81":
		runErr = apiClient.runDiskImage(fileData, entry.FileType, entry.Name)
	default:
		return fmt.Sprintf("ERR Unsupported file type: %s\n", entry.FileType)
	}

	if runErr != nil {
		slog.Error("Failed to run file", "path", fullPath, "error", runErr)
		return fmt.Sprintf("ERR Run failed: %s\n", runErr)
	}

	slog.Info("Running entry", "name", entry.Name, "type", entry.FileType)
	return fmt.Sprintf("OK Running %s\n", entry.Name)
}

// readFile reads a file from disk.
func readFile(path string) ([]byte, error) {
	return os.ReadFile(path)
}

// normalizeTitle normalizes a title for grouping purposes.
// Removes common suffixes like version numbers, crack info, etc.
func normalizeTitle(title string) string {
	t := strings.ToLower(title)
	// Remove common suffixes in parentheses or brackets
	for {
		// Remove trailing (...) or [...]
		if idx := strings.LastIndex(t, "("); idx > 0 {
			t = strings.TrimSpace(t[:idx])
			continue
		}
		if idx := strings.LastIndex(t, "["); idx > 0 {
			t = strings.TrimSpace(t[:idx])
			continue
		}
		break
	}
	// Trim spaces and underscores
	t = strings.TrimRight(t, " _-")
	return t
}

// groupedEntry represents a unique title with count of releases.
type groupedEntry struct {
	NormalizedTitle string
	DisplayTitle    string // Original title from first matching entry
	Category        string
	FirstID         int // ID of first matching entry (for single releases)
	Count           int // Number of releases with this title
	MaxTrainers     int // Maximum trainer count among all releases (-1 = unknown)
}

// handleListPath lists entries matching a path prefix, grouped by title.
// Path can be like "Games/CSDB/Top200" or "Games/CSDB/All/A" (letter filter).
func handleListPath(index *SearchIndex, pathFilter string, offset, count int) string {
	pathLower := strings.ToLower(pathFilter)

	// Check if last component is a letter filter (single char A-Z or #)
	parts := strings.Split(pathFilter, "/")
	letterFilter := ""
	if len(parts) > 0 {
		last := parts[len(parts)-1]
		if len(last) == 1 && ((last >= "A" && last <= "Z") || (last >= "a" && last <= "z") || last == "#") {
			letterFilter = strings.ToUpper(last)
			basePath := strings.Join(parts[:len(parts)-1], "/")
			pathLower = strings.ToLower(basePath)
		}
	}

	// Handle "All" virtual folder - strip it from the path for matching
	// "Games/C64com/All" should match entries under "Games/C64com"
	if strings.Contains(pathLower, "/all") {
		pathLower = strings.Replace(pathLower, "/all", "", 1)
	}

	// Collect matching entries
	var matchingEntries []int
	for i, entry := range index.Entries {
		if !strings.HasPrefix(strings.ToLower(entry.Path), pathLower) {
			continue
		}

		// Apply letter filter if specified
		if letterFilter != "" {
			if len(entry.Name) == 0 {
				continue
			}
			firstChar := strings.ToUpper(string(entry.Name[0]))
			if letterFilter == "#" {
				// Match non-alphabetic
				if firstChar >= "A" && firstChar <= "Z" {
					continue
				}
			} else if firstChar != letterFilter {
				continue
			}
		}

		matchingEntries = append(matchingEntries, i)
	}

	// Group by normalized title
	seen := make(map[string]int) // normalized_title -> index in grouped slice
	var grouped []groupedEntry

	for _, idx := range matchingEntries {
		entry := index.Entries[idx]
		norm := normalizeTitle(entry.Name)

		// Get trainer count for this entry
		trainers := -1
		if entry.Crack != nil {
			trainers = entry.Crack.Trainers
		}

		if existingIdx, ok := seen[norm]; ok {
			grouped[existingIdx].Count++
			if trainers > grouped[existingIdx].MaxTrainers {
				grouped[existingIdx].MaxTrainers = trainers
			}
		} else {
			seen[norm] = len(grouped)
			grouped = append(grouped, groupedEntry{
				NormalizedTitle: norm,
				DisplayTitle:    entry.Name,
				Category:        entry.CategoryName,
				FirstID:         idx,
				Count:           1,
				MaxTrainers:     trainers,
			})
		}
	}

	total := len(grouped)
	if offset >= total {
		return fmt.Sprintf("OK 0 %d\n.\n", total)
	}

	end := offset + count
	if count == 0 || end > total {
		end = total
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

	for i := offset; i < end; i++ {
		g := grouped[i]
		// Format: ID|Name|Category|Count|Trainers (same as grouped LIST)
		b.WriteString(fmt.Sprintf("%d|%s|%s|%d|%d\n",
			g.FirstID, g.DisplayTitle, g.Category, g.Count, g.MaxTrainers))
	}
	b.WriteString(".\n")
	return b.String()
}

// menuEntry represents an item in the hierarchical menu.
type menuEntry struct {
	Name    string // Display name
	Type    string // "folder" or "list"
	Path    string // Full path for navigation
	Count   int    // Number of items (for lists)
}

// handleMenu returns menu entries for hierarchical navigation.
// Path format: "" (root), "Games", "Games/CSDB", "Games/CSDB/Top200", etc.
func handleMenu(index *SearchIndex, path string) string {
	var entries []menuEntry

	if path == "" {
		// Root menu - show main categories
		entries = []menuEntry{
			{Name: "Games", Type: "folder", Path: "Games"},
			{Name: "Demos", Type: "folder", Path: "Demos"},
			{Name: "Music", Type: "folder", Path: "Music"},
			{Name: "Intros", Type: "folder", Path: "Intros"},
			{Name: "Graphics", Type: "folder", Path: "Graphics"},
			{Name: "Discmags", Type: "folder", Path: "Discmags"},
		}
	} else {
		entries = getMenuEntries(index, path)
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d\n", len(entries)))
	for _, e := range entries {
		// Format: type|name|path|count
		b.WriteString(fmt.Sprintf("%s|%s|%s|%d\n", e.Type, e.Name, e.Path, e.Count))
	}
	b.WriteString(".\n")
	return b.String()
}

// getMenuEntries returns menu entries for a given path.
func getMenuEntries(index *SearchIndex, path string) []menuEntry {
	parts := strings.Split(path, "/")
	category := parts[0]

	switch category {
	case "Games":
		return getGamesMenu(index, parts)
	case "Demos":
		return getDemosMenu(index, parts)
	case "Music":
		return getMusicMenu(index, parts)
	case "Intros":
		return getIntrosMenu(index, parts)
	case "Graphics":
		return getGraphicsMenu(index, parts)
	case "Discmags":
		return getDiscmagsMenu(index, parts)
	default:
		return nil
	}
}

// getGamesMenu returns menu entries for Games category.
func getGamesMenu(index *SearchIndex, parts []string) []menuEntry {
	if len(parts) == 1 {
		// Games/ - show sources
		return []menuEntry{
			{Name: "CSDB", Type: "folder", Path: "Games/CSDB"},
			{Name: "C64.com", Type: "folder", Path: "Games/C64com"},
			{Name: "Gamebase", Type: "folder", Path: "Games/Gamebase"},
			{Name: "Guybrush", Type: "folder", Path: "Games/Guybrush"},
			{Name: "Guybrush German", Type: "folder", Path: "Games/Guybrush-german"},
			{Name: "OneLoad64", Type: "folder", Path: "Games/OneLoad64"},
			{Name: "Mayhem CRT", Type: "folder", Path: "Games/Mayhem-crt"},
			{Name: "C64 Tapes", Type: "folder", Path: "Games/C64Tapes-org"},
			{Name: "Preservers", Type: "folder", Path: "Games/Preservers"},
			{Name: "SEUCK", Type: "folder", Path: "Games/SEUCK"},
		}
	}

	source := parts[1]
	if len(parts) == 2 {
		// Games/Source/ - show sub-categories
		switch source {
		case "CSDB":
			return []menuEntry{
				{Name: "Top 200", Type: "list", Path: "Games/CSDB/Top200", Count: countByPathPrefix(index, "Games/CSDB/Top200")},
				{Name: "4K Competition", Type: "list", Path: "Games/CSDB/4k", Count: countByPathPrefix(index, "Games/CSDB/4k")},
				{Name: "All (A-Z)", Type: "folder", Path: "Games/CSDB/All"},
			}
		default:
			// Other sources: go directly to A-Z letter folders
			// Don't use "All" in path - return letters with source as base
			return getLetterFoldersWithBase(index, "Games/"+source+"/All", "Games/"+source)
		}
	}

	// Games/CSDB/All/ or similar - show letter folders
	if len(parts) == 3 && parts[2] == "All" {
		return getLetterFolders(index, joinPath(parts))
	}

	// Games/CSDB/All/A - this is a terminal list path, return empty menu
	// Client should use LISTPATH directly for these paths
	if len(parts) == 4 {
		return nil
	}

	return nil
}

// getDemosMenu returns menu entries for Demos category.
func getDemosMenu(index *SearchIndex, parts []string) []menuEntry {
	if len(parts) == 1 {
		// Demos/ - show sources
		return []menuEntry{
			{Name: "CSDB", Type: "folder", Path: "Demos/CSDB"},
			{Name: "C64.com", Type: "folder", Path: "Demos/C64com"},
			{Name: "Guybrush", Type: "folder", Path: "Demos/Guybrush"},
		}
	}

	source := parts[1]
	if len(parts) == 2 {
		switch source {
		case "CSDB":
			return []menuEntry{
				{Name: "Top 200", Type: "list", Path: "Demos/CSDB/Top200", Count: countByPathPrefix(index, "Demos/CSDB/Top200")},
				{Name: "Top 500", Type: "list", Path: "Demos/CSDB/Top500", Count: countByPathPrefix(index, "Demos/CSDB/Top500")},
				{Name: "By Year", Type: "folder", Path: "Demos/CSDB/Year"},
				{Name: "Year Top 20", Type: "folder", Path: "Demos/CSDB/Year-top20"},
				{Name: "Onefile", Type: "folder", Path: "Demos/CSDB/Onefile"},
				{Name: "All (A-Z)", Type: "folder", Path: "Demos/CSDB/All"},
			}
		default:
			// Other sources: go directly to A-Z letter folders
			return getLetterFoldersWithBase(index, "Demos/"+source+"/All", "Demos/"+source)
		}
	}

	// Handle sub-folders
	if len(parts) >= 3 {
		subPath := parts[2]
		p := joinPath(parts)
		switch subPath {
		case "Year", "Year-top20":
			if len(parts) == 3 {
				return getYearFolders(index, p)
			}
			// Year selected - terminal list path, return empty menu
			return nil
		case "Onefile":
			if len(parts) == 3 {
				return getLetterFolders(index, p)
			}
			// Terminal list path
			return nil
		case "All":
			if len(parts) == 3 {
				return getLetterFolders(index, p)
			}
			// Terminal list path
			return nil
		}
	}

	return nil
}

// getMusicMenu returns menu entries for Music category.
func getMusicMenu(index *SearchIndex, parts []string) []menuEntry {
	if len(parts) == 1 {
		return []menuEntry{
			{Name: "CSDB", Type: "folder", Path: "Music/CSDB"},
			{Name: "HVSC", Type: "folder", Path: "Music/HVSC"},
			{Name: "2SID Collection", Type: "folder", Path: "Music/2sid-collection"},
			{Name: "3SID Collection", Type: "folder", Path: "Music/3sid-collection"},
		}
	}

	source := parts[1]
	if len(parts) == 2 {
		switch source {
		case "CSDB":
			return []menuEntry{
				{Name: "Top 200", Type: "list", Path: "Music/CSDB/Top200", Count: countByPathPrefix(index, "Music/CSDB/Top200")},
				{Name: "All (A-Z)", Type: "folder", Path: "Music/CSDB/All"},
			}
		default:
			// Other sources: go directly to A-Z letter folders
			return getLetterFoldersWithBase(index, "Music/"+source+"/All", "Music/"+source)
		}
	}

	if len(parts) >= 3 && parts[2] == "All" {
		p := joinPath(parts)
		if len(parts) == 3 {
			return getLetterFolders(index, p)
		}
		// Terminal list path
		return nil
	}

	return nil
}

// getIntrosMenu returns menu entries for Intros category.
func getIntrosMenu(index *SearchIndex, parts []string) []menuEntry {
	if len(parts) == 1 {
		return []menuEntry{
			{Name: "CSDB", Type: "folder", Path: "Intros/CSDB"},
			{Name: "C64.org", Type: "folder", Path: "Intros/C64org"},
		}
	}

	source := parts[1]
	if len(parts) == 2 {
		// Go directly to A-Z letter folders
		return getLetterFoldersWithBase(index, "Intros/"+source+"/All", "Intros/"+source)
	}

	if len(parts) >= 3 && parts[2] == "All" {
		p := joinPath(parts)
		if len(parts) == 3 {
			return getLetterFolders(index, p)
		}
		// Terminal list path
		return nil
	}

	return nil
}

// getGraphicsMenu returns menu entries for Graphics category.
func getGraphicsMenu(index *SearchIndex, parts []string) []menuEntry {
	if len(parts) == 1 {
		// Only one source, go directly to A-Z letter folders
		return getLetterFoldersWithBase(index, "Graphics/CSDB/All", "Graphics")
	}

	// Handle direct navigation to Graphics/CSDB
	if len(parts) == 2 {
		return getLetterFoldersWithBase(index, "Graphics/"+parts[1]+"/All", "Graphics/"+parts[1])
	}

	if len(parts) >= 3 && parts[2] == "All" {
		p := joinPath(parts)
		if len(parts) == 3 {
			return getLetterFolders(index, p)
		}
		// Terminal list path
		return nil
	}

	return nil
}

// getDiscmagsMenu returns menu entries for Discmags category.
func getDiscmagsMenu(index *SearchIndex, parts []string) []menuEntry {
	if len(parts) == 1 {
		// Only one source, go directly to A-Z letter folders
		return getLetterFoldersWithBase(index, "Discmags/CSDB/All", "Discmags")
	}

	// Handle direct navigation to Discmags/CSDB
	if len(parts) == 2 {
		return getLetterFoldersWithBase(index, "Discmags/"+parts[1]+"/All", "Discmags/"+parts[1])
	}

	if len(parts) >= 3 && parts[2] == "All" {
		p := joinPath(parts)
		if len(parts) == 3 {
			return getLetterFolders(index, p)
		}
		// Terminal list path
		return nil
	}

	return nil
}

// joinPath joins parts back into a path string.
func joinPath(parts []string) string {
	return strings.Join(parts, "/")
}

// countByPathPrefix counts entries whose path starts with prefix.
func countByPathPrefix(index *SearchIndex, prefix string) int {
	count := 0
	prefixLower := strings.ToLower(prefix)
	for _, entry := range index.Entries {
		if strings.HasPrefix(strings.ToLower(entry.Path), prefixLower) {
			count++
		}
	}
	return count
}

// getLetterFolders returns A-Z and # folders for alphabetical navigation.
func getLetterFolders(index *SearchIndex, basePath string) []menuEntry {
	// Check which letters have entries
	letterCounts := make(map[string]int)

	// If basePath ends with /All, use parent path for matching
	// "All" is a virtual folder - actual entries are under the parent path
	matchPath := basePath
	if strings.HasSuffix(basePath, "/All") {
		matchPath = basePath[:len(basePath)-4] // Remove "/All"
	}
	baseLower := strings.ToLower(matchPath)

	for _, entry := range index.Entries {
		if !strings.HasPrefix(strings.ToLower(entry.Path), baseLower) {
			continue
		}
		// Get first letter of title
		name := entry.Name
		if len(name) == 0 {
			continue
		}
		first := strings.ToUpper(string(name[0]))
		if first >= "A" && first <= "Z" {
			letterCounts[first]++
		} else {
			letterCounts["#"]++
		}
	}

	var entries []menuEntry
	// Add # for numbers/symbols first
	if count, ok := letterCounts["#"]; ok && count > 0 {
		entries = append(entries, menuEntry{
			Name:  "#",
			Type:  "list",
			Path:  basePath + "/#",
			Count: count,
		})
	}

	// Add A-Z
	for c := 'A'; c <= 'Z'; c++ {
		letter := string(c)
		if count, ok := letterCounts[letter]; ok && count > 0 {
			entries = append(entries, menuEntry{
				Name:  letter,
				Type:  "list",
				Path:  basePath + "/" + letter,
				Count: count,
			})
		}
	}

	return entries
}

// getLetterFoldersWithBase returns A-Z folders using matchPath for filtering but outputPath for the returned paths.
// This is used when we want to skip an intermediate menu level (like "All") but still match entries correctly.
func getLetterFoldersWithBase(index *SearchIndex, matchPath, outputPath string) []menuEntry {
	letterCounts := make(map[string]int)

	// If matchPath ends with /All, use parent path for matching
	actualMatchPath := matchPath
	if strings.HasSuffix(matchPath, "/All") {
		actualMatchPath = matchPath[:len(matchPath)-4]
	}
	baseLower := strings.ToLower(actualMatchPath)

	for _, entry := range index.Entries {
		if !strings.HasPrefix(strings.ToLower(entry.Path), baseLower) {
			continue
		}
		name := entry.Name
		if len(name) == 0 {
			continue
		}
		first := strings.ToUpper(string(name[0]))
		if first >= "A" && first <= "Z" {
			letterCounts[first]++
		} else {
			letterCounts["#"]++
		}
	}

	var entries []menuEntry
	if count, ok := letterCounts["#"]; ok && count > 0 {
		entries = append(entries, menuEntry{
			Name:  "#",
			Type:  "list",
			Path:  outputPath + "/#",
			Count: count,
		})
	}

	for c := 'A'; c <= 'Z'; c++ {
		letter := string(c)
		if count, ok := letterCounts[letter]; ok && count > 0 {
			entries = append(entries, menuEntry{
				Name:  letter,
				Type:  "list",
				Path:  outputPath + "/" + letter,
				Count: count,
			})
		}
	}

	return entries
}

// getYearFolders returns year folders for demos.
func getYearFolders(index *SearchIndex, basePath string) []menuEntry {
	yearCounts := make(map[string]int)
	baseLower := strings.ToLower(basePath)

	for _, entry := range index.Entries {
		if !strings.HasPrefix(strings.ToLower(entry.Path), baseLower) {
			continue
		}
		// Extract year from path after basePath
		relPath := entry.Path[len(basePath):]
		if len(relPath) > 0 && relPath[0] == '/' {
			relPath = relPath[1:]
		}
		parts := strings.Split(relPath, "/")
		if len(parts) > 0 && len(parts[0]) == 4 {
			year := parts[0]
			if _, err := strconv.Atoi(year); err == nil {
				yearCounts[year]++
			}
		}
	}

	// Sort years descending
	var years []string
	for year := range yearCounts {
		years = append(years, year)
	}
	// Simple bubble sort descending
	for i := 0; i < len(years); i++ {
		for j := i + 1; j < len(years); j++ {
			if years[j] > years[i] {
				years[i], years[j] = years[j], years[i]
			}
		}
	}

	var entries []menuEntry
	for _, year := range years {
		entries = append(entries, menuEntry{
			Name:  year,
			Type:  "list",
			Path:  basePath + "/" + year,
			Count: yearCounts[year],
		})
	}

	return entries
}

// matchSource checks if an entry path matches a source filter.
// Source names map to path components:
// - csdb -> /CSDB/
// - c64com -> /C64com/
// - gamebase -> /Gamebase/
// - guybrush -> /Guybrush/ (but not Guybrush-german)
// - guybrush-ger -> /Guybrush-german/
// - oneload64 -> /OneLoad64/
// - mayhem-crt -> /Mayhem-crt/
// - c64tapes -> /C64Tapes-org/
// - preservers -> /Preservers/
// - seuck -> /SEUCK/
// - c64org -> /C64org/
// - hvsc -> /HVSC/
// - 2sid -> /2sid-collection/
// - 3sid -> /3sid-collection/
func matchSource(path, source string) bool {
	pathLower := strings.ToLower(path)
	switch source {
	case "csdb":
		return strings.Contains(pathLower, "/csdb/")
	case "c64com":
		return strings.Contains(pathLower, "/c64com/")
	case "gamebase":
		return strings.Contains(pathLower, "/gamebase/")
	case "guybrush":
		// Match /Guybrush/ but not /Guybrush-german/
		return strings.Contains(pathLower, "/guybrush/") && !strings.Contains(pathLower, "/guybrush-german/")
	case "guybrush-ger":
		return strings.Contains(pathLower, "/guybrush-german/")
	case "oneload64":
		return strings.Contains(pathLower, "/oneload64/")
	case "mayhem-crt":
		return strings.Contains(pathLower, "/mayhem-crt/")
	case "c64tapes":
		return strings.Contains(pathLower, "/c64tapes-org/")
	case "preservers":
		return strings.Contains(pathLower, "/preservers/")
	case "seuck":
		return strings.Contains(pathLower, "/seuck/")
	case "c64org":
		return strings.Contains(pathLower, "/c64org/")
	case "hvsc":
		return strings.Contains(pathLower, "/hvsc/")
	case "2sid":
		return strings.Contains(pathLower, "/2sid-collection/")
	case "3sid":
		return strings.Contains(pathLower, "/3sid-collection/")
	default:
		return true // Unknown source, don't filter
	}
}

// handleReleases returns all releases matching a specific title.
// The pathOrCategory can be a path prefix (e.g., "Games/CSDB/All/A") or a category name (e.g., "Games").
func handleReleases(index *SearchIndex, pathOrCategory, title string, offset, count int) string {
	normalizedSearch := normalizeTitle(title)
	var results []int

	// Determine if it's a path (contains /) or a simple category
	isPath := strings.Contains(pathOrCategory, "/")
	pathLower := strings.ToLower(pathOrCategory)

	// Handle "All" virtual folder - strip it from the path for matching
	if strings.Contains(pathLower, "/all") {
		pathLower = strings.Replace(pathLower, "/all", "", 1)
	}

	for i, entry := range index.Entries {
		// Path/category filter
		if pathOrCategory != "" && !strings.EqualFold(pathOrCategory, "All") {
			if isPath {
				// Path-based filtering (like LISTPATH)
				if !strings.HasPrefix(strings.ToLower(entry.Path), pathLower) {
					continue
				}
			} else {
				// Simple category filtering (legacy)
				if !strings.EqualFold(entry.CategoryName, pathOrCategory) {
					continue
				}
			}
		}

		// Match normalized title
		if normalizeTitle(entry.Name) == normalizedSearch {
			results = append(results, i)
		}
	}

	total := len(results)
	if offset >= total {
		return fmt.Sprintf("OK 0 %d\n.\n", total)
	}

	end := offset + count
	if count == 0 || end > total {
		end = total
	}

	var b strings.Builder
	b.WriteString(fmt.Sprintf("OK %d %d\n", end-offset, total))

	for i := offset; i < end; i++ {
		idx := results[i]
		entry := index.Entries[idx]
		// Get trainer count (-1 = unknown)
		trainers := -1
		if entry.Crack != nil {
			trainers = entry.Crack.Trainers
		}
		// Format: ID|Group|Year|Type|Trainers (name omitted since all same title)
		b.WriteString(fmt.Sprintf("%d|%s|%s|%s|%d\n",
			idx, entry.Group, entry.Year, entry.FileType, trainers))
	}
	b.WriteString(".\n")
	return b.String()
}
