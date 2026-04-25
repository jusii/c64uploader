# SQLite Database Schema

This document describes the SQLite database schema for the C64 Assembly64 browser.

## Overview

The SQLite database is the primary storage format, replacing the legacy JSON files for better performance with large collections (300K+ entries). It uses pure Go SQLite (`modernc.org/sqlite`) requiring no CGO.

**Database file:** `c64uploader.db` (in assembly64 directory)

**Generation:**
```bash
./c64uploader sqlitegen -assembly64 ~/assembly64
```

## Schema Version

Current schema version: **1**

```sql
CREATE TABLE schema_info (
    version INTEGER PRIMARY KEY,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

## Tables

### entries

Main unified table for all content types (Games, Demos, Music, Graphics, Discmags, Intros).

```sql
CREATE TABLE entries (
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
    top500_rank INTEGER,              -- 1-500 or NULL (demos only)
    year_rank INTEGER,                -- Rank within year's top 20
    party_rank INTEGER,               -- Placement at party competition
    rating REAL,                      -- CSDB rating 0.0-10.0

    -- Games-specific
    release_name TEXT,                -- Full release name with crack info
    is_4k INTEGER DEFAULT 0,          -- 4k competition entry
    is_cracked INTEGER DEFAULT 0,     -- Has crack
    trainers INTEGER DEFAULT 0,       -- Number of trainers
    crack_flags TEXT,                 -- Comma-separated: docs,fastload,highscore
    language TEXT,                    -- german, french, english, etc.
    region TEXT,                      -- PAL, NTSC
    engine TEXT,                      -- seuck, gkgm, bdck
    is_preview INTEGER DEFAULT 0,     -- Preview/unfinished release
    version TEXT,                     -- Version string (V1.1, etc.)

    -- Demos-specific
    party TEXT,                       -- Party/event name
    competition TEXT,                 -- Competition type
    is_onefile INTEGER DEFAULT 0,     -- Single-file demo

    -- Music-specific
    author TEXT,                      -- Composer (HVSC uses this)
    collection TEXT,                  -- csdb, hvsc, 2sid, 3sid

    -- Metadata
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

### files

Files within each entry (one entry may have multiple files).

```sql
CREATE TABLE files (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entry_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,               -- File extension
    size INTEGER DEFAULT 0,
    FOREIGN KEY (entry_id) REFERENCES entries(id) ON DELETE CASCADE
);
```

### menu_paths

Pre-computed hierarchical navigation structure for fast MENU queries.

```sql
CREATE TABLE menu_paths (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    path TEXT NOT NULL UNIQUE,        -- e.g., "Games/CSDB/A"
    name TEXT NOT NULL,               -- Display name, e.g., "A"
    type TEXT NOT NULL,               -- "folder" or "list"
    parent_path TEXT,                 -- Parent path, e.g., "Games/CSDB"
    entry_count INTEGER DEFAULT 0,    -- Number of entries under this path
    sort_order INTEGER DEFAULT 0      -- For custom ordering
);
```

### entries_fts (FTS5)

Full-text search virtual table for fast text queries.

```sql
CREATE VIRTUAL TABLE entries_fts USING fts5(
    title,
    name,
    group_name,
    author,
    release_name,
    content=entries,
    content_rowid=id
);
```

Kept in sync via triggers (entries_ai, entries_ad, entries_au).

## Indexes

### Single-column indexes
```sql
CREATE INDEX idx_entries_category ON entries(category);
CREATE INDEX idx_entries_source ON entries(source);
CREATE INDEX idx_entries_normalized_title ON entries(normalized_title);
CREATE INDEX idx_entries_path ON entries(path);
CREATE INDEX idx_entries_group ON entries(group_name);
CREATE INDEX idx_entries_year ON entries(year);
CREATE INDEX idx_entries_top200 ON entries(top200_rank) WHERE top200_rank IS NOT NULL;
CREATE INDEX idx_entries_author ON entries(author) WHERE author IS NOT NULL;
CREATE INDEX idx_entries_collection ON entries(collection) WHERE collection IS NOT NULL;
```

### Composite indexes
```sql
CREATE INDEX idx_entries_cat_source ON entries(category, source);
CREATE INDEX idx_entries_cat_source_title ON entries(category, source, normalized_title);
```

### Menu indexes
```sql
CREATE INDEX idx_menu_parent ON menu_paths(parent_path);
CREATE INDEX idx_menu_type ON menu_paths(type);
```

## Data Sources

### Games Sources
| Source | Path Pattern | Description |
|--------|--------------|-------------|
| CSDB | Games/CSDB/All/... | CSDB releases |
| C64com | Games/C64com/... | C64.com collection |
| Gamebase | Games/Gamebase/... | Gamebase64 |
| Guybrush | Games/Guybrush/... | Guybrush collection |
| OneLoad64 | Games/OneLoad64/... | OneLoad64 |
| Mayhem | Games/Mayhem/... | Mayhem CRT collection |
| C64Tapes | Games/C64Tapes/... | Tape preservations |
| Preservers | Games/Preservers/... | Various preservers |
| SEUCK | Games/SEUCK/... | SEUCK games |

### Demos Sources
| Source | Path Pattern |
|--------|--------------|
| CSDB | Demos/CSDB/All/... |
| C64com | Demos/C64com/... |
| Guybrush | Demos/Guybrush/... |

### Music Sources
| Source | Path Pattern | Description |
|--------|--------------|-------------|
| CSDB | Music/CSDB/All/... | CSDB music releases |
| HVSC | Music/HVSC/Music/... | High Voltage SID Collection |
| 2sid | Music/2sid-collection/... | Stereo SID collection |
| 3sid | Music/3sid-collection/... | Triple SID collection |

### Other Categories
| Category | Source | Path Pattern |
|----------|--------|--------------|
| Graphics | CSDB | Graphics/CSDB/All/... |
| Discmags | CSDB | Discmags/CSDB/All/... |
| Intros | CSDB | Intros/CSDB/All/... |
| Intros | C64org | Intros/C64org/... |

## Common Queries

### List entries by path with letter filter
```sql
SELECT id, title, group_name, year, file_type, trainers
FROM entries
WHERE category = ? AND source = ?
  AND normalized_title >= ? AND normalized_title < ?
ORDER BY normalized_title
LIMIT ? OFFSET ?;
```

### Group by title (for multi-release display)
```sql
SELECT normalized_title, title, group_name, year, file_type, COUNT(*) as release_count
FROM entries
WHERE category = ? AND source = ?
GROUP BY normalized_title
ORDER BY normalized_title
LIMIT ? OFFSET ?;
```

### Full-text search
```sql
SELECT e.* FROM entries e
JOIN entries_fts ON e.id = entries_fts.rowid
WHERE entries_fts MATCH ?
ORDER BY rank
LIMIT ? OFFSET ?;
```

### Get letter counts for menu
```sql
SELECT
    CASE
        WHEN SUBSTR(UPPER(normalized_title), 1, 1) BETWEEN 'A' AND 'Z'
        THEN SUBSTR(UPPER(normalized_title), 1, 1)
        ELSE '#'
    END as letter,
    COUNT(*) as cnt
FROM entries
WHERE category = ? AND source = ?
GROUP BY letter
ORDER BY letter;
```

## Database Size

Approximate sizes for full Assembly64 collection:

| Metric | Value |
|--------|-------|
| Total entries | ~300,000 |
| Database size | ~150 MB |
| Index overhead | ~50 MB |
| WAL file (active) | ~10 MB |

## Performance Configuration

The database uses these SQLite pragmas:

```sql
PRAGMA journal_mode=WAL;    -- Write-Ahead Logging for concurrent reads
PRAGMA foreign_keys=ON;     -- Enforce referential integrity
```

## Migration Notes

When updating schema version:
1. Increment `schemaVersion` constant in `db.go`
2. Add migration logic in `InitSchema()` or create separate migration function
3. Document changes here

## Comparison: SQLite vs JSON

| Aspect | SQLite | JSON |
|--------|--------|------|
| Load time | ~1 second | ~30 seconds |
| Memory usage | ~50 MB | ~500 MB |
| Search speed | Instant (FTS5) | Full scan |
| Disk size | ~150 MB | ~200 MB |
| Updates | Incremental | Full regeneration |
