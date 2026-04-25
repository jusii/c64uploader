// Directory scanner for Assembly64 collections.
// Scans directory structure and extracts file metadata.
package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
)

// DBEntry represents a single entry in the database.
type DBEntry struct {
	ID          int
	Category    string
	Title       string
	ReleaseName string     // Games only
	Group       string
	Top200Rank  *int
	Top500Rank  *int       // Demos only
	Is4k        bool       // Games: 4k competition
	Path        string
	Files       []DBFile
	PrimaryFile string
	FileType    string
	Crack       *CrackInfo // Games only
	Language    string
	Region      string
	Engine      string
	IsPreview   bool
	Version     string
	// Demos-specific fields
	Year        *int
	YearRank    *int    // Rank within year's top 20
	Party       string  // Party/event name
	PartyRank   *int    // Placement at party
	Competition string  // Competition type (e.g., "C64 Demo")
	IsOnefile   bool    // Single-file demo
	Rating      float64 // CSDB rating (0 if not rated)
	// Music-specific fields
	Author     string // Composer/artist name (from HVSC path)
	Collection string // Source collection: csdb, hvsc, 2sid, 3sid
}

// DBFile represents a file within a release.
type DBFile struct {
	Name string
	Type string
	Size int64
}

// CrackInfo contains parsed crack/trainer information.
type CrackInfo struct {
	IsCracked bool
	Trainers  int
	Flags     []string
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

	filepath.WalkDir(fourKPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() || path == fourKPath {
			return nil
		}

		rel, _ := filepath.Rel(fourKPath, path)
		parts := strings.Split(rel, string(os.PathSeparator))

		if len(parts) == 2 {
			fourKMap[strings.ToLower(parts[1])] = true
		}

		return nil
	})

	return fourKMap
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
	YearRank int
}

// buildDemosYearMap scans Year/ and Year-top20/ folders.
func buildDemosYearMap(basePath string) map[string]DemoYearInfo {
	yearMap := make(map[string]DemoYearInfo)
	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

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
					if _, exists := yearMap[key]; !exists {
						yearMap[key] = DemoYearInfo{Year: year}
					}
				}
			}
		}
	}

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
					titleKey := strings.ToLower(title)
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
func buildDemosPartyMap(basePath string) map[string]DemoPartyInfo {
	partyMap := make(map[string]DemoPartyInfo)
	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

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

			partyContents, _ := os.ReadDir(partyPath)
			for _, content := range partyContents {
				if !content.IsDir() {
					continue
				}

				if match := rankPattern.FindStringSubmatch(content.Name()); len(match) >= 3 {
					rank, _ := strconv.Atoi(match[1])
					group := strings.TrimSpace(match[2])
					groupPath := filepath.Join(partyPath, content.Name())

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

							if len(titles) > 0 && !titles[0].IsDir() {
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

	ratingPattern := regexp.MustCompile(`^\d+\.\s*\((\d+\.?\d*)\)\s*(.+)$`)

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
func buildMusicPartyMap(basePath string) map[string]MusicPartyInfo {
	partyMap := make(map[string]MusicPartyInfo)
	rankPattern := regexp.MustCompile(`^(\d+)\s*[-_\.]\s*(.+)$`)

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

			partyContents, _ := os.ReadDir(partyPath)
			for _, content := range partyContents {
				if !content.IsDir() {
					continue
				}

				if match := rankPattern.FindStringSubmatch(content.Name()); len(match) >= 3 {
					rank, _ := strconv.Atoi(match[1])
					title := strings.TrimSpace(match[2])
					partyMap[strings.ToLower(title)] = MusicPartyInfo{
						Year:      year,
						Party:     partyName,
						PartyRank: rank,
					}
				} else {
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
func scanMusicCSDB(basePath string, entries *[]DBEntry, entryID *int, top200Map map[string]int, partyMap map[string]MusicPartyInfo) error {
	allPath := filepath.Join(basePath, "Music", "CSDB", "All")

	return filepath.WalkDir(allPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(allPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		if len(parts) != 2 {
			return nil
		}

		title := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join("Music", "CSDB", "All", rel)

		titleKey := strings.ToLower(title)

		var top200Rank *int
		if rank, ok := top200Map[titleKey]; ok {
			top200Rank = &rank
		}

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
func scanMusicHVSC(basePath string, entries *[]DBEntry, entryID *int) error {
	hvscPath := filepath.Join(basePath, "Music", "HVSC", "Music")

	return filepath.WalkDir(hvscPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(hvscPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		if len(parts) != 3 {
			return nil
		}

		author := parts[1]
		title := parts[2]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

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
func scanMusicSidCollection(basePath, collectionName, collectionID string, entries *[]DBEntry, entryID *int) error {
	collPath := filepath.Join(basePath, "Music", collectionName)

	return filepath.WalkDir(collPath, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		if !d.IsDir() {
			return nil
		}

		rel, _ := filepath.Rel(collPath, path)
		if rel == "." {
			return nil
		}

		parts := strings.Split(rel, string(os.PathSeparator))

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		var title, author string
		if len(parts) == 2 {
			title = parts[1]
		} else if len(parts) == 3 {
			author = parts[1]
			title = parts[2]
		} else {
			return nil
		}

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

		if len(parts) != 2 {
			return nil
		}

		title := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

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

		if len(parts) != 3 {
			return nil
		}

		title := parts[2]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

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

			if len(parts) != 2 {
				return nil
			}

			title := parts[1]

			files, primaryFile, fileType := scanReleaseFolder(path)
			if len(files) == 0 {
				return nil
			}

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

		if len(parts) != 2 {
			return nil
		}

		publisher := parts[0]
		title := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "games",
			Title:       title,
			Group:       publisher,
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

// scanPreserversCollection scans the Preservers collection with {Disc,Tape,G64}/Letter/Title structure.
func scanPreserversCollection(basePath, collectionPath string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath)

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

			if len(parts) != 2 {
				return nil
			}

			title := parts[1]

			files, primaryFile, fileType := scanReleaseFolder(path)
			if len(files) == 0 {
				return nil
			}

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

// scanSimpleDemosCollection scans a simple demos collection with Letter/Title structure.
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

		if len(parts) != 2 {
			return nil
		}

		title := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

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

		if len(parts) != 3 {
			return nil
		}

		group := parts[1]
		title := parts[2]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

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

// scanIntrosCollection scans an intros collection with Letter/Group structure.
func scanIntrosCollection(basePath, collectionPath, sourceName string) ([]DBEntry, error) {
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

		if len(parts) != 2 {
			return nil
		}

		group := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "intros",
			Title:       group,
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

// scanGraphicsCollection scans a graphics collection with All/Letter/Title structure.
func scanGraphicsCollection(basePath, collectionPath, sourceName string) ([]DBEntry, error) {
	var entries []DBEntry
	entryID := 1

	fullPath := filepath.Join(basePath, collectionPath, "All")

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

		if len(parts) != 2 {
			return nil
		}

		title := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join(collectionPath, "All", rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "graphics",
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

// scanDiscmagsCollection scans a discmags collection with Letter/Title structure.
func scanDiscmagsCollection(basePath, collectionPath, sourceName string) ([]DBEntry, error) {
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

		if len(parts) != 2 {
			return nil
		}

		title := parts[1]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join(collectionPath, rel)

		entry := DBEntry{
			ID:          entryID,
			Category:    "discmags",
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
