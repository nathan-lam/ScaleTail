#!/bin/bash

#TODO: created by LLM, needs to be verified

# Define your absolute paths
UPLOAD_LOCATION="/srv/immich/data"
BACKUP_DIR="/srv/immich/backups"

# Ensure backup directory exists
mkdir -p "$UPLOAD_LOCATION/database-backup"
mkdir -p "$BACKUP_DIR"

# 1. Dump the Immich PostgreSQL database
docker exec -t immich_postgres pg_dumpall --username=postgres | gzip > "$UPLOAD_LOCATION/database-backup/immich-database.sql.gz"

# 2. Sync or archive your files (Example using rsync or Borg/Restic)
# This example archives the vital paths, excluding heavy cache/thumbs
rsync -av --delete \
  --exclude 'thumbs/' \
  --exclude 'encoded-video/' \
  "$UPLOAD_LOCATION/" "$BACKUP_DIR/current_data/"

echo "Immich backup completed successfully!"