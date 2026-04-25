// SQLite database for C64 Assembly64 browser.
// Uses pure Go SQLite (modernc.org/sqlite) - no CGO required.
package main

import (
	"database/sql"
	"fmt"
	"log/slog"
	"strings"

	_ "modernc.org/sqlite"
)

// DB wraps the SQLite database connection.
type DB struct {
	conn *sql.DB
}

// Schema version for migrations.
const schemaVersion = 1

// OpenDB opens or creates the SQLite database.
func OpenDB(path string) (*DB, error) {
	conn, err := sql.Open("sqlite", path)
	if err != nil {
		return nil, fmt.Errorf("opening database: %w", err)
	}

	// Enable WAL mode for better concurrent reads.
	if _, err := conn.Exec("PRAGMA journal_mode=WAL"); err != nil {
		conn.Close()
		return nil, fmt.Errorf("setting WAL mode: %w", err)
	}

	// Enable foreign keys.
	if _, err := conn.Exec("PRAGMA foreign_keys=ON"); err != nil {
		conn.Close()
		return nil, fmt.Errorf("enabling foreign keys: %w", err)
	}

	db := &DB{conn: conn}
	return db, nil
}

// Close closes the database connection.
func (db *DB) Close() error {
	return db.conn.Close()
}

// InitSchema creates all tables if they don't exist.
func (db *DB) InitSchema() error {
	schema := `
	-- Version tracking
	CREATE TABLE IF NOT EXISTS schema_info (
		version INTEGER PRIMARY KEY,
		created_at TEXT DEFAULT CURRENT_TIMESTAMP
	);

	-- Main entries table - unified for all content types
	CREATE TABLE IF NOT EXISTS entries (
		id INTEGER PRIMARY KEY AUTOINCREMENT,

		-- Common fields
		category TEXT NOT NULL,           -- Games, Demos, Music, Graphics, Discmags, Intros
		source TEXT NOT NULL,             -- CSDB, C64com, HVSC, Gamebase, etc.
		title TEXT NOT NULL,              -- Display title
		name TEXT NOT NULL,               -- Original entry name (for matching)
		normalized_title TEXT NOT NULL,   -- Lowercase, normalized for grouping
		group_name TEXT,                  -- Cracker group, demo group, or author
		year TEXT,                        -- Release year
		path TEXT NOT NULL UNIQUE,        -- Full relative path from assembly64 root
		primary_file TEXT,                -- Main file to run
		file_type TEXT,                   -- d64, prg, sid, crt, etc.

		-- Ranking fields
		top200_rank INTEGER,              -- 1-200 or NULL
		top500_rank INTEGER,              -- 1-500 or NULL (demos)
		year_rank INTEGER,                -- Rank within year's top 20
		party_rank INTEGER,               -- Placement at party competition
		rating REAL,                      -- CSDB rating 0.0-10.0

		-- Games-specific
		release_name TEXT,                -- Full release name with crack info
		is_4k INTEGER DEFAULT 0,          -- 4k competition entry
		is_cracked INTEGER DEFAULT 0,     -- Has crack
		trainers INTEGER DEFAULT 0,       -- Number of trainers
		crack_flags TEXT,                 -- Comma-separated flags: docs,fastload,highscore
		language TEXT,                    -- german, french, english, etc.
		region TEXT,                      -- PAL, NTSC
		engine TEXT,                      -- seuck, gkgm, bdck
		is_preview INTEGER DEFAULT 0,     -- Preview/unfinished release
		version TEXT,                     -- Version string

		-- Demos-specific
		party TEXT,                       -- Party/event name
		competition TEXT,                 -- Competition type (C64 Demo, 4K Intro, etc.)
		is_onefile INTEGER DEFAULT 0,     -- Single-file demo

		-- Music-specific
		author TEXT,                      -- Composer (HVSC uses this instead of group)
		collection TEXT,                  -- csdb, hvsc, 2sid, 3sid

		-- Metadata
		created_at TEXT DEFAULT CURRENT_TIMESTAMP
	);

	-- Files within each entry (multiple files per release)
	CREATE TABLE IF NOT EXISTS files (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		entry_id INTEGER NOT NULL,
		name TEXT NOT NULL,
		type TEXT NOT NULL,               -- File extension
		size INTEGER DEFAULT 0,
		FOREIGN KEY (entry_id) REFERENCES entries(id) ON DELETE CASCADE
	);

	-- Menu structure for hierarchical navigation
	-- Pre-computed paths for fast MENU queries
	CREATE TABLE IF NOT EXISTS menu_paths (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		path TEXT NOT NULL UNIQUE,        -- e.g., "Games/CSDB/A"
		name TEXT NOT NULL,               -- Display name, e.g., "A"
		type TEXT NOT NULL,               -- "folder" or "list"
		parent_path TEXT,                 -- Parent path, e.g., "Games/CSDB"
		entry_count INTEGER DEFAULT 0,    -- Number of entries under this path
		sort_order INTEGER DEFAULT 0      -- For custom ordering (Top 200 before A-Z)
	);

	-- Indexes for fast lookups
	CREATE INDEX IF NOT EXISTS idx_entries_category ON entries(category);
	CREATE INDEX IF NOT EXISTS idx_entries_source ON entries(source);
	CREATE INDEX IF NOT EXISTS idx_entries_normalized_title ON entries(normalized_title);
	CREATE INDEX IF NOT EXISTS idx_entries_path ON entries(path);
	CREATE INDEX IF NOT EXISTS idx_entries_group ON entries(group_name);
	CREATE INDEX IF NOT EXISTS idx_entries_year ON entries(year);
	CREATE INDEX IF NOT EXISTS idx_entries_top200 ON entries(top200_rank) WHERE top200_rank IS NOT NULL;
	CREATE INDEX IF NOT EXISTS idx_entries_author ON entries(author) WHERE author IS NOT NULL;
	CREATE INDEX IF NOT EXISTS idx_entries_collection ON entries(collection) WHERE collection IS NOT NULL;

	-- Composite indexes for common queries
	CREATE INDEX IF NOT EXISTS idx_entries_cat_source ON entries(category, source);
	CREATE INDEX IF NOT EXISTS idx_entries_cat_source_title ON entries(category, source, normalized_title);

	-- Full-text search (FTS5)
	CREATE VIRTUAL TABLE IF NOT EXISTS entries_fts USING fts5(
		title,
		name,
		group_name,
		author,
		release_name,
		content=entries,
		content_rowid=id
	);

	-- Triggers to keep FTS in sync
	CREATE TRIGGER IF NOT EXISTS entries_ai AFTER INSERT ON entries BEGIN
		INSERT INTO entries_fts(rowid, title, name, group_name, author, release_name)
		VALUES (new.id, new.title, new.name, new.group_name, new.author, new.release_name);
	END;

	CREATE TRIGGER IF NOT EXISTS entries_ad AFTER DELETE ON entries BEGIN
		INSERT INTO entries_fts(entries_fts, rowid, title, name, group_name, author, release_name)
		VALUES('delete', old.id, old.title, old.name, old.group_name, old.author, old.release_name);
	END;

	CREATE TRIGGER IF NOT EXISTS entries_au AFTER UPDATE ON entries BEGIN
		INSERT INTO entries_fts(entries_fts, rowid, title, name, group_name, author, release_name)
		VALUES('delete', old.id, old.title, old.name, old.group_name, old.author, old.release_name);
		INSERT INTO entries_fts(rowid, title, name, group_name, author, release_name)
		VALUES (new.id, new.title, new.name, new.group_name, new.author, new.release_name);
	END;

	-- Menu path indexes
	CREATE INDEX IF NOT EXISTS idx_menu_parent ON menu_paths(parent_path);
	CREATE INDEX IF NOT EXISTS idx_menu_type ON menu_paths(type);
	`

	_, err := db.conn.Exec(schema)
	if err != nil {
		return fmt.Errorf("creating schema: %w", err)
	}

	// Insert schema version if not exists.
	_, err = db.conn.Exec(`INSERT OR IGNORE INTO schema_info (version) VALUES (?)`, schemaVersion)
	if err != nil {
		return fmt.Errorf("inserting schema version: %w", err)
	}

	slog.Info("Database schema initialized", "version", schemaVersion)
	return nil
}

// Entry represents a database entry.
type Entry struct {
	ID              int64
	Category        string
	Source          string
	Title           string
	Name            string
	NormalizedTitle string
	GroupName       string
	Year            string
	Path            string
	PrimaryFile     string
	FileType        string
	Top200Rank      *int
	Top500Rank      *int
	YearRank        *int
	PartyRank       *int
	Rating          *float64
	ReleaseName     string
	Is4k            bool
	IsCracked       bool
	Trainers        int
	CrackFlags      string
	Language        string
	Region          string
	Engine          string
	IsPreview       bool
	Version         string
	Party           string
	Competition     string
	IsOnefile       bool
	Author          string
	Collection      string
}

// File represents a file within an entry.
type File struct {
	ID      int64
	EntryID int64
	Name    string
	Type    string
	Size    int64
}

// MenuPath represents a navigation path.
type MenuPath struct {
	ID         int64
	Path       string
	Name       string
	Type       string // "folder" or "list"
	ParentPath string
	EntryCount int
	SortOrder  int
}

// InsertEntry inserts a new entry and returns its ID.
func (db *DB) InsertEntry(e *Entry) (int64, error) {
	result, err := db.conn.Exec(`
		INSERT INTO entries (
			category, source, title, name, normalized_title, group_name, year, path,
			primary_file, file_type, top200_rank, top500_rank, year_rank, party_rank, rating,
			release_name, is_4k, is_cracked, trainers, crack_flags, language, region, engine,
			is_preview, version, party, competition, is_onefile, author, collection
		) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
		e.Category, e.Source, e.Title, e.Name, e.NormalizedTitle, e.GroupName, e.Year, e.Path,
		e.PrimaryFile, e.FileType, e.Top200Rank, e.Top500Rank, e.YearRank, e.PartyRank, e.Rating,
		e.ReleaseName, e.Is4k, e.IsCracked, e.Trainers, e.CrackFlags, e.Language, e.Region, e.Engine,
		e.IsPreview, e.Version, e.Party, e.Competition, e.IsOnefile, e.Author, e.Collection,
	)
	if err != nil {
		return 0, fmt.Errorf("inserting entry: %w", err)
	}
	return result.LastInsertId()
}

// InsertFile inserts a file record for an entry.
func (db *DB) InsertFile(f *File) error {
	_, err := db.conn.Exec(`
		INSERT INTO files (entry_id, name, type, size)
		VALUES (?, ?, ?, ?)`,
		f.EntryID, f.Name, f.Type, f.Size,
	)
	return err
}

// InsertMenuPath inserts a menu path entry.
func (db *DB) InsertMenuPath(m *MenuPath) error {
	_, err := db.conn.Exec(`
		INSERT OR REPLACE INTO menu_paths (path, name, type, parent_path, entry_count, sort_order)
		VALUES (?, ?, ?, ?, ?, ?)`,
		m.Path, m.Name, m.Type, m.ParentPath, m.EntryCount, m.SortOrder,
	)
	return err
}

// BeginTx starts a transaction.
func (db *DB) BeginTx() (*sql.Tx, error) {
	return db.conn.Begin()
}

// GetEntryByID retrieves an entry by ID.
func (db *DB) GetEntryByID(id int64) (*Entry, error) {
	row := db.conn.QueryRow(`
		SELECT id, category, source, title, name, normalized_title, group_name, year, path,
			primary_file, file_type, top200_rank, top500_rank, year_rank, party_rank, rating,
			release_name, is_4k, is_cracked, trainers, crack_flags, language, region, engine,
			is_preview, version, party, competition, is_onefile, author, collection
		FROM entries WHERE id = ?`, id)

	var e Entry
	var is4k, isCracked, isPreview, isOnefile int
	err := row.Scan(
		&e.ID, &e.Category, &e.Source, &e.Title, &e.Name, &e.NormalizedTitle, &e.GroupName, &e.Year, &e.Path,
		&e.PrimaryFile, &e.FileType, &e.Top200Rank, &e.Top500Rank, &e.YearRank, &e.PartyRank, &e.Rating,
		&e.ReleaseName, &is4k, &isCracked, &e.Trainers, &e.CrackFlags, &e.Language, &e.Region, &e.Engine,
		&isPreview, &e.Version, &e.Party, &e.Competition, &isOnefile, &e.Author, &e.Collection,
	)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	e.Is4k = is4k != 0
	e.IsCracked = isCracked != 0
	e.IsPreview = isPreview != 0
	e.IsOnefile = isOnefile != 0
	return &e, nil
}

// GetEntriesByPath retrieves entries matching a path prefix.
func (db *DB) GetEntriesByPath(pathPrefix string, offset, limit int) ([]*Entry, int, error) {
	// Get total count.
	var total int
	err := db.conn.QueryRow(`SELECT COUNT(*) FROM entries WHERE path LIKE ? || '%'`, pathPrefix).Scan(&total)
	if err != nil {
		return nil, 0, err
	}

	// Get entries.
	rows, err := db.conn.Query(`
		SELECT id, category, source, title, name, normalized_title, group_name, year, path,
			primary_file, file_type, top200_rank, top500_rank, year_rank, party_rank, rating,
			release_name, is_4k, is_cracked, trainers, crack_flags, language, region, engine,
			is_preview, version, party, competition, is_onefile, author, collection
		FROM entries
		WHERE path LIKE ? || '%'
		ORDER BY normalized_title, group_name
		LIMIT ? OFFSET ?`, pathPrefix, limit, offset)
	if err != nil {
		return nil, 0, err
	}
	defer rows.Close()

	var entries []*Entry
	for rows.Next() {
		var e Entry
		var is4k, isCracked, isPreview, isOnefile int
		err := rows.Scan(
			&e.ID, &e.Category, &e.Source, &e.Title, &e.Name, &e.NormalizedTitle, &e.GroupName, &e.Year, &e.Path,
			&e.PrimaryFile, &e.FileType, &e.Top200Rank, &e.Top500Rank, &e.YearRank, &e.PartyRank, &e.Rating,
			&e.ReleaseName, &is4k, &isCracked, &e.Trainers, &e.CrackFlags, &e.Language, &e.Region, &e.Engine,
			&isPreview, &e.Version, &e.Party, &e.Competition, &isOnefile, &e.Author, &e.Collection,
		)
		if err != nil {
			return nil, 0, err
		}
		e.Is4k = is4k != 0
		e.IsCracked = isCracked != 0
		e.IsPreview = isPreview != 0
		e.IsOnefile = isOnefile != 0
		entries = append(entries, &e)
	}
	return entries, total, nil
}

// GetGroupedEntriesByPath retrieves entries grouped by normalized title.
func (db *DB) GetGroupedEntriesByPath(pathPrefix string, letterFilter string, offset, limit int) ([]GroupedEntry, int, error) {
	// Build query with optional letter filter.
	whereClause := "path LIKE ? || '%'"
	args := []interface{}{pathPrefix}

	if letterFilter != "" {
		if letterFilter == "#" {
			// Non-alphabetic first character.
			whereClause += " AND (normalized_title < 'a' OR normalized_title >= '{')"
		} else {
			// Specific letter.
			letter := strings.ToLower(letterFilter)
			whereClause += " AND normalized_title >= ? AND normalized_title < ?"
			args = append(args, letter, string(letter[0]+1))
		}
	}

	// Get total count of groups.
	countQuery := fmt.Sprintf(`SELECT COUNT(DISTINCT normalized_title) FROM entries WHERE %s`, whereClause)
	var total int
	err := db.conn.QueryRow(countQuery, args...).Scan(&total)
	if err != nil {
		return nil, 0, err
	}

	// Get grouped entries.
	query := fmt.Sprintf(`
		SELECT normalized_title, title, group_name, year, path, file_type, COUNT(*) as release_count
		FROM entries
		WHERE %s
		GROUP BY normalized_title
		ORDER BY normalized_title
		LIMIT ? OFFSET ?`, whereClause)

	args = append(args, limit, offset)
	rows, err := db.conn.Query(query, args...)
	if err != nil {
		return nil, 0, err
	}
	defer rows.Close()

	var entries []GroupedEntry
	for rows.Next() {
		var e GroupedEntry
		err := rows.Scan(&e.NormalizedTitle, &e.Title, &e.GroupName, &e.Year, &e.Path, &e.FileType, &e.ReleaseCount)
		if err != nil {
			return nil, 0, err
		}
		entries = append(entries, e)
	}
	return entries, total, nil
}

// GroupedEntry represents a title with multiple releases.
type GroupedEntry struct {
	NormalizedTitle string
	Title           string
	GroupName       string
	Year            string
	Path            string
	FileType        string
	ReleaseCount    int
}

// Search performs full-text search on entries.
func (db *DB) Search(query string, category string, offset, limit int) ([]*Entry, int, error) {
	// Build the query.
	ftsQuery := query + "*" // Prefix search.

	whereClause := "entries_fts MATCH ?"
	args := []interface{}{ftsQuery}

	if category != "" && !strings.EqualFold(category, "All") {
		whereClause += " AND e.category = ?"
		args = append(args, category)
	}

	// Get count.
	countQuery := fmt.Sprintf(`
		SELECT COUNT(*) FROM entries e
		JOIN entries_fts ON e.id = entries_fts.rowid
		WHERE %s`, whereClause)
	var total int
	err := db.conn.QueryRow(countQuery, args...).Scan(&total)
	if err != nil {
		return nil, 0, fmt.Errorf("count query: %w", err)
	}

	// Get results.
	selectQuery := fmt.Sprintf(`
		SELECT e.id, e.category, e.source, e.title, e.name, e.normalized_title, e.group_name, e.year, e.path,
			e.primary_file, e.file_type, e.top200_rank, e.top500_rank, e.year_rank, e.party_rank, e.rating,
			e.release_name, e.is_4k, e.is_cracked, e.trainers, e.crack_flags, e.language, e.region, e.engine,
			e.is_preview, e.version, e.party, e.competition, e.is_onefile, e.author, e.collection
		FROM entries e
		JOIN entries_fts ON e.id = entries_fts.rowid
		WHERE %s
		ORDER BY rank
		LIMIT ? OFFSET ?`, whereClause)

	args = append(args, limit, offset)
	rows, err := db.conn.Query(selectQuery, args...)
	if err != nil {
		return nil, 0, fmt.Errorf("search query: %w", err)
	}
	defer rows.Close()

	var entries []*Entry
	for rows.Next() {
		var e Entry
		var is4k, isCracked, isPreview, isOnefile int
		err := rows.Scan(
			&e.ID, &e.Category, &e.Source, &e.Title, &e.Name, &e.NormalizedTitle, &e.GroupName, &e.Year, &e.Path,
			&e.PrimaryFile, &e.FileType, &e.Top200Rank, &e.Top500Rank, &e.YearRank, &e.PartyRank, &e.Rating,
			&e.ReleaseName, &is4k, &isCracked, &e.Trainers, &e.CrackFlags, &e.Language, &e.Region, &e.Engine,
			&isPreview, &e.Version, &e.Party, &e.Competition, &isOnefile, &e.Author, &e.Collection,
		)
		if err != nil {
			return nil, 0, err
		}
		e.Is4k = is4k != 0
		e.IsCracked = isCracked != 0
		e.IsPreview = isPreview != 0
		e.IsOnefile = isOnefile != 0
		entries = append(entries, &e)
	}
	return entries, total, nil
}

// GetReleasesByTitle finds all releases with the same normalized title.
func (db *DB) GetReleasesByTitle(pathPrefix, normalizedTitle string, offset, limit int) ([]*Entry, int, error) {
	whereClause := "normalized_title = ?"
	args := []interface{}{normalizedTitle}

	if pathPrefix != "" {
		whereClause += " AND path LIKE ? || '%'"
		args = append(args, pathPrefix)
	}

	// Get count.
	var total int
	err := db.conn.QueryRow(fmt.Sprintf(`SELECT COUNT(*) FROM entries WHERE %s`, whereClause), args...).Scan(&total)
	if err != nil {
		return nil, 0, err
	}

	// Get entries.
	query := fmt.Sprintf(`
		SELECT id, category, source, title, name, normalized_title, group_name, year, path,
			primary_file, file_type, top200_rank, top500_rank, year_rank, party_rank, rating,
			release_name, is_4k, is_cracked, trainers, crack_flags, language, region, engine,
			is_preview, version, party, competition, is_onefile, author, collection
		FROM entries
		WHERE %s
		ORDER BY group_name, year
		LIMIT ? OFFSET ?`, whereClause)

	args = append(args, limit, offset)
	rows, err := db.conn.Query(query, args...)
	if err != nil {
		return nil, 0, err
	}
	defer rows.Close()

	var entries []*Entry
	for rows.Next() {
		var e Entry
		var is4k, isCracked, isPreview, isOnefile int
		err := rows.Scan(
			&e.ID, &e.Category, &e.Source, &e.Title, &e.Name, &e.NormalizedTitle, &e.GroupName, &e.Year, &e.Path,
			&e.PrimaryFile, &e.FileType, &e.Top200Rank, &e.Top500Rank, &e.YearRank, &e.PartyRank, &e.Rating,
			&e.ReleaseName, &is4k, &isCracked, &e.Trainers, &e.CrackFlags, &e.Language, &e.Region, &e.Engine,
			&isPreview, &e.Version, &e.Party, &e.Competition, &isOnefile, &e.Author, &e.Collection,
		)
		if err != nil {
			return nil, 0, err
		}
		e.Is4k = is4k != 0
		e.IsCracked = isCracked != 0
		e.IsPreview = isPreview != 0
		e.IsOnefile = isOnefile != 0
		entries = append(entries, &e)
	}
	return entries, total, nil
}

// GetMenuChildren retrieves child menu paths.
func (db *DB) GetMenuChildren(parentPath string) ([]*MenuPath, error) {
	rows, err := db.conn.Query(`
		SELECT id, path, name, type, parent_path, entry_count, sort_order
		FROM menu_paths
		WHERE parent_path = ?
		ORDER BY sort_order, name`, parentPath)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var paths []*MenuPath
	for rows.Next() {
		var m MenuPath
		err := rows.Scan(&m.ID, &m.Path, &m.Name, &m.Type, &m.ParentPath, &m.EntryCount, &m.SortOrder)
		if err != nil {
			return nil, err
		}
		paths = append(paths, &m)
	}
	return paths, nil
}

// CountByPathPrefix counts entries matching a path prefix.
func (db *DB) CountByPathPrefix(pathPrefix string) (int, error) {
	var count int
	err := db.conn.QueryRow(`SELECT COUNT(*) FROM entries WHERE path LIKE ? || '%'`, pathPrefix).Scan(&count)
	return count, err
}

// GetLetterCounts returns the count of entries for each starting letter under a path.
func (db *DB) GetLetterCounts(pathPrefix string) (map[string]int, error) {
	rows, err := db.conn.Query(`
		SELECT
			CASE
				WHEN SUBSTR(UPPER(normalized_title), 1, 1) BETWEEN 'A' AND 'Z'
				THEN SUBSTR(UPPER(normalized_title), 1, 1)
				ELSE '#'
			END as letter,
			COUNT(*) as cnt
		FROM entries
		WHERE path LIKE ? || '%'
		GROUP BY letter
		ORDER BY letter`, pathPrefix)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	counts := make(map[string]int)
	for rows.Next() {
		var letter string
		var count int
		if err := rows.Scan(&letter, &count); err != nil {
			return nil, err
		}
		counts[letter] = count
	}
	return counts, nil
}

// GetYearCounts returns the count of entries for each year under a path.
func (db *DB) GetYearCounts(pathPrefix string) (map[string]int, error) {
	rows, err := db.conn.Query(`
		SELECT year, COUNT(*) as cnt
		FROM entries
		WHERE path LIKE ? || '%' AND year IS NOT NULL AND year != ''
		GROUP BY year
		ORDER BY year DESC`, pathPrefix)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	counts := make(map[string]int)
	for rows.Next() {
		var year string
		var count int
		if err := rows.Scan(&year, &count); err != nil {
			return nil, err
		}
		counts[year] = count
	}
	return counts, nil
}

// ClearAll removes all data from the database.
func (db *DB) ClearAll() error {
	tables := []string{"files", "entries", "menu_paths"}
	for _, table := range tables {
		if _, err := db.conn.Exec(fmt.Sprintf("DELETE FROM %s", table)); err != nil {
			return err
		}
	}
	// Reset FTS.
	if _, err := db.conn.Exec("INSERT INTO entries_fts(entries_fts) VALUES('rebuild')"); err != nil {
		return err
	}
	return nil
}
