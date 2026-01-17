// Database generator for Assembly64 collections.
// Scans directory structure and generates JSON database files.
package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"time"
)

// DBEntry represents a single entry in our JSON database.
// This is a unified structure - fields are populated based on category.
type DBEntry struct {
	ID          int        `json:"id"`
	Category    string     `json:"category"`
	Title       string     `json:"title"`
	ReleaseName string     `json:"releaseName,omitempty"` // Games only
	Group       string     `json:"group"`
	Top200Rank  *int       `json:"top200Rank,omitempty"`
	Top500Rank  *int       `json:"top500Rank,omitempty"`  // Demos only
	Is4k        bool       `json:"is4k,omitempty"`        // Games: 4k competition; Demos: unused
	Path        string     `json:"path"`
	Files       []DBFile   `json:"files"`
	PrimaryFile string     `json:"primaryFile"`
	FileType    string     `json:"fileType"`
	Crack       *CrackInfo `json:"crack,omitempty"` // Games only
	Language    string     `json:"language,omitempty"`
	Region      string     `json:"region,omitempty"`
	Engine      string     `json:"engine,omitempty"`
	IsPreview   bool       `json:"isPreview,omitempty"`
	Version     string     `json:"version,omitempty"`
	// Demos-specific fields
	Year        *int    `json:"year,omitempty"`
	YearRank    *int    `json:"yearRank,omitempty"`    // Rank within year's top 20
	Party       string  `json:"party,omitempty"`       // Party/event name
	PartyRank   *int    `json:"partyRank,omitempty"`   // Placement at party
	Competition string  `json:"competition,omitempty"` // Competition type (e.g., "C64 Demo")
	IsOnefile   bool    `json:"isOnefile,omitempty"`   // Single-file demo
	Rating      float64 `json:"rating,omitempty"`      // CSDB rating (0 if not rated)
	// Music-specific fields
	Author     string `json:"author,omitempty"`     // Composer/artist name (from HVSC path)
	Collection string `json:"collection,omitempty"` // Source collection: csdb, hvsc, 2sid, 3sid
}

// DBFile represents a file within a release.
type DBFile struct {
	Name string `json:"name"`
	Type string `json:"type"`
	Size int64  `json:"size"`
}

// CrackInfo contains parsed crack/trainer information.
type CrackInfo struct {
	IsCracked bool     `json:"isCracked"`
	Trainers  int      `json:"trainers"`
	Flags     []string `json:"flags,omitempty"`
}

// Database represents the complete JSON database structure.
type Database struct {
	Version      string    `json:"version"`
	Generated    string    `json:"generated"`
	Source       string    `json:"source"`
	TotalEntries int       `json:"totalEntries"`
	Entries      []DBEntry `json:"entries"`
}

// Supported file extensions for C64 programs.
var supportedExtensions = map[string]bool{
	".prg": true, ".PRG": true,
	".d64": true, ".D64": true,
	".t64": true, ".T64": true,
	".tap": true, ".TAP": true,
	".crt": true, ".CRT": true,
	".d71": true, ".D71": true,
	".d81": true, ".D81": true,
	".g64": true, ".G64": true,
	".sid": true, ".SID": true,
}

// File type priority for selecting primary file.
var fileTypePriority = []string{".sid", ".d64", ".prg", ".crt", ".t64", ".tap", ".d71", ".d81", ".g64"}

// Regex patterns for parsing release names.
var (
	trainerPattern  = regexp.MustCompile(`\+(\d*)([DFHPTIGRS]*)`)
	languagePattern = regexp.MustCompile(`\[(german|french|english|spanish|italian|dutch|swedish|polish|hungarian|english\+german)\]`)
	enginePattern   = regexp.MustCompile(`\[(seuck|gkgm|bdck|shoot)\]`)
	versionPattern  = regexp.MustCompile(`[Vv](\d+\.?\d*)`)
	regionPattern   = regexp.MustCompile(`\b(NTSC|PAL)\b`)
	previewPattern  = regexp.MustCompile(`(?i)\bpreview\b`)
)

// Flag code to name mapping.
var flagNames = map[byte]string{
	'D': "docs",
	'F': "fastload",
	'H': "highscore",
	'P': "palntscfix",
	'T': "tape",
	'I': "intro",
	'G': "gfx",
	'R': "trainer",
	'S': "save",
}

// parseCrackInfo extracts crack/trainer information from release name.
func parseCrackInfo(releaseName string) *CrackInfo {
	if !strings.Contains(releaseName, "+") {
		return nil
	}

	info := &CrackInfo{
		IsCracked: true,
		Trainers:  0,
		Flags:     []string{},
	}

	matches := trainerPattern.FindStringSubmatch(releaseName)
	if len(matches) >= 2 {
		if matches[1] != "" {
			info.Trainers, _ = strconv.Atoi(matches[1])
		}
		if len(matches) >= 3 && matches[2] != "" {
			for _, c := range matches[2] {
				if name, ok := flagNames[byte(c)]; ok {
					info.Flags = append(info.Flags, name)
				}
			}
		}
	}

	// Check for multi-disk indicators.
	diskPattern := regexp.MustCompile(`(\d)D\b`)
	if diskMatch := diskPattern.FindStringSubmatch(releaseName); len(diskMatch) >= 2 {
		info.Flags = append(info.Flags, diskMatch[1]+"disk")
	}

	if len(info.Flags) == 0 {
		info.Flags = nil
	}

	return info
}

// parseLanguage extracts language from release name.
func parseLanguage(releaseName string) string {
	if match := languagePattern.FindStringSubmatch(releaseName); len(match) >= 2 {
		return match[1]
	}
	return ""
}

// parseEngine extracts game engine from release name.
func parseEngine(releaseName string) string {
	if match := enginePattern.FindStringSubmatch(releaseName); len(match) >= 2 {
		return match[1]
	}
	return ""
}

// parseVersion extracts version from release name.
func parseVersion(releaseName string) string {
	if match := versionPattern.FindStringSubmatch(releaseName); len(match) >= 2 {
		return match[1]
	}
	return ""
}

// parseRegion extracts region (PAL/NTSC) from release name.
func parseRegion(releaseName string) string {
	if match := regionPattern.FindStringSubmatch(releaseName); len(match) >= 2 {
		return match[1]
	}
	return ""
}

// isPreview checks if release is a preview.
func isPreview(releaseName string) bool {
	return previewPattern.MatchString(releaseName)
}

// scanReleaseFolder scans a release folder and returns file information.
func scanReleaseFolder(folderPath string) ([]DBFile, string, string) {
	var files []DBFile
	var primaryFile string
	var fileType string

	entries, err := os.ReadDir(folderPath)
	if err != nil {
		return nil, "", ""
	}

	// Collect all supported files.
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}

		ext := filepath.Ext(entry.Name())
		if !supportedExtensions[ext] {
			continue
		}

		info, err := entry.Info()
		if err != nil {
			continue
		}

		files = append(files, DBFile{
			Name: entry.Name(),
			Type: strings.ToLower(strings.TrimPrefix(ext, ".")),
			Size: info.Size(),
		})
	}

	if len(files) == 0 {
		return nil, "", ""
	}

	// Select primary file by priority.
	for _, ext := range fileTypePriority {
		for _, f := range files {
			if strings.EqualFold("."+f.Type, ext) {
				primaryFile = f.Name
				fileType = f.Type
				break
			}
		}
		if primaryFile != "" {
			break
		}
	}

	// Fallback to first file.
	if primaryFile == "" && len(files) > 0 {
		primaryFile = files[0].Name
		fileType = files[0].Type
	}

	return files, primaryFile, fileType
}

// buildTop200Map scans Top200 folder and returns a map of title -> rank.
func buildTop200Map(basePath string) map[string]int {
	top200Map := make(map[string]int)
	top200Path := filepath.Join(basePath, "Games", "CSDB", "Top200")

	entries, err := os.ReadDir(top200Path)
	if err != nil {
		return top200Map
	}

	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		name := entry.Name()
		if match := rankPattern.FindStringSubmatch(name); len(match) >= 3 {
			rank, _ := strconv.Atoi(match[1])
			title := strings.TrimSpace(match[2])
			top200Map[strings.ToLower(title)] = rank
		}
	}

	return top200Map
}

// build4kMap scans 4k folder and returns a set of titles.
func build4kMap(basePath string) map[string]bool {
	fourKMap := make(map[string]bool)
	fourKPath := filepath.Join(basePath, "Games", "CSDB", "4k")

	// Walk through the 4k directory structure.
	filepath.WalkDir(fourKPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		// Skip non-directories and root.
		if !d.IsDir() || path == fourKPath {
			return nil
		}

		rel, _ := filepath.Rel(fourKPath, path)
		parts := strings.Split(rel, string(os.PathSeparator))

		// Title is at level 2 (Letter/Title).
		if len(parts) == 2 {
			fourKMap[strings.ToLower(parts[1])] = true
		}

		return nil
	})

	return fourKMap
}

// GenerateGamesDB generates the games.json database file.
func GenerateGamesDB(basePath, outputPath string) error {
	fmt.Println("Scanning Games/CSDB/All...")

	// Build metadata maps from Top200 and 4k folders.
	fmt.Println("Building Top200 rank map...")
	top200Map := buildTop200Map(basePath)
	fmt.Printf("  Found %d Top200 entries\n", len(top200Map))

	fmt.Println("Building 4k games map...")
	fourKMap := build4kMap(basePath)
	fmt.Printf("  Found %d 4k entries\n", len(fourKMap))

	// Scan the main Games/CSDB/All directory.
	allPath := filepath.Join(basePath, "Games", "CSDB", "All")

	var entries []DBEntry
	entryID := 1

	// Walk through: Letter / Range / Title / Group / ReleaseName
	err := filepath.WalkDir(allPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		// Get relative path from All directory.
		rel, _ := filepath.Rel(allPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want release folders at level 5: Letter/Range/Title/Group/ReleaseName
		if len(parts) != 5 {
			return nil
		}

		// Extract metadata from path.
		title := parts[2]       // Title folder
		group := parts[3]       // Group folder
		releaseName := parts[4] // Release name folder

		// Scan the release folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join("Games", "CSDB", "All", rel)

		// Check Top200 rank.
		var top200Rank *int
		if rank, ok := top200Map[strings.ToLower(title)]; ok {
			top200Rank = &rank
		}

		// Check if 4k game.
		is4k := fourKMap[strings.ToLower(title)]

		// Parse release name metadata.
		entry := DBEntry{
			ID:          entryID,
			Category:    "games",
			Title:       title,
			ReleaseName: releaseName,
			Group:       group,
			Top200Rank:  top200Rank,
			Is4k:        is4k,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
			Crack:       parseCrackInfo(releaseName),
			Language:    parseLanguage(releaseName),
			Region:      parseRegion(releaseName),
			Engine:      parseEngine(releaseName),
			IsPreview:   isPreview(releaseName),
			Version:     parseVersion(releaseName),
		}

		entries = append(entries, entry)
		entryID++

		if entryID%10000 == 0 {
			fmt.Printf("  Processed %d entries...\n", entryID-1)
		}

		return nil
	})

	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	// Build database structure.
	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "csdb",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	// Write JSON file.
	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// demoKey creates a lookup key for demos (group + title, lowercased).
func demoKey(group, title string) string {
	return strings.ToLower(group) + "\x00" + strings.ToLower(title)
}

// buildDemosTop200Map scans Demos/CSDB/Top200 folder and returns a map of title -> rank.
func buildDemosTop200Map(basePath string) map[string]int {
	top200Map := make(map[string]int)
	top200Path := filepath.Join(basePath, "Demos", "CSDB", "Top200")

	entries, err := os.ReadDir(top200Path)
	if err != nil {
		return top200Map
	}

	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		name := entry.Name()
		if match := rankPattern.FindStringSubmatch(name); len(match) >= 3 {
			rank, _ := strconv.Atoi(match[1])
			title := strings.TrimSpace(match[2])
			top200Map[strings.ToLower(title)] = rank
		}
	}

	return top200Map
}

// buildDemosTop500Map scans Demos/CSDB/Top500 folder and returns a map of title -> rank.
func buildDemosTop500Map(basePath string) map[string]int {
	top500Map := make(map[string]int)
	top500Path := filepath.Join(basePath, "Demos", "CSDB", "Top500")

	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	// Top500 has subdirectories like 001-100, 101-200, etc.
	entries, err := os.ReadDir(top500Path)
	if err != nil {
		return top500Map
	}

	for _, rangeDir := range entries {
		if !rangeDir.IsDir() {
			continue
		}

		rangePath := filepath.Join(top500Path, rangeDir.Name())
		demoEntries, err := os.ReadDir(rangePath)
		if err != nil {
			continue
		}

		for _, entry := range demoEntries {
			if !entry.IsDir() {
				continue
			}

			name := entry.Name()
			if match := rankPattern.FindStringSubmatch(name); len(match) >= 3 {
				rank, _ := strconv.Atoi(match[1])
				title := strings.TrimSpace(match[2])
				top500Map[strings.ToLower(title)] = rank
			}
		}
	}

	return top500Map
}

// DemoYearInfo holds year-related metadata for a demo.
type DemoYearInfo struct {
	Year     int
	YearRank int // 0 if not in year's top 20
}

// buildDemosYearMap scans Year/ and Year-top20/ folders.
// Returns map of group+title -> DemoYearInfo.
func buildDemosYearMap(basePath string) map[string]DemoYearInfo {
	yearMap := make(map[string]DemoYearInfo)
	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	// Scan Year/ directory: Year/{Year}/{Group}/{Title}/
	yearPath := filepath.Join(basePath, "Demos", "CSDB", "Year")
	if years, err := os.ReadDir(yearPath); err == nil {
		for _, yearDir := range years {
			if !yearDir.IsDir() {
				continue
			}
			year, err := strconv.Atoi(yearDir.Name())
			if err != nil {
				continue
			}

			groupsPath := filepath.Join(yearPath, yearDir.Name())
			groups, err := os.ReadDir(groupsPath)
			if err != nil {
				continue
			}

			for _, groupDir := range groups {
				if !groupDir.IsDir() {
					continue
				}
				group := groupDir.Name()

				titlesPath := filepath.Join(groupsPath, group)
				titles, err := os.ReadDir(titlesPath)
				if err != nil {
					continue
				}

				for _, titleDir := range titles {
					if !titleDir.IsDir() {
						continue
					}
					key := demoKey(group, titleDir.Name())
					// Only set year if not already set (prefer first/earliest year found)
					if _, exists := yearMap[key]; !exists {
						yearMap[key] = DemoYearInfo{Year: year}
					}
				}
			}
		}
	}

	// Scan Year-top20/ directory: Year-top20/{Year}/{Rank. Title}/
	yearTop20Path := filepath.Join(basePath, "Demos", "CSDB", "Year-top20")
	if years, err := os.ReadDir(yearTop20Path); err == nil {
		for _, yearDir := range years {
			if !yearDir.IsDir() {
				continue
			}
			year, err := strconv.Atoi(yearDir.Name())
			if err != nil {
				continue
			}

			demosPath := filepath.Join(yearTop20Path, yearDir.Name())
			demos, err := os.ReadDir(demosPath)
			if err != nil {
				continue
			}

			for _, demoDir := range demos {
				if !demoDir.IsDir() {
					continue
				}
				name := demoDir.Name()
				if match := rankPattern.FindStringSubmatch(name); len(match) >= 3 {
					rank, _ := strconv.Atoi(match[1])
					title := strings.TrimSpace(match[2])
					// Store by title only (we don't have group here)
					titleKey := strings.ToLower(title)
					// We'll need to match this later by title only
					yearMap["_title_"+titleKey] = DemoYearInfo{Year: year, YearRank: rank}
				}
			}
		}
	}

	return yearMap
}

// DemoPartyInfo holds party-related metadata for a demo.
type DemoPartyInfo struct {
	Year        int
	Party       string
	PartyRank   int
	Competition string
}

// buildDemosPartyMap scans Year-party-group/ folder.
// Returns map of group+title -> DemoPartyInfo.
func buildDemosPartyMap(basePath string) map[string]DemoPartyInfo {
	partyMap := make(map[string]DemoPartyInfo)
	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	// Year-party-group/{Year}/{Party}/{Competition?}/{Rank. Group}/
	baseDirPath := filepath.Join(basePath, "Demos", "CSDB", "Year-party-group")
	years, err := os.ReadDir(baseDirPath)
	if err != nil {
		return partyMap
	}

	for _, yearDir := range years {
		if !yearDir.IsDir() {
			continue
		}
		year, err := strconv.Atoi(yearDir.Name())
		if err != nil {
			continue
		}

		yearPath := filepath.Join(baseDirPath, yearDir.Name())
		parties, _ := os.ReadDir(yearPath)

		for _, partyDir := range parties {
			if !partyDir.IsDir() {
				continue
			}
			partyName := partyDir.Name()
			partyPath := filepath.Join(yearPath, partyName)

			// Check if this party has competition subdirectories or direct group entries
			partyContents, _ := os.ReadDir(partyPath)
			for _, content := range partyContents {
				if !content.IsDir() {
					continue
				}

				// Check if this is a ranked group entry (e.g., "01. Censor Design")
				if match := rankPattern.FindStringSubmatch(content.Name()); len(match) >= 3 {
					// Direct group entry (no competition subdir)
					rank, _ := strconv.Atoi(match[1])
					group := strings.TrimSpace(match[2])
					groupPath := filepath.Join(partyPath, content.Name())

					// Scan for titles in this group folder
					titles, _ := os.ReadDir(groupPath)
					for _, titleDir := range titles {
						if titleDir.IsDir() {
							key := demoKey(group, titleDir.Name())
							partyMap[key] = DemoPartyInfo{
								Year:      year,
								Party:     partyName,
								PartyRank: rank,
							}
						}
					}
				} else {
					// This might be a competition subdir (e.g., "C64 Demo")
					competition := content.Name()
					compPath := filepath.Join(partyPath, competition)
					groupEntries, _ := os.ReadDir(compPath)

					for _, groupEntry := range groupEntries {
						if !groupEntry.IsDir() {
							continue
						}
						if match := rankPattern.FindStringSubmatch(groupEntry.Name()); len(match) >= 3 {
							rank, _ := strconv.Atoi(match[1])
							group := strings.TrimSpace(match[2])
							groupPath := filepath.Join(compPath, groupEntry.Name())

							// Scan for titles (usually files directly)
							titles, _ := os.ReadDir(groupPath)
							for _, titleEntry := range titles {
								if titleEntry.IsDir() {
									key := demoKey(group, titleEntry.Name())
									partyMap[key] = DemoPartyInfo{
										Year:        year,
										Party:       partyName,
										PartyRank:   rank,
										Competition: competition,
									}
								}
							}

							// If no subdirs, the group folder IS the demo folder
							// Try to find matching title from files
							if len(titles) > 0 && !titles[0].IsDir() {
								// Use group as key with empty title - we'll match by group later
								key := demoKey(group, "")
								partyMap[key] = DemoPartyInfo{
									Year:        year,
									Party:       partyName,
									PartyRank:   rank,
									Competition: competition,
								}
							}
						}
					}
				}
			}
		}
	}

	return partyMap
}

// buildDemosOnefileMap scans Onefile/ folder and returns set of group+title.
func buildDemosOnefileMap(basePath string) map[string]bool {
	onefileMap := make(map[string]bool)

	// Onefile/{Letter}/{Group}/{Title}/
	onefilePath := filepath.Join(basePath, "Demos", "CSDB", "Onefile")
	letters, err := os.ReadDir(onefilePath)
	if err != nil {
		return onefileMap
	}

	for _, letterDir := range letters {
		if !letterDir.IsDir() {
			continue
		}

		letterPath := filepath.Join(onefilePath, letterDir.Name())
		groups, _ := os.ReadDir(letterPath)

		for _, groupDir := range groups {
			if !groupDir.IsDir() {
				continue
			}
			group := groupDir.Name()
			groupPath := filepath.Join(letterPath, group)
			titles, _ := os.ReadDir(groupPath)

			for _, titleDir := range titles {
				if titleDir.IsDir() {
					key := demoKey(group, titleDir.Name())
					onefileMap[key] = true
				}
			}
		}
	}

	return onefileMap
}

// DemoRatingInfo holds rating information.
type DemoRatingInfo struct {
	Rating float64
	Year   int
}

// buildDemosRatingMap scans Rating-year-group/ and top200 folders with ratings.
func buildDemosRatingMap(basePath string) map[string]DemoRatingInfo {
	ratingMap := make(map[string]DemoRatingInfo)

	// Parse rating from folder names like "001. (10.0) Title"
	ratingPattern := regexp.MustCompile(`^\d+\.\s*\((\d+\.?\d*)\)\s*(.+)$`)

	// Scan Onefile-top200 for ratings
	onefileTop200Path := filepath.Join(basePath, "Demos", "CSDB", "Onefile-top200")
	if entries, err := os.ReadDir(onefileTop200Path); err == nil {
		for _, entry := range entries {
			if !entry.IsDir() {
				continue
			}
			if match := ratingPattern.FindStringSubmatch(entry.Name()); len(match) >= 3 {
				rating, _ := strconv.ParseFloat(match[1], 64)
				title := strings.TrimSpace(match[2])
				ratingMap["_title_"+strings.ToLower(title)] = DemoRatingInfo{Rating: rating}
			}
		}
	}

	// Scan Misc-top200 for ratings
	miscTop200Path := filepath.Join(basePath, "Demos", "CSDB", "Misc-top200")
	if entries, err := os.ReadDir(miscTop200Path); err == nil {
		for _, entry := range entries {
			if !entry.IsDir() {
				continue
			}
			if match := ratingPattern.FindStringSubmatch(entry.Name()); len(match) >= 3 {
				rating, _ := strconv.ParseFloat(match[1], 64)
				title := strings.TrimSpace(match[2])
				ratingMap["_title_"+strings.ToLower(title)] = DemoRatingInfo{Rating: rating}
			}
		}
	}

	// Scan Rating-year-group: {Rating}/{Year}/{Group}/{Title}
	ratingYearPath := filepath.Join(basePath, "Demos", "CSDB", "Rating-year-group")
	if ratings, err := os.ReadDir(ratingYearPath); err == nil {
		for _, ratingDir := range ratings {
			if !ratingDir.IsDir() {
				continue
			}
			rating, err := strconv.ParseFloat(ratingDir.Name(), 64)
			if err != nil {
				continue
			}

			ratingPath := filepath.Join(ratingYearPath, ratingDir.Name())
			years, _ := os.ReadDir(ratingPath)

			for _, yearDir := range years {
				if !yearDir.IsDir() {
					continue
				}
				year, err := strconv.Atoi(yearDir.Name())
				if err != nil {
					continue
				}

				yearPath := filepath.Join(ratingPath, yearDir.Name())
				groups, _ := os.ReadDir(yearPath)

				for _, groupDir := range groups {
					if !groupDir.IsDir() {
						continue
					}
					group := groupDir.Name()
					groupPath := filepath.Join(yearPath, group)
					titles, _ := os.ReadDir(groupPath)

					for _, titleDir := range titles {
						if titleDir.IsDir() {
							key := demoKey(group, titleDir.Name())
							ratingMap[key] = DemoRatingInfo{Rating: rating, Year: year}
						}
					}
				}
			}
		}
	}

	return ratingMap
}

// GenerateDemosDB generates the demos JSON database file.
func GenerateDemosDB(basePath, outputPath string) error {
	fmt.Println("Scanning Demos/CSDB/All...")

	// Build metadata maps from various folders.
	fmt.Println("Building demos metadata maps...")

	fmt.Print("  Top200... ")
	top200Map := buildDemosTop200Map(basePath)
	fmt.Printf("%d entries\n", len(top200Map))

	fmt.Print("  Top500... ")
	top500Map := buildDemosTop500Map(basePath)
	fmt.Printf("%d entries\n", len(top500Map))

	fmt.Print("  Year data... ")
	yearMap := buildDemosYearMap(basePath)
	fmt.Printf("%d entries\n", len(yearMap))

	fmt.Print("  Party data... ")
	partyMap := buildDemosPartyMap(basePath)
	fmt.Printf("%d entries\n", len(partyMap))

	fmt.Print("  Onefile... ")
	onefileMap := buildDemosOnefileMap(basePath)
	fmt.Printf("%d entries\n", len(onefileMap))

	fmt.Print("  Ratings... ")
	ratingMap := buildDemosRatingMap(basePath)
	fmt.Printf("%d entries\n", len(ratingMap))

	// Scan the main Demos/CSDB/All directory.
	// Structure: All/{Letter}/{Group}/{Title}/
	allPath := filepath.Join(basePath, "Demos", "CSDB", "All")

	var entries []DBEntry
	entryID := 1

	err := filepath.WalkDir(allPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		// Get relative path from All directory.
		rel, _ := filepath.Rel(allPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want demo folders at level 3: Letter/Group/Title
		if len(parts) != 3 {
			return nil
		}

		group := parts[1] // Group folder
		title := parts[2] // Title folder

		// Scan the demo folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join("Demos", "CSDB", "All", rel)

		// Look up metadata from cross-reference maps.
		key := demoKey(group, title)
		titleKey := "_title_" + strings.ToLower(title)

		// Top200 rank (by title)
		var top200Rank *int
		if rank, ok := top200Map[strings.ToLower(title)]; ok {
			top200Rank = &rank
		}

		// Top500 rank (by title)
		var top500Rank *int
		if rank, ok := top500Map[strings.ToLower(title)]; ok {
			top500Rank = &rank
		}

		// Year info
		var year *int
		var yearRank *int
		if info, ok := yearMap[key]; ok {
			year = &info.Year
			if info.YearRank > 0 {
				yearRank = &info.YearRank
			}
		}
		// Also check by title only for year-top20
		if info, ok := yearMap[titleKey]; ok {
			if year == nil {
				year = &info.Year
			}
			if info.YearRank > 0 {
				yearRank = &info.YearRank
			}
		}

		// Party info
		var party string
		var partyRank *int
		var competition string
		if info, ok := partyMap[key]; ok {
			party = info.Party
			if info.PartyRank > 0 {
				partyRank = &info.PartyRank
			}
			competition = info.Competition
			if year == nil && info.Year > 0 {
				year = &info.Year
			}
		}

		// Onefile flag
		isOnefile := onefileMap[key]

		// Rating
		var rating float64
		if info, ok := ratingMap[key]; ok {
			rating = info.Rating
			if year == nil && info.Year > 0 {
				year = &info.Year
			}
		}
		// Also check by title only for ratings
		if info, ok := ratingMap[titleKey]; ok && rating == 0 {
			rating = info.Rating
		}

		entry := DBEntry{
			ID:          entryID,
			Category:    "demos",
			Title:       title,
			Group:       group,
			Top200Rank:  top200Rank,
			Top500Rank:  top500Rank,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
			Year:        year,
			YearRank:    yearRank,
			Party:       party,
			PartyRank:   partyRank,
			Competition: competition,
			IsOnefile:   isOnefile,
			Rating:      rating,
		}

		entries = append(entries, entry)
		entryID++

		if entryID%10000 == 0 {
			fmt.Printf("  Processed %d entries...\n", entryID-1)
		}

		return nil
	})

	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	// Build database structure.
	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "csdb",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	// Write JSON file.
	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// buildMusicTop200Map scans Music/CSDB/Top200 folder and returns a map of title -> rank.
func buildMusicTop200Map(basePath string) map[string]int {
	top200Map := make(map[string]int)
	top200Path := filepath.Join(basePath, "Music", "CSDB", "Top200")

	entries, err := os.ReadDir(top200Path)
	if err != nil {
		return top200Map
	}

	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		name := entry.Name()
		if match := rankPattern.FindStringSubmatch(name); len(match) >= 3 {
			rank, _ := strconv.Atoi(match[1])
			title := strings.TrimSpace(match[2])
			top200Map[strings.ToLower(title)] = rank
		}
	}

	return top200Map
}

// MusicPartyInfo holds party-related metadata for music.
type MusicPartyInfo struct {
	Year        int
	Party       string
	PartyRank   int
	Competition string
}

// buildMusicPartyMap scans Music/CSDB/Year-party-group folder.
// Returns map of title -> MusicPartyInfo.
func buildMusicPartyMap(basePath string) map[string]MusicPartyInfo {
	partyMap := make(map[string]MusicPartyInfo)
	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

	// Year-party-group/{Year}/{Party}/{Competition?}/{Rank. Title}/
	baseDirPath := filepath.Join(basePath, "Music", "CSDB", "Year-party-group")
	years, err := os.ReadDir(baseDirPath)
	if err != nil {
		return partyMap
	}

	for _, yearDir := range years {
		if !yearDir.IsDir() {
			continue
		}
		year, err := strconv.Atoi(yearDir.Name())
		if err != nil {
			continue
		}

		yearPath := filepath.Join(baseDirPath, yearDir.Name())
		parties, _ := os.ReadDir(yearPath)

		for _, partyDir := range parties {
			if !partyDir.IsDir() {
				continue
			}
			partyName := partyDir.Name()
			partyPath := filepath.Join(yearPath, partyName)

			// Check contents (either ranked titles directly, or competition subdirs)
			partyContents, _ := os.ReadDir(partyPath)
			for _, content := range partyContents {
				if !content.IsDir() {
					continue
				}

				// Check if this is a ranked title entry (e.g., "01. Title")
				if match := rankPattern.FindStringSubmatch(content.Name()); len(match) >= 3 {
					rank, _ := strconv.Atoi(match[1])
					title := strings.TrimSpace(match[2])
					partyMap[strings.ToLower(title)] = MusicPartyInfo{
						Year:      year,
						Party:     partyName,
						PartyRank: rank,
					}
				} else {
					// This might be a competition subdir (e.g., "C64 Music")
					competition := content.Name()
					compPath := filepath.Join(partyPath, competition)
					titleEntries, _ := os.ReadDir(compPath)

					for _, titleEntry := range titleEntries {
						if !titleEntry.IsDir() {
							continue
						}
						if match := rankPattern.FindStringSubmatch(titleEntry.Name()); len(match) >= 3 {
							rank, _ := strconv.Atoi(match[1])
							title := strings.TrimSpace(match[2])
							partyMap[strings.ToLower(title)] = MusicPartyInfo{
								Year:        year,
								Party:       partyName,
								PartyRank:   rank,
								Competition: competition,
							}
						}
					}
				}
			}
		}
	}

	return partyMap
}

// scanMusicCSDB scans the Music/CSDB/All directory.
// Structure: All/{Letter}/{Title}/
func scanMusicCSDB(basePath string, entries *[]DBEntry, entryID *int, top200Map map[string]int, partyMap map[string]MusicPartyInfo) error {
	allPath := filepath.Join(basePath, "Music", "CSDB", "All")

	return filepath.WalkDir(allPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		// Get relative path from All directory.
		rel, _ := filepath.Rel(allPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want music folders at level 2: Letter/Title
		if len(parts) != 2 {
			return nil
		}

		title := parts[1] // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join("Music", "CSDB", "All", rel)

		// Look up metadata from cross-reference maps.
		titleKey := strings.ToLower(title)

		// Top200 rank
		var top200Rank *int
		if rank, ok := top200Map[titleKey]; ok {
			top200Rank = &rank
		}

		// Party info
		var party string
		var partyRank *int
		var competition string
		var year *int
		if info, ok := partyMap[titleKey]; ok {
			party = info.Party
			if info.PartyRank > 0 {
				partyRank = &info.PartyRank
			}
			competition = info.Competition
			if info.Year > 0 {
				year = &info.Year
			}
		}

		entry := DBEntry{
			ID:          *entryID,
			Category:    "music",
			Title:       title,
			Collection:  "csdb",
			Top200Rank:  top200Rank,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
			Year:        year,
			Party:       party,
			PartyRank:   partyRank,
			Competition: competition,
		}

		*entries = append(*entries, entry)
		*entryID++

		if *entryID%10000 == 0 {
			fmt.Printf("  Processed %d entries...\n", *entryID-1)
		}

		return nil
	})
}

// scanMusicHVSC scans the Music/HVSC/Music directory.
// Structure: Music/{Letter}/{Author}/{Title}/
func scanMusicHVSC(basePath string, entries *[]DBEntry, entryID *int) error {
	hvscPath := filepath.Join(basePath, "Music", "HVSC", "Music")

	return filepath.WalkDir(hvscPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		// Get relative path from Music directory.
		rel, _ := filepath.Rel(hvscPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want music folders at level 3: Letter/Author/Title
		if len(parts) != 3 {
			return nil
		}

		author := parts[1] // Author folder
		title := parts[2]  // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join("Music", "HVSC", "Music", rel)

		entry := DBEntry{
			ID:          *entryID,
			Category:    "music",
			Title:       title,
			Author:      author,
			Collection:  "hvsc",
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		*entries = append(*entries, entry)
		*entryID++

		if *entryID%10000 == 0 {
			fmt.Printf("  Processed %d entries...\n", *entryID-1)
		}

		return nil
	})
}

// scanMusicSidCollection scans 2sid-collection or 3sid-collection directories.
// Structure: {Letter}/{Author}/{Title}/ or {Letter}/{Title}/
func scanMusicSidCollection(basePath, collectionName, collectionID string, entries *[]DBEntry, entryID *int) error {
	collPath := filepath.Join(basePath, "Music", collectionName)

	return filepath.WalkDir(collPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		// Get relative path from collection directory.
		rel, _ := filepath.Rel(collPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// These collections can have either:
		// - Level 2: Letter/Title (flat)
		// - Level 3: Letter/Author/Title (like HVSC)
		// We scan files in folders that have supported files.

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Determine title and author based on path depth.
		var title, author string
		if len(parts) == 2 {
			// Letter/Title
			title = parts[1]
		} else if len(parts) == 3 {
			// Letter/Author/Title
			author = parts[1]
			title = parts[2]
		} else {
			// Skip other depths
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join("Music", collectionName, rel)

		entry := DBEntry{
			ID:          *entryID,
			Category:    "music",
			Title:       title,
			Author:      author,
			Collection:  collectionID,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		*entries = append(*entries, entry)
		*entryID++

		return nil
	})
}

// scanSimpleGamesCollection scans a simple games collection with Letter/Title structure.
// Used for C64com, Guybrush, C64Tapes-org, etc.
func scanSimpleGamesCollection(basePath, collectionPath, sourceName string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	err := filepath.WalkDir(fullPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(fullPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want title folders at level 2: Letter/Title
		if len(parts) != 2 {
			return nil
		}

		title := parts[1] // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "games",
			Title:       title,
			Group:       sourceName,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		entries = append(entries, entry)
		entryID++

		if entryID%1000 == 0 {
			fmt.Printf("  Processed %d entries...\n", entryID-1)
		}

		return nil
	})

	return entries, err
}

// scanThreeLevelGamesCollection scans a games collection with Letter/Range/Title structure.
// Used for Gamebase.
func scanThreeLevelGamesCollection(basePath, collectionPath, sourceName string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	err := filepath.WalkDir(fullPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(fullPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want title folders at level 3: Letter/Range/Title
		if len(parts) != 3 {
			return nil
		}

		title := parts[2] // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "games",
			Title:       title,
			Group:       sourceName,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		entries = append(entries, entry)
		entryID++

		if entryID%1000 == 0 {
			fmt.Printf("  Processed %d entries...\n", entryID-1)
		}

		return nil
	})

	return entries, err
}

// scanOneLoad64Collection scans the OneLoad64 collection with {crt,prg}/Letter/Title structure.
func scanOneLoad64Collection(basePath, collectionPath string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	// Scan both crt and prg subdirectories.
	for _, subDir := range []string{"crt", "prg"} {
		subPath := filepath.Join(fullPath, subDir)

		err := filepath.WalkDir(subPath, func(path string, d os.DirEntry, err error) error {
			if err != nil {
				return nil
			}

			if !d.IsDir() {
				return nil
			}

			rel, _ := filepath.Rel(subPath, path)
			if rel == "." {
				return nil
			}

			parts := strings.Split(rel, string(os.PathSeparator))

			// We want title folders at level 2: Letter/Title
			if len(parts) != 2 {
				return nil
			}

			title := parts[1] // Title folder

			// Scan the folder for files.
			files, primaryFile, fileType := scanReleaseFolder(path)
			if len(files) == 0 {
				return nil
			}

			// Build the relative path from assembly64 root.
			relPath := filepath.Join(collectionPath, subDir, rel)

			entry := DBEntry{
				ID:          entryID,
				Category:    "games",
				Title:       title,
				Group:       "OneLoad64",
				Path:        relPath,
				Files:       files,
				PrimaryFile: primaryFile,
				FileType:    fileType,
			}

			entries = append(entries, entry)
			entryID++

			if entryID%1000 == 0 {
				fmt.Printf("  Processed %d entries...\n", entryID-1)
			}

			return nil
		})

		if err != nil {
			fmt.Printf("  Warning: Error scanning %s: %v\n", subDir, err)
		}
	}

	return entries, nil
}

// scanMayhemCrtCollection scans the Mayhem-crt collection with Publisher/Title structure.
func scanMayhemCrtCollection(basePath, collectionPath string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	err := filepath.WalkDir(fullPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(fullPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want title folders at level 2: Publisher/Title
		if len(parts) != 2 {
			return nil
		}

		publisher := parts[0] // Publisher folder
		title := parts[1]     // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "games",
			Title:       title,
			Group:       publisher, // Use publisher as group
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		entries = append(entries, entry)
		entryID++

		return nil
	})

	return entries, err
}

// GenerateGamesCollectionDB generates a games JSON database for a specific collection.
func GenerateGamesCollectionDB(basePath, outputPath, sourceName, collectionPath string, scanFunc func(string, string, string) ([]DBEntry, error)) error {
	fmt.Printf("Scanning %s...\n", collectionPath)

	entries, err := scanFunc(basePath, collectionPath, sourceName)
	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	if len(entries) == 0 {
		fmt.Println("  No entries found, skipping file generation")
		return nil
	}

	// Build database structure.
	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       sourceName,
		TotalEntries: len(entries),
		Entries:      entries,
	}

	// Write JSON file.
	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// GenerateC64comDB generates the C64com games database.
func GenerateC64comDB(basePath, outputPath string) error {
	return GenerateGamesCollectionDB(basePath, outputPath, "c64com", "Games/C64com", scanSimpleGamesCollection)
}

// GenerateGuybrushDB generates the Guybrush games database.
func GenerateGuybrushDB(basePath, outputPath string) error {
	return GenerateGamesCollectionDB(basePath, outputPath, "guybrush", "Games/Guybrush", scanSimpleGamesCollection)
}

// GenerateGuybrushGermanDB generates the Guybrush-german games database.
func GenerateGuybrushGermanDB(basePath, outputPath string) error {
	return GenerateGamesCollectionDB(basePath, outputPath, "guybrush-german", "Games/Guybrush-german", scanSimpleGamesCollection)
}

// GenerateGamebaseDB generates the Gamebase games database.
func GenerateGamebaseDB(basePath, outputPath string) error {
	return GenerateGamesCollectionDB(basePath, outputPath, "gamebase", "Games/Gamebase", scanThreeLevelGamesCollection)
}

// GenerateC64TapesDB generates the C64Tapes-org games database.
func GenerateC64TapesDB(basePath, outputPath string) error {
	return GenerateGamesCollectionDB(basePath, outputPath, "c64tapes", "Games/C64Tapes-org", scanSimpleGamesCollection)
}

// scanPreserversCollection scans the Preservers collection with {Disc,Tape,G64}/Letter/Title structure.
func scanPreserversCollection(basePath, collectionPath string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	// Scan all subdirectories (Disc, Tape, G64, etc.).
	subDirs, err := os.ReadDir(fullPath)
	if err != nil {
		return nil, err
	}

	for _, subDir := range subDirs {
		if !subDir.IsDir() {
			continue
		}

		subPath := filepath.Join(fullPath, subDir.Name())

		err := filepath.WalkDir(subPath, func(path string, d os.DirEntry, err error) error {
			if err != nil {
				return nil
			}

			if !d.IsDir() {
				return nil
			}

			rel, _ := filepath.Rel(subPath, path)
			if rel == "." {
				return nil
			}

			parts := strings.Split(rel, string(os.PathSeparator))

			// We want title folders at level 2: Letter/Title
			if len(parts) != 2 {
				return nil
			}

			title := parts[1] // Title folder

			// Scan the folder for files.
			files, primaryFile, fileType := scanReleaseFolder(path)
			if len(files) == 0 {
				return nil
			}

			// Build the relative path from assembly64 root.
			relPath := filepath.Join(collectionPath, subDir.Name(), rel)

			entry := DBEntry{
				ID:          entryID,
				Category:    "games",
				Title:       title,
				Group:       "Preservers",
				Path:        relPath,
				Files:       files,
				PrimaryFile: primaryFile,
				FileType:    fileType,
			}

			entries = append(entries, entry)
			entryID++

			if entryID%1000 == 0 {
				fmt.Printf("  Processed %d entries...\n", entryID-1)
			}

			return nil
		})

		if err != nil {
			fmt.Printf("  Warning: Error scanning %s: %v\n", subDir.Name(), err)
		}
	}

	return entries, nil
}

// GeneratePreserversDB generates the Preservers games database.
func GeneratePreserversDB(basePath, outputPath string) error {
	fmt.Println("Scanning Games/Preservers...")

	entries, err := scanPreserversCollection(basePath, "Games/Preservers")
	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	if len(entries) == 0 {
		fmt.Println("  No entries found, skipping file generation")
		return nil
	}

	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "preservers",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// GenerateSEUCKDB generates the SEUCK games database.
func GenerateSEUCKDB(basePath, outputPath string) error {
	return GenerateGamesCollectionDB(basePath, outputPath, "seuck", "Games/SEUCK", scanSimpleGamesCollection)
}

// GenerateOneLoad64DB generates the OneLoad64 games database.
func GenerateOneLoad64DB(basePath, outputPath string) error {
	fmt.Println("Scanning Games/OneLoad64...")

	entries, err := scanOneLoad64Collection(basePath, "Games/OneLoad64")
	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	if len(entries) == 0 {
		fmt.Println("  No entries found, skipping file generation")
		return nil
	}

	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "oneload64",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// GenerateMayhemCrtDB generates the Mayhem-crt games database.
func GenerateMayhemCrtDB(basePath, outputPath string) error {
	fmt.Println("Scanning Games/Mayhem-crt...")

	entries, err := scanMayhemCrtCollection(basePath, "Games/Mayhem-crt")
	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	if len(entries) == 0 {
		fmt.Println("  No entries found, skipping file generation")
		return nil
	}

	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "mayhem-crt",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// scanSimpleDemosCollection scans a simple demos collection with Letter/Title structure.
// Used for Guybrush demos.
func scanSimpleDemosCollection(basePath, collectionPath, sourceName string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	err := filepath.WalkDir(fullPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(fullPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want title folders at level 2: Letter/Title
		if len(parts) != 2 {
			return nil
		}

		title := parts[1] // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "demos",
			Title:       title,
			Group:       sourceName,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		entries = append(entries, entry)
		entryID++

		if entryID%1000 == 0 {
			fmt.Printf("  Processed %d entries...\n", entryID-1)
		}

		return nil
	})

	return entries, err
}

// scanC64comDemosCollection scans the C64com demos collection with Letter/Group/Title structure.
func scanC64comDemosCollection(basePath, collectionPath string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

	err := filepath.WalkDir(fullPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(fullPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		// We want title folders at level 3: Letter/Group/Title
		if len(parts) != 3 {
			return nil
		}

		group := parts[1] // Group folder
		title := parts[2] // Title folder

		// Scan the folder for files.
		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		// Build the relative path from assembly64 root.
		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "demos",
			Title:       title,
			Group:       group,
			Path:        relPath,
			Files:       files,
			PrimaryFile: primaryFile,
			FileType:    fileType,
		}

		entries = append(entries, entry)
		entryID++

		if entryID%1000 == 0 {
			fmt.Printf("  Processed %d entries...\n", entryID-1)
		}

		return nil
	})

	return entries, err
}

// GenerateDemosCollectionDB generates a demos JSON database for a specific collection.
func GenerateDemosCollectionDB(basePath, outputPath, sourceName, collectionPath string, scanFunc func(string, string, string) ([]DBEntry, error)) error {
	fmt.Printf("Scanning %s...\n", collectionPath)

	entries, err := scanFunc(basePath, collectionPath, sourceName)
	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	if len(entries) == 0 {
		fmt.Println("  No entries found, skipping file generation")
		return nil
	}

	// Build database structure.
	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       sourceName,
		TotalEntries: len(entries),
		Entries:      entries,
	}

	// Write JSON file.
	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// GenerateC64comDemosDB generates the C64com demos database.
func GenerateC64comDemosDB(basePath, outputPath string) error {
	fmt.Println("Scanning Demos/C64com...")

	entries, err := scanC64comDemosCollection(basePath, "Demos/C64com")
	if err != nil {
		return fmt.Errorf("failed to scan directory: %w", err)
	}

	fmt.Printf("  Total entries: %d\n", len(entries))

	if len(entries) == 0 {
		fmt.Println("  No entries found, skipping file generation")
		return nil
	}

	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "c64com",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}

// GenerateGuybrushDemosDB generates the Guybrush demos database.
func GenerateGuybrushDemosDB(basePath, outputPath string) error {
	return GenerateDemosCollectionDB(basePath, outputPath, "guybrush", "Demos/Guybrush", scanSimpleDemosCollection)
}

// GenerateMusicDB generates the music JSON database file.
func GenerateMusicDB(basePath, outputPath string) error {
	fmt.Println("Scanning Music collections...")

	// Build metadata maps from CSDB folders.
	fmt.Println("Building music metadata maps...")

	fmt.Print("  Top200... ")
	top200Map := buildMusicTop200Map(basePath)
	fmt.Printf("%d entries\n", len(top200Map))

	fmt.Print("  Party data... ")
	partyMap := buildMusicPartyMap(basePath)
	fmt.Printf("%d entries\n", len(partyMap))

	var entries []DBEntry
	entryID := 1

	// Scan CSDB collection.
	fmt.Println("Scanning Music/CSDB/All...")
	if err := scanMusicCSDB(basePath, &entries, &entryID, top200Map, partyMap); err != nil {
		fmt.Printf("  Warning: CSDB scan error: %v\n", err)
	}
	csdbCount := len(entries)
	fmt.Printf("  CSDB entries: %d\n", csdbCount)

	// Scan HVSC collection.
	fmt.Println("Scanning Music/HVSC/Music...")
	if err := scanMusicHVSC(basePath, &entries, &entryID); err != nil {
		fmt.Printf("  Warning: HVSC scan error: %v\n", err)
	}
	hvscCount := len(entries) - csdbCount
	fmt.Printf("  HVSC entries: %d\n", hvscCount)

	// Scan 2sid-collection.
	fmt.Println("Scanning Music/2sid-collection...")
	prevCount := len(entries)
	if err := scanMusicSidCollection(basePath, "2sid-collection", "2sid", &entries, &entryID); err != nil {
		fmt.Printf("  Warning: 2sid-collection scan error: %v\n", err)
	}
	fmt.Printf("  2sid entries: %d\n", len(entries)-prevCount)

	// Scan 3sid-collection.
	fmt.Println("Scanning Music/3sid-collection...")
	prevCount = len(entries)
	if err := scanMusicSidCollection(basePath, "3sid-collection", "3sid", &entries, &entryID); err != nil {
		fmt.Printf("  Warning: 3sid-collection scan error: %v\n", err)
	}
	fmt.Printf("  3sid entries: %d\n", len(entries)-prevCount)

	fmt.Printf("  Total entries: %d\n", len(entries))

	// Build database structure.
	db := Database{
		Version:      "1.0",
		Generated:    time.Now().UTC().Format(time.RFC3339),
		Source:       "mixed",
		TotalEntries: len(entries),
		Entries:      entries,
	}

	// Write JSON file.
	fmt.Printf("Writing %s...\n", outputPath)

	jsonData, err := json.Marshal(db)
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("failed to write file: %w", err)
	}

	fmt.Printf("Done! Generated %s (%d bytes, %d entries)\n", outputPath, len(jsonData), len(entries))

	return nil
}