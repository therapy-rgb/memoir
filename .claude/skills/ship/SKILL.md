# Ship to Production

Commit all changes, push to main, and deploy to GitHub Pages. Stop immediately if any step fails.

## Steps

### 1. Validate rendering
**Important:** Always render from inside the project directory (not with full paths from outside). Pollen sets `here` based on the working directory — using full paths breaks pagetree navigation.
```bash
cd /Users/marcusberley/Documents/Projects/memoir && raco pollen reset && raco pollen render
```
If rendering fails, fix the errors before continuing.

### 2. Commit
- Stage all relevant changed files (do not stage rendered `.html` output files, `.env*`, or credentials).
- Force-add template files (`template-title.html`, `template-poems.html`) if they're gitignored.
- Write a concise commit message. If argument was provided, use it as the message. Otherwise auto-generate from the diff.
- Include `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>` in the commit.

### 3. Push
```bash
git -C /Users/marcusberley/Documents/Projects/memoir push origin main
```
Confirm the push succeeded and display the commit hash.

### 4. Deploy to GitHub Pages
```bash
rm -rf /tmp/memoir-publish
raco pollen publish /Users/marcusberley/Documents/Projects/memoir /tmp/memoir-publish
```
Clean the publish output — remove non-site files and stray assets that aren't part of the site:
```bash
rm -rf /tmp/memoir-publish/.claude /tmp/memoir-publish/.github /tmp/memoir-publish/.playwright-mcp /tmp/memoir-publish/CLAUDE.md /tmp/memoir-publish/README.md /tmp/memoir-publish/template.html /tmp/memoir-publish/template-poems.html /tmp/memoir-publish/template-title.html /tmp/memoir-publish/puttering.html
# Remove any stray screenshots/PNGs in the root (but keep favicon PNGs)
command find /tmp/memoir-publish -maxdepth 1 -name '*.png' ! -name 'apple-touch-icon.png' ! -name 'favicon-32x32.png' -delete
```
Switch to `gh-pages`, replace all files, commit, and force push:
```bash
git -C /Users/marcusberley/Documents/Projects/memoir checkout gh-pages
git -C /Users/marcusberley/Documents/Projects/memoir rm -rf .
```
Copy published files into the repo, restore CNAME, and add `.nojekyll`:
```bash
cp -R /tmp/memoir-publish/* /Users/marcusberley/Documents/Projects/memoir/
cp -R /tmp/memoir-publish/fonts /Users/marcusberley/Documents/Projects/memoir/
cp -R /tmp/memoir-publish/images /Users/marcusberley/Documents/Projects/memoir/
echo "methodology.pub" > /Users/marcusberley/Documents/Projects/memoir/CNAME
touch /Users/marcusberley/Documents/Projects/memoir/.nojekyll
```
Stage all site files by name, then commit and **force push**:
```bash
git -C /Users/marcusberley/Documents/Projects/memoir add <list each file explicitly, including .nojekyll>
git -C /Users/marcusberley/Documents/Projects/memoir commit -m "Deploy site"
git -C /Users/marcusberley/Documents/Projects/memoir push --force origin gh-pages
```
**Why force push?** The `gh-pages` branch is a throwaway deployment artifact — each deploy replaces the entire site. The remote can diverge between deploys (e.g., from GitHub Actions or concurrent deploys), causing normal push to be rejected. Force push is safe here because there's no meaningful history to preserve.

Switch back to main:
```bash
git -C /Users/marcusberley/Documents/Projects/memoir checkout main
```

### 5. Document significant changes
If the shipped changes affect project conventions, structure, or workflow (e.g., new tag functions, template changes, new fonts, changed metadata conventions), update `CLAUDE.md` to reflect them. Skip this step for pure content or minor styling tweaks.

### 6. Summary
Report what was shipped: commit hash, files changed, and confirm GitHub Pages deploy was pushed.
Site URL: https://methodology.pub
