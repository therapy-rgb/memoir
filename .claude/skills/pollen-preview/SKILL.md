# Preview

Start the Pollen dev server and open the site in the browser.

## Steps

### 1. Kill any existing Pollen server
```bash
pkill -f "raco pollen start" 2>/dev/null || true
```

### 2. Start the dev server in the background
```bash
builtin cd /Users/marcusberley/Documents/Projects/memoir && raco pollen start &
```

### 3. Wait for the server to be ready
Wait up to 10 seconds for port 8080 to respond:
```bash
for i in $(seq 1 20); do curl -s http://localhost:8080 > /dev/null && break || sleep 0.5; done
```

### 4. Open the browser
```bash
open http://localhost:8080/title.html
```

### 5. Confirm
Tell the user the server is running at http://localhost:8080 and the browser should be open. Remind them:
- The dashboard is at http://localhost:8080/index.ptree
- First page load may be slow (Pollen renders on demand)
- To stop the server: `pkill -f "raco pollen start"`
