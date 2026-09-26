#!/bin/bash

# Invidious is recommended to restart at least daily https://docs.invidious.io/installation/#highly-recommended

# --- CONFIGURATION ---
# Set the absolute path to the directory containing your docker-compose.yml
COMPOSE_DIR="~/PROJECTS/ScaleTail/services/invidious"

# Log file path
LOG_FILE="~/PROJECTS/ScailTail/logs/invidious-restart.log"
# ---------------------

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Invidious daily restart..." >> "$LOG_FILE"

# Navigate to the compose directory
cd "$COMPOSE_DIR" || {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Could not find directory $COMPOSE_DIR" >> "$LOG_FILE"
    exit 1
}

# Restart the containers defined in docker-compose.yml
# You can use 'restart' or 'down' followed by 'up -d' if a fresh start is preferred
docker compose restart >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] SUCCESS: Invidious restarted successfully." >> "$LOG_FILE"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Failed to restart Invidious." >> "$LOG_FILE"
fi