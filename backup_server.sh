#!/bin/sh

# /mnt/nas/backups for example
BACKUP_DIR=<YOUR_DIR>

dt=$(date +"%Y.%m.%d_%H-%M-%S")
echo $dt

rcon-cli --config /opt/palworld/.rcon-cli.yaml "broadcast SERVER_AUTO_BACKUP_START"

tar -cvpzf $BACKUP_DIR/palworld_$dt.tar.gz /opt/palworld/server/Pal/Saved
# Delete older backups
find $BACKUP_DIR -type f -mtime +7 -name '*.gz' -delete


rcon-cli --config /opt/palworld/.rcon-cli.yaml "broadcast SERVER_AUTO_BACKUP_FINISH"
