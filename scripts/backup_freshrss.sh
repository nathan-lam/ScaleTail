#!/bin/bash
# Configuration
BACKUP_DIR="/path/to/your/backup/folder"
DATA_DIR="/path/to/freshrss/data" # Your host volume path
DATE=$(date +%Y%m%d_%H%M%S)

# Create archive of the config/data directory
tar -zcf "$BACKUP_DIR/backup_freshrss_$DATE.tar.gz" -C "$(dirname "$DATA_DIR")" "$(basename "$DATA_DIR")"

# Optional: Keep only the last 7 days of backups
find "$BACKUP_DIR" -name "freshrss_backup_*.tar.gz" -mtime +7 -exec rm {} \;