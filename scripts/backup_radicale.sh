#!/bin/bash

# Configuration
RADICALE_DIR="/var/lib/radicale/collections" # Adjust to your storage path
BACKUP_DIR="/var/backups/radicale"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/radicale-backup-$DATE.tar.gz"
KEEP_DAYS=7 # Number of days to keep backups

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Create archive
echo "Backing up Radicale collections..."
tar -czf "$BACKUP_FILE" -C "$(dirname "$RADICALE_DIR")" "$(basename "$RADICALE_DIR")"

if [ $? -eq 0 ]; then
    echo "Backup successfully created: $BACKUP_FILE"
else
    echo "Backup failed!" >&2
    exit 1
fi

# Optional: Delete backups older than $KEEP_DAYS
find "$BACKUP_DIR" -name "radicale-backup-*.tar.gz" -mtime +$KEEP_DAYS -delete
echo "Cleaned up backups older than $KEEP_DAYS days."