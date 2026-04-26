// Mobile web UI for c64uploader.
//
// Two view modes:
//   - menu/grid: shown for paths returned by /api/menu (folders, sources, A-Z grid)
//   - list: shown for paths returned by /api/list (paginated grouped entries)
// Plus a search overlay that hits /api/search.
//
// Navigation is a small stack of {kind, path, offset, letter} frames; pressing
// Back pops the stack. We don't use the browser history API because dialogs
// and pagination push the URL into states that don't round-trip cleanly on
// mobile.

const PAGE_SIZE = 50;

const state = {
  stack: [],          // array of view frames
  currentEntries: [], // last list page (so the dialog has the entry name)
};

const $ = (sel) => document.querySelector(sel);
const listEl = $("#list");
const crumbEl = $("#crumb");
const backBtn = $("#back");
const pagerEl = $("#pager");
const prevBtn = $("#prev");
const nextBtn = $("#next");
const pageInfoEl = $("#page-info");
const statusEl = $("#status");
const searchToggle = $("#search-toggle");
const searchBar = $("#search-bar");
const searchInput = $("#search-input");
const searchCat = $("#search-cat");
const infoDialog = $("#info");
const infoBody = $("#info-body");
const infoRun = $("#info-run");
const infoClose = $("#info-close");

function pushFrame(frame) {
  state.stack.push(frame);
  render();
}

function popFrame() {
  if (state.stack.length > 1) {
    state.stack.pop();
    render();
  }
}

function topFrame() {
  return state.stack[state.stack.length - 1];
}

function showStatus(msg, kind) {
  statusEl.textContent = msg;
  statusEl.className = "show" + (kind ? " " + kind : "");
  clearTimeout(showStatus._t);
  showStatus._t = setTimeout(() => {
    statusEl.className = "";
  }, 2500);
}

async function fetchJSON(url, opts) {
  const r = await fetch(url, opts);
  if (!r.ok) {
    let body = "";
    try {
      body = await r.text();
    } catch {}
    throw new Error(body || r.statusText || ("HTTP " + r.status));
  }
  return r.json();
}

// ---------- rendering ----------

function render() {
  const f = topFrame();
  if (!f) {
    return openMenu("");
  }
  crumbEl.textContent = breadcrumbFor(f);
  backBtn.style.visibility = state.stack.length > 1 ? "visible" : "hidden";
  if (f.kind === "menu") return renderMenu(f);
  if (f.kind === "list") return renderList(f);
  if (f.kind === "search") return renderSearch(f);
}

function breadcrumbFor(f) {
  if (f.kind === "search") return "Search: " + (f.query || "");
  if (!f.path) return "Assembly64";
  const parts = f.path.split("/").filter(Boolean);
  return parts.join(" / ") || "Assembly64";
}

function isLetterGridPath(path) {
  return /\/A-Z$/.test(path || "");
}

async function renderMenu(f) {
  pagerEl.hidden = true;
  listEl.innerHTML = '<div class="empty">Loading…</div>';
  try {
    const r = await fetchJSON("/api/menu?path=" + encodeURIComponent(f.path));
    listEl.innerHTML = "";
    if (!r.items.length) {
      listEl.innerHTML = '<div class="empty">Empty.</div>';
      return;
    }
    if (isLetterGridPath(f.path)) {
      paintLetterGrid(r.items);
      return;
    }
    for (const it of r.items) {
      listEl.appendChild(menuRow(it));
    }
  } catch (e) {
    listEl.innerHTML =
      '<div class="empty">Error loading menu: ' + escapeHTML(e.message) + "</div>";
  }
}

function menuRow(it) {
  const div = document.createElement("div");
  div.className = "row";
  // type: "f" folder (drill into another menu); "l" list (paginated entries).
  const icon = it.type === "l" ? "&#x1F4DC;" : "&#x1F4C1;";
  const meta = it.count ? '<span class="meta">' + it.count + "</span>" : "";
  div.innerHTML =
    '<span class="icon">' + icon + "</span>" +
    '<span class="name">' + escapeHTML(it.name) + "</span>" +
    meta;
  div.addEventListener("click", () => navigateMenuItem(it));
  return div;
}

function navigateMenuItem(it) {
  if (it.type === "l") {
    pushFrame({ kind: "list", path: it.path, offset: 0 });
  } else {
    pushFrame({ kind: "menu", path: it.path });
  }
}

// The letter-grid menu is just 27 type-"l" entries whose paths are
// "<parent>/A-Z/<letter>". Render them as a 5-column grid for thumb-tapping.
function paintLetterGrid(items) {
  const grid = document.createElement("div");
  grid.style.display = "grid";
  grid.style.gridTemplateColumns = "repeat(5, 1fr)";
  grid.style.gap = "8px";
  grid.style.padding = "4px";
  for (const it of items) {
    const b = document.createElement("button");
    b.className = "row";
    b.style.justifyContent = "center";
    b.style.fontSize = "1.1rem";
    b.style.fontWeight = "600";
    b.style.padding = "16px 0";
    b.style.flexDirection = "column";
    b.style.gap = "2px";
    const sub = it.count
      ? '<span class="meta" style="font-size:.7rem">' + it.count + "</span>"
      : "";
    b.innerHTML = escapeHTML(it.name) + sub;
    if (it.count > 0) {
      b.addEventListener("click", () =>
        pushFrame({ kind: "list", path: it.path, offset: 0 }),
      );
    } else {
      b.disabled = true;
      b.style.opacity = "0.4";
    }
    grid.appendChild(b);
  }
  listEl.innerHTML = "";
  listEl.appendChild(grid);
}

async function renderList(f) {
  listEl.innerHTML = '<div class="empty">Loading…</div>';
  pagerEl.hidden = false;
  try {
    const params = new URLSearchParams({
      path: f.path || "",
      offset: String(f.offset || 0),
      limit: String(PAGE_SIZE),
    });
    const r = await fetchJSON("/api/list?" + params.toString());
    state.currentEntries = r.entries;
    paintEntryList(r);
  } catch (e) {
    listEl.innerHTML =
      '<div class="empty">Error loading list: ' + escapeHTML(e.message) + "</div>";
  }
}

async function renderSearch(f) {
  pagerEl.hidden = false;
  listEl.innerHTML = '<div class="empty">Searching…</div>';
  try {
    const params = new URLSearchParams({
      q: f.query,
      cat: f.cat || "",
      offset: String(f.offset || 0),
      limit: String(PAGE_SIZE),
    });
    const r = await fetchJSON("/api/search?" + params.toString());
    state.currentEntries = r.entries;
    paintEntryList(r);
  } catch (e) {
    listEl.innerHTML =
      '<div class="empty">Error searching: ' + escapeHTML(e.message) + "</div>";
  }
}

function paintEntryList(r) {
  const f = topFrame();
  listEl.innerHTML = "";
  if (!r.entries.length) {
    listEl.innerHTML = '<div class="empty">No results.</div>';
    pagerEl.hidden = true;
    return;
  }
  for (const e of r.entries) {
    listEl.appendChild(entryRow(e));
  }
  const offset = f.offset || 0;
  const start = offset + 1;
  const end = Math.min(offset + r.entries.length, r.total);
  pageInfoEl.textContent = start + "-" + end + " of " + r.total;
  prevBtn.disabled = offset === 0;
  nextBtn.disabled = offset + r.entries.length >= r.total;
}

function entryRow(e) {
  const div = document.createElement("div");
  div.className = "row";
  const trainersBadge =
    e.trainers > 0 ? '<span class="badge trainers">+' + e.trainers + "</span>" : "";
  const releasesBadge =
    e.release_count > 1
      ? '<span class="badge releases">' + e.release_count + "&times;</span>"
      : "";
  div.innerHTML =
    '<span class="icon">&#x25B6;</span>' +
    '<span class="name">' + escapeHTML(e.name) + "</span>" +
    releasesBadge +
    trainersBadge +
    '<button class="info-btn" type="button">i</button>';
  div.addEventListener("click", (ev) => {
    if (ev.target.classList.contains("info-btn")) {
      ev.stopPropagation();
      openInfo(e);
      return;
    }
    runEntry(e);
  });
  return div;
}

// ---------- info dialog ----------

async function openInfo(entry) {
  infoBody.innerHTML = "<h2>" + escapeHTML(entry.name) + "</h2><p>Loading…</p>";
  infoDialog.showModal();
  infoRun.onclick = () => {
    infoDialog.close();
    runEntry(entry);
  };
  infoClose.onclick = () => infoDialog.close();
  try {
    const info = await fetchJSON("/api/info/" + entry.id);
    const dl = (k, v) => v ? '<dt>' + k + '</dt><dd>' + escapeHTML(String(v)) + '</dd>' : '';
    infoBody.innerHTML =
      '<h2>' + escapeHTML(info.title) + "</h2>" +
      "<dl>" +
      dl("Group", info.group) +
      dl("Year", info.year) +
      dl("Category", info.category) +
      dl("Source", info.source) +
      dl("Type", info.type) +
      dl("File", info.primary_file) +
      dl("Top200", info.top200) +
      dl("Rating", info.rating ? info.rating.toFixed(1) : "") +
      dl("Trainers", info.trainers) +
      dl("Release", info.release_name) +
      dl("Author", info.author) +
      "</dl>";
  } catch (e) {
    infoBody.innerHTML =
      '<h2>' + escapeHTML(entry.name) + "</h2>" +
      '<p style="color: var(--bad)">' + escapeHTML(e.message) + "</p>";
  }
}

// ---------- run ----------

async function runEntry(entry) {
  showStatus("Launching " + entry.name + "…");
  try {
    const r = await fetchJSON("/api/run/" + entry.id, { method: "POST" });
    if (r.ok) {
      showStatus("Running on C64", "ok");
    } else {
      showStatus("Error: " + (r.error || "unknown"), "error");
    }
  } catch (e) {
    showStatus("Error: " + e.message, "error");
  }
}

// ---------- helpers ----------

function escapeHTML(s) {
  return String(s)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function openMenu(path) {
  state.stack = [{ kind: "menu", path: path || "" }];
  render();
}

// ---------- event wiring ----------

backBtn.addEventListener("click", popFrame);

prevBtn.addEventListener("click", () => {
  const f = topFrame();
  f.offset = Math.max(0, (f.offset || 0) - PAGE_SIZE);
  render();
});

nextBtn.addEventListener("click", () => {
  const f = topFrame();
  f.offset = (f.offset || 0) + PAGE_SIZE;
  render();
});

searchToggle.addEventListener("click", () => {
  searchBar.hidden = !searchBar.hidden;
  if (!searchBar.hidden) {
    searchInput.focus();
  }
});

let searchTimer = null;
searchInput.addEventListener("input", () => {
  clearTimeout(searchTimer);
  const q = searchInput.value.trim();
  if (q.length < 3) return;
  searchTimer = setTimeout(() => {
    state.stack = [
      { kind: "menu", path: "" },
      { kind: "search", query: q, cat: searchCat.value, offset: 0 },
    ];
    render();
  }, 250);
});

searchCat.addEventListener("change", () => {
  if (searchInput.value.trim().length >= 3) {
    state.stack = [
      { kind: "menu", path: "" },
      { kind: "search", query: searchInput.value.trim(), cat: searchCat.value, offset: 0 },
    ];
    render();
  }
});

window.addEventListener("popstate", popFrame);

openMenu("");
