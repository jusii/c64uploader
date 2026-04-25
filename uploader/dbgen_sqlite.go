// SQLite database generator for Assembly64 collections.
// Uses shared scanning logic from dbgen.go.
package main

import (
	"database/sql"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"time"
)

// normalizeTitle normalizes a title for grouping purposes.
func normalizeTitle(title string) string {
	t := strings.ToLower(title)
	for {
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
	t = strings.TrimRight(t, " _-")
	return t
}

// GenerateSQLiteDB generates a SQLite database from the Assembly64 collection.
func GenerateSQLiteDB(basePath, outputPath string) error {
	fmt.Printf("Generating SQLite database: %s\n", outputPath)
	startTime := time.Now()

	// Remove existing database.
	if _, err := os.Stat(outputPath); err == nil {
		if err := os.Remove(outputPath); err != nil {
			return fmt.Errorf("removing existing database: %w", err)
		}
	}

	// Open database.
	db, err := OpenDB(outputPath)
	if err != nil {
		return fmt.Errorf("opening database: %w", err)
	}
	defer db.Close()

	// Initialize schema.
	if err := db.InitSchema(); err != nil {
		return fmt.Errorf("initializing schema: %w", err)
	}

	// Start transaction for bulk inserts.
	tx, err := db.BeginTx()
	if err != nil {
		return fmt.Errorf("starting transaction: %w", err)
	}
	defer tx.Rollback()

	// Prepare insert statements.
	entryStmt, err := tx.Prepare(`
		INSERT INTO entries (
			category, source, title, name, normalized_title, group_name, year, path,
			primary_file, file_type, top200_rank, top500_rank, year_rank, party_rank, rating,
			release_name, is_4k, is_cracked, trainers, crack_flags, language, region, engine,
			is_preview, version, party, competition, is_onefile, author, collection
		) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`)
	if err != nil {
		return fmt.Errorf("preparing entry statement: %w", err)
	}
	defer entryStmt.Close()

	fileStmt, err := tx.Prepare(`INSERT INTO files (entry_id, name, type, size) VALUES (?, ?, ?, ?)`)
	if err != nil {
		return fmt.Errorf("preparing file statement: %w", err)
	}
	defer fileStmt.Close()

	totalEntries := 0

	// Generate Games.
	fmt.Println("\n=== GAMES ===")
	count, err := generateGamesSQLite(basePath, tx, entryStmt, fileStmt)
	if err != nil {
		fmt.Printf("Warning: Games generation error: %v\n", err)
	}
	totalEntries += count

	// Generate Demos.
	fmt.Println("\n=== DEMOS ===")
	count, err = generateDemosSQLite(basePath, tx, entryStmt, fileStmt)
	if err != nil {
		fmt.Printf("Warning: Demos generation error: %v\n", err)
	}
	totalEntries += count

	// Generate Music.
	fmt.Println("\n=== MUSIC ===")
	count, err = generateMusicSQLite(basePath, tx, entryStmt, fileStmt)
	if err != nil {
		fmt.Printf("Warning: Music generation error: %v\n", err)
	}
	totalEntries += count

	// Generate Intros.
	fmt.Println("\n=== INTROS ===")
	count, err = generateIntrosSQLite(basePath, tx, entryStmt, fileStmt)
	if err != nil {
		fmt.Printf("Warning: Intros generation error: %v\n", err)
	}
	totalEntries += count

	// Generate Graphics.
	fmt.Println("\n=== GRAPHICS ===")
	count, err = generateGraphicsSQLite(basePath, tx, entryStmt, fileStmt)
	if err != nil {
		fmt.Printf("Warning: Graphics generation error: %v\n", err)
	}
	totalEntries += count

	// Generate Discmags.
	fmt.Println("\n=== DISCMAGS ===")
	count, err = generateDiscmagsSQLite(basePath, tx, entryStmt, fileStmt)
	if err != nil {
		fmt.Printf("Warning: Discmags generation error: %v\n", err)
	}
	totalEntries += count

	// Commit transaction.
	fmt.Println("\nCommitting transaction...")
	if err := tx.Commit(); err != nil {
		return fmt.Errorf("committing transaction: %w", err)
	}

	// Rebuild FTS index.
	fmt.Println("Rebuilding full-text search index...")
	if _, err := db.conn.Exec("INSERT INTO entries_fts(entries_fts) VALUES('rebuild')"); err != nil {
		fmt.Printf("Warning: FTS rebuild error: %v\n", err)
	}

	// Vacuum to optimize.
	fmt.Println("Optimizing database...")
	if _, err := db.conn.Exec("VACUUM"); err != nil {
		fmt.Printf("Warning: VACUUM error: %v\n", err)
	}

	// Get file size.
	info, _ := os.Stat(outputPath)
	fileSize := int64(0)
	if info != nil {
		fileSize = info.Size()
	}

	elapsed := time.Since(startTime)
	fmt.Printf("\n=== COMPLETE ===\n")
	fmt.Printf("Total entries: %d\n", totalEntries)
	fmt.Printf("Database size: %d bytes (%.2f MB)\n", fileSize, float64(fileSize)/(1024*1024))
	fmt.Printf("Time elapsed: %v\n", elapsed)

	return nil
}

// insertEntry inserts a DBEntry into the database.
func insertEntry(stmt *sql.Stmt, fileStmt *sql.Stmt, e *DBEntry, category, source string) (int64, error) {
	// Normalize title for grouping.
	normalizedTitle := normalizeTitle(e.Title)

	// Extract year as string.
	var yearStr string
	if e.Year != nil {
		yearStr = fmt.Sprintf("%d", *e.Year)
	}

	// Extract crack flags as comma-separated string.
	var crackFlags string
	var isCracked int
	var trainers int
	if e.Crack != nil {
		isCracked = boolToInt(e.Crack.IsCracked)
		trainers = e.Crack.Trainers
		if len(e.Crack.Flags) > 0 {
			crackFlags = strings.Join(e.Crack.Flags, ",")
		}
	}

	result, err := stmt.Exec(
		category, source, e.Title, e.Title, normalizedTitle, e.Group, yearStr, e.Path,
		e.PrimaryFile, e.FileType, e.Top200Rank, e.Top500Rank, e.YearRank, e.PartyRank, nilIfZero(e.Rating),
		e.ReleaseName, boolToInt(e.Is4k), isCracked, trainers, crackFlags, e.Language, e.Region, e.Engine,
		boolToInt(e.IsPreview), e.Version, e.Party, e.Competition, boolToInt(e.IsOnefile), e.Author, e.Collection,
	)
	if err != nil {
		return 0, err
	}

	entryID, err := result.LastInsertId()
	if err != nil {
		return 0, err
	}

	// Insert files.
	for _, f := range e.Files {
		if _, err := fileStmt.Exec(entryID, f.Name, f.Type, f.Size); err != nil {
			return entryID, err
		}
	}

	return entryID, nil
}

func boolToInt(b bool) int {
	if b {
		return 1
	}
	return 0
}

func nilIfZero(f float64) interface{} {
	if f == 0 {
		return nil
	}
	return f
}

// generateGamesSQLite generates all games entries.
func generateGamesSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt) (int, error) {
	totalCount := 0

	// Build metadata maps.
	fmt.Println("Building Games metadata maps...")
	top200Map := buildTop200Map(basePath)
	fmt.Printf("  Top200: %d entries\n", len(top200Map))
	fourKMap := build4kMap(basePath)
	fmt.Printf("  4K: %d entries\n", len(fourKMap))

	// CSDB Games (main collection).
	fmt.Println("Scanning Games/CSDB/All...")
	count, err := scanGamesCSDBToSQLite(basePath, tx, entryStmt, fileStmt, top200Map, fourKMap)
	if err != nil {
		fmt.Printf("  Warning: %v\n", err)
	}
	fmt.Printf("  CSDB: %d entries\n", count)
	totalCount += count

	// Other game collections.
	collections := []struct {
		name   string
		path   string
		source string
		scan   func(string, string, string) ([]DBEntry, error)
	}{
		{"C64com", "Games/C64com", "C64com", scanSimpleGamesCollection},
		{"Gamebase", "Games/Gamebase", "Gamebase", scanThreeLevelGamesCollection},
		{"Guybrush", "Games/Guybrush", "Guybrush", scanSimpleGamesCollection},
		{"Guybrush-german", "Games/Guybrush-german", "Guybrush", scanSimpleGamesCollection},
		{"C64Tapes", "Games/C64Tapes-org", "C64Tapes", scanSimpleGamesCollection},
		{"SEUCK", "Games/SEUCK", "SEUCK", scanSimpleGamesCollection},
	}

	for _, coll := range collections {
		fmt.Printf("Scanning %s...\n", coll.path)
		entries, err := coll.scan(basePath, coll.path, coll.source)
		if err != nil {
			fmt.Printf("  Warning: %v\n", err)
			continue
		}
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Games", coll.source); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  %s: %d entries\n", coll.name, len(entries))
		totalCount += len(entries)
	}

	// OneLoad64 (special structure).
	fmt.Println("Scanning Games/OneLoad64...")
	entries, err := scanOneLoad64Collection(basePath, "Games/OneLoad64")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Games", "OneLoad64"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  OneLoad64: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// Preservers (special structure).
	fmt.Println("Scanning Games/Preservers...")
	entries, err = scanPreserversCollection(basePath, "Games/Preservers")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Games", "Preservers"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  Preservers: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// Mayhem-crt (special structure).
	fmt.Println("Scanning Games/Mayhem-crt...")
	entries, err = scanMayhemCrtCollection(basePath, "Games/Mayhem-crt")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Games", "Mayhem"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  Mayhem-crt: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	fmt.Printf("Total Games: %d\n", totalCount)
	return totalCount, nil
}

// scanGamesCSDBToSQLite scans CSDB games directly into SQLite.
func scanGamesCSDBToSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt, top200Map map[string]int, fourKMap map[string]bool) (int, error) {
	allPath := filepath.Join(basePath, "Games", "CSDB", "All")
	count := 0

	err := filepath.WalkDir(allPath, func(path string, d os.DirEntry, err error) error {
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
		if len(parts) != 5 {
			return nil
		}

		title := parts[2]
		group := parts[3]
		releaseName := parts[4]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join("Games", "CSDB", "All", rel)

		var top200Rank *int
		if rank, ok := top200Map[strings.ToLower(title)]; ok {
			top200Rank = &rank
		}
		is4k := fourKMap[strings.ToLower(title)]

		entry := DBEntry{
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

		if _, err := insertEntry(entryStmt, fileStmt, &entry, "Games", "CSDB"); err != nil {
			return nil
		}

		count++
		if count%10000 == 0 {
			fmt.Printf("  Processed %d entries...\n", count)
		}

		return nil
	})

	return count, err
}

// generateDemosSQLite generates all demos entries.
func generateDemosSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt) (int, error) {
	totalCount := 0

	// Build metadata maps.
	fmt.Println("Building Demos metadata maps...")
	top200Map := buildDemosTop200Map(basePath)
	fmt.Printf("  Top200: %d entries\n", len(top200Map))
	top500Map := buildDemosTop500Map(basePath)
	fmt.Printf("  Top500: %d entries\n", len(top500Map))
	yearMap := buildDemosYearMap(basePath)
	fmt.Printf("  Year: %d entries\n", len(yearMap))
	partyMap := buildDemosPartyMap(basePath)
	fmt.Printf("  Party: %d entries\n", len(partyMap))
	onefileMap := buildDemosOnefileMap(basePath)
	fmt.Printf("  Onefile: %d entries\n", len(onefileMap))
	ratingMap := buildDemosRatingMap(basePath)
	fmt.Printf("  Rating: %d entries\n", len(ratingMap))

	// CSDB Demos.
	fmt.Println("Scanning Demos/CSDB/All...")
	count, err := scanDemosCSDBToSQLite(basePath, tx, entryStmt, fileStmt, top200Map, top500Map, yearMap, partyMap, onefileMap, ratingMap)
	if err != nil {
		fmt.Printf("  Warning: %v\n", err)
	}
	fmt.Printf("  CSDB: %d entries\n", count)
	totalCount += count

	// C64com Demos.
	fmt.Println("Scanning Demos/C64com...")
	entries, err := scanC64comDemosCollection(basePath, "Demos/C64com")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Demos", "C64com"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  C64com: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// Guybrush Demos.
	fmt.Println("Scanning Demos/Guybrush...")
	entries, err = scanSimpleDemosCollection(basePath, "Demos/Guybrush", "Guybrush")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Demos", "Guybrush"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  Guybrush: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	fmt.Printf("Total Demos: %d\n", totalCount)
	return totalCount, nil
}

// scanDemosCSDBToSQLite scans CSDB demos directly into SQLite.
func scanDemosCSDBToSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt,
	top200Map, top500Map map[string]int, yearMap map[string]DemoYearInfo,
	partyMap map[string]DemoPartyInfo, onefileMap map[string]bool, ratingMap map[string]DemoRatingInfo) (int, error) {

	allPath := filepath.Join(basePath, "Demos", "CSDB", "All")
	count := 0

	err := filepath.WalkDir(allPath, func(path string, d os.DirEntry, err error) error {
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
		if len(parts) != 3 {
			return nil
		}

		group := parts[1]
		title := parts[2]

		files, primaryFile, fileType := scanReleaseFolder(path)
		if len(files) == 0 {
			return nil
		}

		relPath := filepath.Join("Demos", "CSDB", "All", rel)

		key := demoKey(group, title)
		titleKey := "_title_" + strings.ToLower(title)

		var top200Rank *int
		if rank, ok := top200Map[strings.ToLower(title)]; ok {
			top200Rank = &rank
		}

		var top500Rank *int
		if rank, ok := top500Map[strings.ToLower(title)]; ok {
			top500Rank = &rank
		}

		var year *int
		var yearRank *int
		if info, ok := yearMap[key]; ok {
			year = &info.Year
			if info.YearRank > 0 {
				yearRank = &info.YearRank
			}
		}
		if info, ok := yearMap[titleKey]; ok {
			if year == nil {
				year = &info.Year
			}
			if info.YearRank > 0 {
				yearRank = &info.YearRank
			}
		}

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

		isOnefile := onefileMap[key]

		var rating float64
		if info, ok := ratingMap[key]; ok {
			rating = info.Rating
			if year == nil && info.Year > 0 {
				year = &info.Year
			}
		}
		if info, ok := ratingMap[titleKey]; ok && rating == 0 {
			rating = info.Rating
		}

		entry := DBEntry{
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

		if _, err := insertEntry(entryStmt, fileStmt, &entry, "Demos", "CSDB"); err != nil {
			return nil
		}

		count++
		if count%10000 == 0 {
			fmt.Printf("  Processed %d entries...\n", count)
		}

		return nil
	})

	return count, err
}

// generateMusicSQLite generates all music entries.
func generateMusicSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt) (int, error) {
	totalCount := 0

	// Build metadata maps.
	fmt.Println("Building Music metadata maps...")
	top200Map := buildMusicTop200Map(basePath)
	fmt.Printf("  Top200: %d entries\n", len(top200Map))
	partyMap := buildMusicPartyMap(basePath)
	fmt.Printf("  Party: %d entries\n", len(partyMap))

	// CSDB Music.
	fmt.Println("Scanning Music/CSDB/All...")
	var entries []DBEntry
	entryID := 1
	if err := scanMusicCSDB(basePath, &entries, &entryID, top200Map, partyMap); err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Music", "CSDB"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  CSDB: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// HVSC Music.
	fmt.Println("Scanning Music/HVSC/Music...")
	entries = nil
	entryID = 1
	if err := scanMusicHVSC(basePath, &entries, &entryID); err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Music", "HVSC"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  HVSC: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// 2sid collection.
	fmt.Println("Scanning Music/2sid-collection...")
	entries = nil
	entryID = 1
	if err := scanMusicSidCollection(basePath, "2sid-collection", "2sid", &entries, &entryID); err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Music", "2sid"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  2sid: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// 3sid collection.
	fmt.Println("Scanning Music/3sid-collection...")
	entries = nil
	entryID = 1
	if err := scanMusicSidCollection(basePath, "3sid-collection", "3sid", &entries, &entryID); err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Music", "3sid"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  3sid: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	fmt.Printf("Total Music: %d\n", totalCount)
	return totalCount, nil
}

// generateIntrosSQLite generates all intros entries.
func generateIntrosSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt) (int, error) {
	totalCount := 0

	// CSDB Intros.
	fmt.Println("Scanning Intros/CSDB-intros...")
	entries, err := scanIntrosCollection(basePath, "Intros/CSDB-intros", "CSDB")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Intros", "CSDB"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  CSDB: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	// C64org Intros.
	fmt.Println("Scanning Intros/C64org-intros...")
	entries, err = scanIntrosCollection(basePath, "Intros/C64org-intros", "C64org")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Intros", "C64org"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  C64org: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	fmt.Printf("Total Intros: %d\n", totalCount)
	return totalCount, nil
}

// generateGraphicsSQLite generates all graphics entries.
func generateGraphicsSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt) (int, error) {
	totalCount := 0

	fmt.Println("Scanning Graphics/CSDB/All...")
	entries, err := scanGraphicsCollection(basePath, "Graphics/CSDB", "CSDB")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Graphics", "CSDB"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  CSDB: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	fmt.Printf("Total Graphics: %d\n", totalCount)
	return totalCount, nil
}

// generateDiscmagsSQLite generates all discmags entries.
func generateDiscmagsSQLite(basePath string, tx *sql.Tx, entryStmt, fileStmt *sql.Stmt) (int, error) {
	totalCount := 0

	fmt.Println("Scanning Discmags/CSDB...")
	entries, err := scanDiscmagsCollection(basePath, "Discmags/CSDB", "CSDB")
	if err == nil {
		for _, e := range entries {
			if _, err := insertEntry(entryStmt, fileStmt, &e, "Discmags", "CSDB"); err != nil {
				fmt.Printf("  Warning: insert error: %v\n", err)
			}
		}
		fmt.Printf("  CSDB: %d entries\n", len(entries))
		totalCount += len(entries)
	}

	fmt.Printf("Total Discmags: %d\n", totalCount)
	return totalCount, nil
}
