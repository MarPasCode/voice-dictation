#!/bin/bash
# Registers a LaunchAgent that silently starts the voice dictation server on every macOS login.
# Usage: ./install.sh              (port from config.json, defaults to 7778)
#        ./install.sh --port 8081  (saves a custom port to config.json)

set -e

# Folder this script lives in — used to locate config.json, server.js, and to write logs.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PORT=""
if [ "$1" == "--port" ] && [ -n "$2" ]; then
  PORT="$2"
fi

# If a custom port was passed, persist it to config.json so server.js picks it up.
if [ -n "$PORT" ]; then
  printf '{\n  "port": %s\n}\n' "$PORT" > "$SCRIPT_DIR/config.json"
  echo "Port set to $PORT in config.json"
fi

# launchd doesn't inherit the shell's PATH, so we need node's full path up front.
NODE_PATH="$(command -v node || true)"
if [ -z "$NODE_PATH" ]; then
  echo "Error: Node.js not found. Install it from https://nodejs.org, then run this script again."
  exit 1
fi

PLIST_LABEL="com.voicedictation.server"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_LABEL.plist"
LOG_PATH="$SCRIPT_DIR/voicedictation.log"

mkdir -p "$HOME/Library/LaunchAgents"

# Write a LaunchAgent definition: runs `node server.js` at every login, with no visible window.
cat > "$PLIST_PATH" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${PLIST_LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        <string>${NODE_PATH}</string>
        <string>${SCRIPT_DIR}/server.js</string>
    </array>
    <key>WorkingDirectory</key>
    <string>${SCRIPT_DIR}</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
    <key>StandardOutPath</key>
    <string>${LOG_PATH}</string>
    <key>StandardErrorPath</key>
    <string>${LOG_PATH}</string>
</dict>
</plist>
EOF

echo "Autostart registered: $PLIST_PATH"
echo "The server will start silently on every macOS login."

# Reload the LaunchAgent now so the server starts immediately, without logging out and back in.
launchctl unload "$PLIST_PATH" 2>/dev/null || true
launchctl load "$PLIST_PATH"

sleep 1
echo "Server started now. To remove autostart, run: launchctl unload $PLIST_PATH && rm $PLIST_PATH"
