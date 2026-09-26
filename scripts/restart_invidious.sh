#!/bin/bash

# Invidious is recommended to restart at least daily https://docs.invidious.io/installation/#highly-recommended

# --- CONFIGURATION ---
# Set the absolute path to the directory containing your docker-compose.yml
COMPOSE_DIR="$HOME/PROJECTS/ScaleTail/services/invidious"
LOG_DIR="$HOME/PROJECTS/ScaleTail/logs"
LOG_FILE="$LOG_DIR/invidious-restart.log"
# ---------------------

mkdir -p "$LOG_DIR"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Invidious daily restart..." >> "$LOG_FILE"


# Keep the log file under 1MB by clearing it if it gets too large
MAX_SIZE=$((1024 * 1024)) # 1MB in bytes
if [ -f "$LOG_FILE" ] && [ $(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE" 2>/dev/null) -gt $MAX_SIZE ]; then
    tail -n 50 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
fi


# Navigate to the compose directory
cd "$COMPOSE_DIR" || {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Could not find directory $COMPOSE_DIR" >> "$LOG_FILE"
    exit 1
}

# Restart the containers
docker compose down >> "$LOG_FILE" 2>&1
sleep 3
docker compose up -d >> "$LOG_FILE" 2>&1


if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] SUCCESS: Invidious restarted successfully." >> "$LOG_FILE"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Failed to restart Invidious." >> "$LOG_FILE"
fi
