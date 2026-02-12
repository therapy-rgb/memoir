# Ship to Production

Commit all changes, push to main, and deploy to GitHub Pages. Stop immediately if any step fails.

## Steps

### 1. Validate rendering
**Important:** Always render from inside the project directory (not with full paths from outside). Pollen sets `here` based on the working directory — using full paths breaks pagetree navigation.
```bash
export PATH="/Applications/Racket v9.0/bin:$PATH"
builtin cd /Users/marcusberley/Documents/Projects/memoir && raco pollen reset && raco pollen render
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
export PATH="/Applications/Racket v9.0/bin:$PATH"
rm -rf /tmp/memoir-publish
raco pollen publish /Users/marcusberley/Documents/Projects/memoir /tmp/memoir-publish
```
Clean the publish output — remove non-site files:
```bash
rm -rf /tmp/memoir-publish/.claude /tmp/memoir-publish/CLAUDE.md /tmp/memoir-publish/template.html /tmp/memoir-publish/template-poems.html /tmp/memoir-publish/template-title.html /tmp/memoir-publish/puttering.html
```
Switch to `gh-pages`, replace all files, commit, and push:
```bash
git -C /Users/marcusberley/Documents/Projects/memoir checkout gh-pages
git -C /Users/marcusberley/Documents/Projects/memoir rm -rf .
```
Copy published files into the repo and stage them explicitly (do not use `git add -A`):
```bash
cp -R /tmp/memoir-publish/* /Users/marcusberley/Documents/Projects/memoir/
cp -R /tmp/memoir-publish/fonts /tmp/memoir-publish/images /Users/marcusberley/Documents/Projects/memoir/
```
Stage all `.html`, `.css`, `fonts/`, and `images/` files by name, then commit and push:
```bash
git -C /Users/marcusberley/Documents/Projects/memoir add <list each file explicitly>
git -C /Users/marcusberley/Documents/Projects/memoir commit -m "Deploy site"
git -C /Users/marcusberley/Documents/Projects/memoir push origin gh-pages
```
Switch back to main:
```bash
git -C /Users/marcusberley/Documents/Projects/memoir checkout main
```

### 5. Summary
Report what was shipped: commit hash, files changed, and confirm GitHub Pages deploy was pushed.
Site URL: https://therapy-rgb.github.io/memoir/
