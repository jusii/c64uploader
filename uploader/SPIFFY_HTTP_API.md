# Spiffy-Compatible HTTP API

This document specifies the HTTP API the Ultimate II+ / C64 Ultimate firmware's built-in **Assembly64 search browser** sends to its configured search service. Implementing it lets the stock firmware browser query and download from our local Assembly64 mirror — no custom C64 cart required.

The Spiffy_Home_Assembly_64 project (GPLv3 Python) was the first community implementation of this API. We do **not** copy its code. This spec is reverse-engineered from observed `assembly64.com` responses (the upstream service) and from the JSON-parsing code in the Ultimate firmware client (the consumer of these responses), supplemented by the Spiffy README's externally-visible facts (route paths, default port, boundary string).

`c64uploader server -spiffy-http-port <port>` enables a second listener on `<port>` that speaks this API alongside our existing TCP line protocol on the `-port` port. Both share the same SQLite index.

## Transport

- **HTTP/1.1** over TCP.
- **Default port:** 8000 (Spiffy's default; user-overridable via flag).
- **CORS:** `Access-Control-Allow-Origin: *` on every response so a web-based search UI can also use it.
- **Method:** GET only.
- **Optional auth gate:** if a `Client-Id` header value is configured server-side, requests without that header value are rejected. Off by default.
- **Chunked transfer for binaries:** the binary download endpoint streams with `Transfer-Encoding: chunked`. JSON endpoints use `Content-Length`.

## Endpoints

All endpoints live under `/leet/search/`.

### `GET /leet/search/aql/presets`

Returns the dropdown choices the firmware uses to populate its search form. The four always-present fields the firmware adds itself are `name`, `group`, `handle`, `event`. Everything else (categories, file types, etc.) comes from presets.

**Response:** bare top-level JSON array. Each element is `{ "type": <string>, "values": [<string>, ...] }`. Order matters — fields render in the order returned.

```json
[
  { "type": "category", "values": ["Games", "Demos", "Music", "Intros", "Graphics", "Discmags"] },
  { "type": "type",     "values": ["d64", "prg", "crt", "sid", "tap", "g64", "d71", "d81"] },
  { "type": "sort",     "values": ["name", "date", "year"] },
  { "type": "order",    "values": ["asc", "desc"] }
]
```

The firmware will treat each `type` string as the AQL key it sends in the query (so `category:Games`).

### `GET /leet/search/aql?query=<aql>` and `GET /leet/search/aql/<start>/<count>?query=<aql>`

Executes a search. `<start>` is a zero-based offset; `<count>` is the page size. The version without `<start>/<count>` is equivalent to `0/100`.

**AQL query syntax** (firmware emitter, exact):

- Clauses are joined by literal ` & ` (space-amp-space).
- Each clause is `(KEY:"VALUE")` for free-text fields and `(KEY:VALUE)` for dropdown values (where `VALUE` is one of the strings the server returned in `presets[KEY].values`).
- Special case for `rating`: the firmware prepends `>=` to the value when the user picked a numeric threshold without their own comparison operator, producing `(rating:>=N)`. Treat the leading `>=` as "minimum N", `>` alone as "strictly greater than N", and a bare integer as "equal to N".
- Empty `query=` is never sent — the firmware blocks an all-empty form locally — but the server should respond to it with an empty array, not an error.
- The whole query value is URL-encoded as the `query=` parameter on the request URL.

Example after URL-decoding:

```
(name:"jumpman") & (category:Games) & (type:d64) & (rating:>=8)
```

A loose extracting regex (the one Spiffy uses) is `\(?(\w+):"?([^")]+)"?\)?` and is sufficient for the firmware's output. A stricter clause walker that splits on ` & ` and matches `(\w+):(?:"([^"]*)"|([^)]+))` is equivalent for everything the firmware emits.

**Recognised keys:**

| Key       | Behaviour                                          |
|-----------|----------------------------------------------------|
| `name`    | Substring (case-insensitive) of the entry name.    |
| `group`   | Substring of the cracker / release group.          |
| `handle`  | Substring of the contributor handle.               |
| `event`   | Substring of party/competition.                    |
| `year`    | Exact integer match against the year column.       |
| `category`| Substring of the path-style category (`Games`, `Games/CSDB`, etc.). The firmware sends the values from `presets[type=category].values`. |
| `subcat`  | Substring of subcategory.                          |
| `type`    | Exact match (case-insensitive) on the file extension. |
| `rating`  | Minimum CSDB rating.                               |
| `date`    | Substring of the `updated` date string.            |
| `repo`    | Source repository (CSDB, Gamebase, etc.).          |
| `id`      | Exact entry id.                                    |
| `updated` | "since" date filter, `YYYY-MM-DD`.                |
| `sort`    | Sort key — one of `name`, `date`, `year` (or whatever `presets[sort].values` returned). |
| `order`   | `asc` or `desc`. Default `asc`.                   |

Unknown keys are ignored (logged at debug level).

**Response:** bare JSON array of entry objects. Each entry has:

| Field          | Type    | Required | Notes                                         |
|----------------|---------|----------|-----------------------------------------------|
| `name`         | string  | yes      | Display name.                                 |
| `id`           | string  | yes      | Stable opaque identifier (we use the SQLite primary key as decimal string). |
| `category`     | integer | yes      | Numeric category code (see "Category codes" below). |
| `siteCategory` | integer | yes      | Upstream category id; we emit `0`.            |
| `siteRating`   | integer | yes      | We emit `0` unless we have CSDB rating.       |
| `group`        | string  | optional | Omit when unknown.                            |
| `handle`       | string  | optional | Omit when unknown.                            |
| `year`         | integer | yes      | `0` when unknown.                             |
| `rating`       | integer | yes      | We emit `0` (or the entry's rating).          |
| `updated`      | string  | yes      | `YYYY-MM-DD` of last update / mtime.          |
| `released`     | string  | optional | `YYYY-MM-DD` when known.                      |

The firmware tolerates extra fields and missing optional fields — verified empirically against `assembly64.com` traffic samples that vary which optionals are present.

### `GET /leet/search/entries/<id>/<cat>`

Lists the **files contained in entry `<id>`** (under category code `<cat>`). E.g. a single `.d64` for one entry; multiple files for an entry with bonus material.

**Response:** JSON object:

```json
{
  "contentEntry": [
    { "path": "jumpmanjr-wcs.d64", "id": 0, "size": 174848 }
  ],
  "isContentByItself": false
}
```

Per-file fields:

| Field   | Type    | Required |
|---------|---------|----------|
| `path`  | string  | yes      | Filename (basename only — used as display + download path component). |
| `id`    | integer | yes      | Zero-based index of this file within the entry. Used as `<idx>` in the binary download URL. |
| `size`  | integer | optional | Bytes. Firmware uses 65536 as the default if missing. |

`isContentByItself`: boolean, present in upstream `assembly64.com` responses but the firmware's parser does not read it (verified — no reference in the JSON-handling code). We emit `false` for cosmetic compatibility.

### `GET /leet/search/bin/<id>/<cat>/<idx-or-filename>` (with optional `/<filename>` suffix)

Downloads a file from entry `<id>` in category `<cat>`.

The third path component can be **either** an integer index (`0`, `1`, …) or a URL-encoded filename. The firmware uses both:

- **Integer index** — when the user picks "Run" / "Mount" on a search result. Comes from the `id` field in the `entries/<id>/<cat>` response.
- **Filename** — when the firmware's filesystem layer mounts a downloaded image and re-requests it by basename (the `file_open` path). Lookup is case-insensitive against the `path` fields returned by `entries/<id>/<cat>`.

An optional **fourth** path component is tolerated but ignored — some implementations append the filename after the integer index for human-readable URLs (`bin/123/1/0/MyDisk.d64`).

**Response headers:**

```
HTTP/1.1 200 OK
Content-Type: multipart/mixed; boundary=<B>
Transfer-Encoding: chunked
Access-Control-Allow-Origin: *
```

**Body** (lines separated by `\r\n`):

```
--<B>\r\n
Content-Disposition: attachment; filename="<basename>"\r\n
Content-Type: application/octet-stream\r\n
\r\n
<raw file bytes>\r\n
--<B>--\r\n
```

- Boundary: any RFC-2046-legal token. We use `c64uploaderboundary`. The firmware parser reads the boundary from the `Content-Type` header — `ULTIMATE_BOUNDARY` is not magic.
- The firmware's filename comes from the part's `Content-Disposition`. Always set it.
- `Content-Type` per part is parsed but the firmware doesn't act on it; `application/octet-stream` is fine for everything (PRG, D64, CRT, SID).
- Single part is the common case. Multi-part is allowed and the firmware loops over parts (so a future "pack a docs PDF + the .d64 in one response" is feasible without protocol changes).
- Body sent as `Transfer-Encoding: chunked`. Chunk size doesn't matter to the firmware parser (it operates on the dechunked stream); we use 4 KB to balance memory and overhead.

## Category codes

The firmware uses small integers in the `category` field of search results and in the `<cat>` URL component. It does **not** decode them — it just echoes the integer back to the server when fetching `entries/<id>/<cat>` and `bin/<id>/<cat>/<idx>`. So the actual integers are a server-side concern; any consistent mapping works. We use:

| Code | Category |
|------|----------|
| 0    | Unknown / other |
| 1    | Games    |
| 2    | Demos    |
| 3    | Music    |
| 4    | Intros   |
| 5    | Graphics |
| 6    | Discmags |

This does **not** match upstream `assembly64.com` (which uses unrelated codes like 7, 16, 17, 20 for various sub-types in sampled responses). We don't need to match — the firmware never compares against a known constant. If a future need to interop with cloud-side requires it, we can remap then.

## Configuring the Ultimate firmware to use this server

The Ultimate's "Assembly Search Servers" config (introduced in the prkl_ultimate firmware fork) is a JSON list keyed off entries with these fields:

| Key            | Default                                | Notes                                              |
|----------------|----------------------------------------|----------------------------------------------------|
| `host`         | `hackerswithstyle.se`                  | Hostname or IP of the Assembly64 server.           |
| `port`         | `80`                                   | TCP port.                                          |
| `client-id`    | (firmware default)                     | Sent as the `Client-Id: <value>` HTTP header on every request. |
| `url-search`   | `/leet/search/aql/0/100?query=`        | Search base URL — the firmware appends the URL-encoded AQL string. |
| `url-patterns` | `/leet/search/aql/presets`             | Presets URL.                                       |
| `url-entries`  | `/leet/search/entries`                 | Per-entry file-list base URL — firmware appends `/<id>/<cat>`. |
| `url-download` | `/leet/search/bin`                     | Binary download base URL — firmware appends `/<id>/<cat>/<idx>`. |

To point at our server, change `host` to the machine running `c64uploader server` and `port` to whatever was passed via `-spiffy-http-port`. The four `url-*` paths can stay at their defaults — we serve all four.

## Out-of-scope (we don't implement)

- Submit / upload endpoints. Read-only mirror.
- Voting / rating endpoints.
- Authentication beyond the optional `Client-Id` gate.
- Pagination metadata — the firmware doesn't display total counts; it just walks the result array.

## Open questions

- **Exact AQL escaping** — the firmware's URL-encode (`url_encode` in `assembly.cc`) percent-encodes anything outside `[A-Za-z0-9_.\-*]`, so spaces become `%20`, double-quotes become `%22`. The server must URL-decode the `query=` parameter before AQL parsing. If the firmware ever ships backslash-escapes or Unicode quotes inside a `(KEY:"VALUE")` literal we'll need to extend the parser; log unrecognised AQL bodies at debug level so we can iterate.
- **`sort` / `order` semantics on multi-key sorts** — assume single-key for now; the firmware's form has exactly one `sort` field and one `order` field.
- **Case-folding** — substring matches will be case-insensitive on all string keys. The firmware sends user input verbatim (no case normalisation) so case-insensitive on the server side is the only sensible option.
- **Result limits** — the firmware always sends `0/100` in its default URL pattern. We honour `<count>` up to a server-side cap (proposed 1000) to protect against abusive queries.
- **Content-Length on JSON endpoints** — set explicitly so the firmware HTTP client doesn't fall through to chunked-or-EOF handling.
