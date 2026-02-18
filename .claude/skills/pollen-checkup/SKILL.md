# Pollen Checkup

Run a health check on the Methodology site: render validation, broken links, Lighthouse audit (performance, accessibility, SEO, best practices), and documentation drift.

## Steps

### 1. Ensure the dev server is running

Check if port 8080 is already serving:
```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/title.html
```

If the server is NOT running (non-200 response), start it:
```bash
kill -9 $(lsof -ti:8080) 2>/dev/null || true
sleep 1
```
Then start with `run_in_background: true` (no `&`):
```bash
raco pollen start
```
Wait for it:
```bash
for i in $(seq 1 20); do curl -s http://localhost:8080 > /dev/null 2>&1 && echo "SERVER READY" && break || sleep 0.5; done
```

### 2. Render check

Render all source files and capture any errors or warnings:
```bash
cd /Users/marcusberley/Documents/Projects/memoir && raco pollen render 2>&1
```

Report:
- **PASS** if rendering completes with no errors
- **FAIL** with the specific error output if any file fails to render

### 3. Broken link and asset check

Parse every page listed in `index.ptree`. For each rendered HTML file, check:

**Internal navigation links:** Extract all `<a href="...">` where href does not start with `http`. Verify the target file exists on the dev server:
```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/<target>
```

**Content links:** Extract all `◊link[...]` references from `.pm` source files using Grep. For external URLs (`http/https`), do a HEAD request and flag any non-2xx responses:
```bash
curl -sI -o /dev/null -w "%{http_code}" -L --max-time 10 <url>
```

**Assets:** Check that all font files referenced in `styles.css.pp` exist. Check that all images referenced in any `.pm` or template file exist.

Report each broken link/missing asset individually. Summarize as:
- **PASS** if no broken links or missing assets
- **WARN** with count and details if any found

### 4. Lighthouse audit

Run Lighthouse against the local dev server on all four published page types to get representative scores. Pick one page of each type:
- Prose chapter: `http://localhost:8080/chapter-01.html`
- Poem page: `http://localhost:8080/poem-10.html`
- Title page: `http://localhost:8080/title.html`

Run Lighthouse in headless Chrome with JSON output:
```bash
lighthouse http://localhost:8080/chapter-01.html \
  --chrome-flags="--headless=new --no-sandbox" \
  --output=json --output-path=/tmp/lighthouse-checkup.json \
  --only-categories=performance,accessibility,best-practices,seo \
  --quiet 2>&1
```

Parse the JSON to extract scores (multiply by 100 for percentage):
```bash
node -e "
const r = require('/tmp/lighthouse-checkup.json');
const cats = r.categories;
console.log('Performance:', Math.round(cats.performance.score * 100));
console.log('Accessibility:', Math.round(cats.accessibility.score * 100));
console.log('Best Practices:', Math.round(cats['best-practices'].score * 100));
console.log('SEO:', Math.round(cats.seo.score * 100));
"
```

If any audits have specific failures (score < 1.0), list the top 3 failing audits per category with their descriptions.

Scoring thresholds:
- **90-100**: PASS (green)
- **50-89**: WARN (yellow) — list top recommendations
- **0-49**: FAIL (red) — list top recommendations

Run Lighthouse only on `chapter-01.html` to keep the checkup fast. Mention that the user can run it on other pages manually.

### 5. Documentation drift check

Compare CLAUDE.md against the actual project state. Check these specific things:

**File structure:** Glob for all `.pm`, `.html`, template, and config files. Compare against the "Project Structure" section in CLAUDE.md. Flag any files that exist but aren't documented, or documented but don't exist.

**Tag functions:** Grep `pollen.rkt` for all `(define (` function definitions. Compare against the "Tag Functions" table in CLAUDE.md. Flag any that are defined but not documented, or documented but not defined.

**Pagetree:** Read `index.ptree` and compare against what CLAUDE.md says about which files are in the pagetree vs drafts.

**Metadata conventions:** Spot-check a few `.pm` files to verify they follow the metadata conventions described in CLAUDE.md (have `title`, use valid `section` values, etc.).

Report:
- **PASS** if CLAUDE.md matches reality
- **WARN** with specific drift items if mismatches found

### 6. Print summary report

Print a clean summary table:

```
=== Pollen Checkup Report ===

  Render:        PASS
  Links/Assets:  PASS
  Lighthouse:    92 / 98 / 100 / 91  (Perf / A11y / BP / SEO)
  Docs Drift:    WARN — 2 items

  Details: [list any warnings or failures below]
```

Use PASS/WARN/FAIL labels. Only show details for non-PASS items. Keep the output scannable.
