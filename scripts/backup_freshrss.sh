#!/bin/bash
# Configuration

DATA_DIR="/home/user_name/DATAHOARD/99 Meta/Backups" # Your host volume path
DATE=$(date +%Y%m%d)
USER="XC1ggvZrNTAnegx"

# Export OPML and then send it to ssh destination
docker exec -u www-data app-freshrss php cli/export-opml-for-user.php --user "$USER" | ssh user_name@bazzite "cat > \"$DATA_DIR/freshrss_${USER}_${DATE}_export.opml\""