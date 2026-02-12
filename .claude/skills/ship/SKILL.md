# Ship to Production

Commit all changes and push to main. Stop immediately if any step fails.

## Steps

### 1. Validate rendering
```bash
export PATH="/Applications/Racket v9.0/bin:$PATH"
raco pollen render /Users/marcusberley/Documents/Projects/memoir
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

### 4. Summary
Report what was shipped: commit hash and files changed.
