# Preview

Start the Pollen dev server and open the site in the browser.

## Steps

### 1. Kill any existing server and free port 8080
`pkill` is unreliable for Racket processes. Use `lsof` to find and force-kill whatever's on port 8080:
```bash
kill -9 $(lsof -ti:8080) 2>/dev/null || true
```

### 2. Verify port is free
```bash
sleep 1 && lsof -ti:8080 2>/dev/null && echo "PORT STILL IN USE" || echo "PORT FREE"
```
If the port is still in use, repeat step 1. Do not proceed until the port is free.

### 3. Start the dev server
Run this using `run_in_background: true` — do NOT add `&` to the command. The background task will stay alive as long as the server runs. Do not check on or read the background task output — it will remain running for the whole session.
```bash
raco pollen start
```

### 4. Wait for the server to be ready
Wait up to 10 seconds for port 8080 to respond:
```bash
for i in $(seq 1 20); do curl -s http://localhost:8080 > /dev/null 2>&1 && echo "SERVER READY" && break || sleep 0.5; done
```

### 5. Open the browser
```bash
open http://localhost:8080/title.html
```

### 6. Confirm
Tell the user the server is running at http://localhost:8080 and the browser should be open. Remind them:
- The dashboard is at http://localhost:8080/index.ptree
- First page load may be slow (Pollen renders on demand)
- To stop the server: `kill -9 $(lsof -ti:8080)`
