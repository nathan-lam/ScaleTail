#!/bin/bash

# --- CONFIGURATION ---
# Path to your Vaultwarden data directory on the host machine
VW_DATA_DIR="/path/to/your/vaultwarden/data"

# Directory where backups will be stored
BACKUP_DIR="/path/to/your/backup/destination"

# Retention policy: Number of days to keep old backups
RETENTION_DAYS=7

# Date format for the backup filename
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="vaultwarden_backup_$DATE.tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# --- EXECUTION ---

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting Vaultwarden backup..."

# Optional: If you use SQLite, you can make a safe online backup using sqlite3 to prevent corruption, 
# though stopping the container or tarring the directory usually works fine if idle.
# (If using PostgreSQL/MySQL, use pg_dump/mysqldump instead).

# Create a compressed tarball of the data directory
tar -czf "$BACKUP_PATH" -C "$(dirname "$VW_DATA_DIR")" "$(basename "$VW_DATA_DIR")"

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup successfully created: $BACKUP_NAME"
else
    echo "[$(date)] ERROR: Backup failed!" >&2
    exit 1
fi

# Remove backups older than the retention period
echo "[$(date)] Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "vaultwarden_backup_*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete

echo "[$(date)] Backup process completed."