# JSON Database Format Specification

This document describes the JSON database format for indexing the Assembly64 C64 software collection.

## Overview

The database is split into separate JSON files per category:
- `c64uploader_games.json` - Games from Games/CSDB/All
- `c64uploader_demos.json` - Demos from Demos/CSDB/All
- `c64uploader_music.json` - Music from multiple collections (CSDB, HVSC, 2sid, 3sid)

Each file follows the same structure but contains entries for its specific category. The TUI and server modes automatically load and merge all available category files.

## File Structure

```json
{
  "version": "1.0",
  "generated": "2025-01-15T20:00:00Z",
  "source": "csdb",
  "totalEntries": 133861,

  "entries": [...]
}
```

| Field | Type | Description |
|-------|------|-------------|
| `version` | string | Schema version |
| `generated` | string | ISO 8601 timestamp of generation |
| `source` | string | Data source identifier (e.g., "csdb") |
| `totalEntries` | int | Number of entries in this file |
| `entries` | array | Array of entry objects |

## Entry Structure

### Games Entry

```json
{
  "id": 1,
  "category": "games",
  "title": "The Great Giana Sisters",
  "releaseName": "The Great Giana Sisters +9DFH",
  "group": "Remember",

  "top200Rank": 8,
  "is4k": false,

  "path": "Games/CSDB/All/T/THEA - THEA/The Great Giana Sisters/Remember/The Great Giana Sisters +9DFH",

  "files": [
    {"name": "giana.d64", "type": "d64", "size": 174848}
  ],
  "primaryFile": "giana.d64",
  "fileType": "d64",

  "crack": {
    "isCracked": true,
    "trainers": 9,
    "flags": ["docs", "fastload", "highscore"]
  },

  "language": null,
  "region": null,
  "engine": null,
  "isPreview": false,
  "version": null
}
```

### Demos Entry

```json
{
  "id": 1,
  "category": "demos",
  "title": "Second Reality 64",
  "group": "Smash Designs",

  "top200Rank": 5,
  "top500Rank": null,
  "year": 2017,
  "yearRank": 1,
  "party": "X'2017",
  "partyRank": 1,
  "competition": "C64 Demo",
  "isOnefile": false,
  "rating": 9.5,

  "path": "Demos/CSDB/All/S/Smash Designs/Second Reality 64",

  "files": [
    {"name": "second_reality.d64", "type": "d64", "size": 174848}
  ],
  "primaryFile": "second_reality.d64",
  "fileType": "d64"
}
```

### Music Entry

```json
{
  "id": 1,
  "category": "music",
  "title": "Commando",
  "author": "Rob Hubbard",
  "collection": "hvsc",

  "top200Rank": null,
  "year": null,
  "party": null,
  "partyRank": null,
  "competition": null,

  "path": "Music/HVSC/Music/H/Hubbard_Rob/Commando",

  "files": [
    {"name": "Commando.sid", "type": "sid", "size": 4096}
  ],
  "primaryFile": "Commando.sid",
  "fileType": "sid"
}
```

### Common Entry Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Sequential identifier for protocol communication |
| `category` | string | Category: games, demos, music |
| `title` | string | Original title |
| `group` | string | Group name (cracker for games, demo group for demos) |
| `top200Rank` | int/null | Rank 1-200 if in Top200 folder, null otherwise |
| `path` | string | Relative path from assembly64 root directory |
| `files` | array | Array of file objects in the release folder |
| `primaryFile` | string | Recommended file to launch |
| `fileType` | string | File extension of primary file (d64, prg, t64, tap, crt, sid) |

### Games-Specific Fields

| Field | Type | Description |
|-------|------|-------------|
| `releaseName` | string | Full release name including crack info |
| `is4k` | bool | True if entry exists in 4k competition folder |
| `crack` | object | Crack/trainer information (see below) |
| `language` | string/null | Language if specified: german, french, english, etc. |
| `region` | string/null | Region if specified: PAL, NTSC |
| `engine` | string/null | Game engine if known: seuck, gkgm, bdck |
| `isPreview` | bool | True if release name contains "Preview" |
| `version` | string/null | Version string if present (e.g., "V1.1") |

### Demos-Specific Fields

| Field | Type | Description |
|-------|------|-------------|
| `top500Rank` | int/null | Rank 1-500 if in Top500 folder |
| `year` | int/null | Release year |
| `yearRank` | int/null | Rank within year's top 20 |
| `party` | string/null | Party/event name (e.g., "X'2017", "Revision 2020") |
| `partyRank` | int/null | Placement at party competition |
| `competition` | string/null | Competition type (e.g., "C64 Demo", "C64 4K Intro") |
| `isOnefile` | bool | True if single-file demo (from Onefile folder) |
| `rating` | float/null | CSDB rating (0.0-10.0) |

### Music-Specific Fields

| Field | Type | Description |
|-------|------|-------------|
| `author` | string/null | Composer/artist name (from HVSC directory structure) |
| `collection` | string | Source collection: csdb, hvsc, 2sid, 3sid |
| `year` | int/null | Release year (CSDB music only, from party data) |
| `party` | string/null | Party/event name (CSDB music only) |
| `partyRank` | int/null | Placement at party competition (CSDB music only) |
| `competition` | string/null | Competition type (CSDB music only) |

### File Object

```json
{"name": "giana.d64", "type": "d64", "size": 174848}
```

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Filename |
| `type` | string | File extension |
| `size` | int | File size in bytes |

### Crack Object

```json
{
  "isCracked": true,
  "trainers": 9,
  "flags": ["docs", "fastload", "highscore"]
}
```

| Field | Type | Description |
|-------|------|-------------|
| `isCracked` | bool | True if release name contains "+" |
| `trainers` | int | Number of trainers (0 if none) |
| `flags` | array | Array of flag strings (see below) |

### Crack Flags

Parsed from release name suffix (e.g., `+9DFH`):

| Code | Flag String | Meaning |
|------|-------------|---------|
| D | docs | Documentation/manual included |
| F | fastload | Fastloader |
| H | highscore | Highscore saver |
| P | palntsxfix | PAL/NTSC fix |
| T | tape | Tape version |
| I | intro | Has intro |
| G | gfx | Modified graphics |
| R | trainer | Generic trainer flag |
| S | save | Save game support |

Multi-disk indicators (1D, 2D, 3D) are also captured in flags.

## Path Structure

Paths are relative to the assembly64 root directory (specified via `-assembly64` flag).

### Games Directory Hierarchy

```
Games/CSDB/All/{Letter}/{Range}/{Title}/{Group}/{ReleaseName}/
```

Example:
```
Games/CSDB/All/T/THEA - THEA/The Great Giana Sisters/Remember/The Great Giana Sisters +9DFH/
```

**Path components:**
- Level 1: Category (Games)
- Level 2: Source (CSDB)
- Level 3: Collection (All)
- Level 4: Alphabetical letter
- Level 5: Alphabetical range (e.g., "THEA - THEA")
- Level 6: Title (original game name)
- Level 7: Group (cracker/publisher)
- Level 8: Release name (with crack info)

### Demos Directory Hierarchy

```
Demos/CSDB/All/{Letter}/{Group}/{Title}/
```

Example:
```
Demos/CSDB/All/S/Smash Designs/Second Reality 64/
```

**Path components:**
- Level 1: Category (Demos)
- Level 2: Source (CSDB)
- Level 3: Collection (All)
- Level 4: Alphabetical letter (by group name)
- Level 5: Group (demo group)
- Level 6: Title (demo name)

### Music Directory Hierarchy

Music is sourced from multiple collections with different structures:

**CSDB Collection:**
```
Music/CSDB/All/{Letter}/{Title}/
```

Example:
```
Music/CSDB/All/C/Commando_Remix/
```

**HVSC Collection (High Voltage SID Collection):**
```
Music/HVSC/Music/{Letter}/{Author}/{Title}/
```

Example:
```
Music/HVSC/Music/H/Hubbard_Rob/Commando/
```

**2sid/3sid Collections:**
```
Music/2sid-collection/{Letter}/{Author}/{Title}/
Music/3sid-collection/{Letter}/{Author}/{Title}/
```

**Path components (HVSC style):**
- Level 1: Category (Music)
- Level 2: Collection (HVSC, 2sid-collection, 3sid-collection)
- Level 3: Music subdirectory (HVSC only)
- Level 4: Alphabetical letter (by author)
- Level 5: Author/composer name
- Level 6: Title (song/album name)

**Path components (CSDB style):**
- Level 1: Category (Music)
- Level 2: Source (CSDB)
- Level 3: Collection (All)
- Level 4: Alphabetical letter (by title)
- Level 5: Title

## Metadata Extraction

### From Directory Structure

**Games:**
| Metadata | Source |
|----------|--------|
| `title` | Path level 6 folder name |
| `group` | Path level 7 folder name |
| `releaseName` | Path level 8 folder name |

**Demos:**
| Metadata | Source |
|----------|--------|
| `group` | Path level 5 folder name |
| `title` | Path level 6 folder name |

**Music (HVSC/2sid/3sid):**
| Metadata | Source |
|----------|--------|
| `author` | Path level 5 folder name (author/composer) |
| `title` | Path level 6 folder name |
| `collection` | Path level 2 folder name (hvsc, 2sid, 3sid) |

**Music (CSDB):**
| Metadata | Source |
|----------|--------|
| `title` | Path level 5 folder name |
| `collection` | Hardcoded as "csdb" |

### From Release Name Parsing (Games only)

The release name is parsed to extract:

| Pattern | Extracted Field |
|---------|-----------------|
| `+` or `+N` | `crack.isCracked`, `crack.trainers` |
| `+NDFH` etc. | `crack.flags` |
| `[german]`, `[french]` | `language` |
| `[seuck]`, `[gkgm]` | `engine` |
| `NTSC`, `PAL` | `region` |
| `Preview` | `isPreview` |
| `V1.0`, `V2.1` | `version` |

### From Cross-Reference

**Games:**
| Metadata | Source |
|----------|--------|
| `top200Rank` | Presence in `Games/CSDB/Top200/` folder (rank from folder name prefix) |
| `is4k` | Presence in `Games/CSDB/4k/` folder |

**Demos:**
| Metadata | Source |
|----------|--------|
| `top200Rank` | Presence in `Demos/CSDB/Top200/` folder (rank from folder name prefix) |
| `top500Rank` | Presence in `Demos/CSDB/Top500/` folder (rank from folder name prefix) |
| `year` | Presence in `Demos/CSDB/Year/` folder |
| `yearRank` | Presence in `Demos/CSDB/Year-top20/` folder (rank from folder name prefix) |
| `party`, `partyRank`, `competition` | Presence in `Demos/CSDB/Year-party-group/` folder |
| `isOnefile` | Presence in `Demos/CSDB/Onefile/` folder |
| `rating` | Presence in `Demos/CSDB/Rating-year-group/` folder (rating from folder name prefix) |

**Music (CSDB only):**
| Metadata | Source |
|----------|--------|
| `top200Rank` | Presence in `Music/CSDB/Top200/` folder (rank from folder name prefix) |
| `year`, `party`, `partyRank`, `competition` | Presence in `Music/CSDB/Year-party-group/` folder |

## Estimated File Sizes

| Category | Entries | Minified | Gzipped |
|----------|---------|----------|---------|
| Games | ~134,000 | ~80 MB | ~10 MB |
| Demos | ~61,000 | ~37 MB | ~5 MB |
| Music | ~130,000 | ~78 MB | ~10 MB |
| Others | TBD | TBD | TBD |

**Estimate:** ~600 bytes per entry (minified JSON)

## Usage

### Generating the Database

Use the `dbgen` command to generate the database from your Assembly64 collection:

```bash
# Generate all category files (games, demos, and music)
./c64uploader dbgen -assembly64 ~/assembly64

# Generate only games database
./c64uploader dbgen -assembly64 ~/assembly64 -category games

# Generate only demos database
./c64uploader dbgen -assembly64 ~/assembly64 -category demos

# Generate only music database
./c64uploader dbgen -assembly64 ~/assembly64 -category music
```

This creates:
- `<assembly64>/c64uploader_games.json`
- `<assembly64>/c64uploader_demos.json`
- `<assembly64>/c64uploader_music.json`

### Using the Database

The JSON databases are automatically loaded and merged from the assembly64 directory:

```bash
# TUI mode (loads all available category files)
./c64uploader tui -assembly64 ~/assembly64

# Server mode
./c64uploader server -assembly64 ~/assembly64

# Force legacy mode (skip JSON database)
./c64uploader tui -legacy -assembly64 ~/assembly64
```

### File Path Construction

Full file path is constructed as:
```
{assembly64_root}/{path}/{primaryFile}
```

Example:
```
/home/user/assembly64/Games/CSDB/All/.../giana.d64
```

Where `assembly64_root` is the value passed to `-assembly64` flag.

### Advanced Search

When using the JSON database in TUI mode, press `/` to open the advanced search form.
This allows filtering by all metadata fields: language, region, engine, trainer count, Top200 status, etc.
