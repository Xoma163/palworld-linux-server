# Palworld linux server with manual updates and auto backups

## Pre-requisites

- Ubuntu 22.04

## Installing

```bash
# Install steamcmd
sudo apt update && apt dist-upgrade
sudo apt install software-properties-common && apt-add-repository main universe restricted multiverse && dpkg --add-architecture i386 && apt update && apt install steamcmd

# Install rcon-cli
sudo wget -P /tmp https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
tar –xvzf rcon-0.10.3-amd64_linux.tar.gz –C /home/user/destination

# Add user palworld
sudo adduser palworld
sudo mkdir /opt/palworld
sudo chown palworld:palworld /opt/palworld

# Get configs
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/palworld.service
sudo systemctl daemon-reload

su - palworld

# Get update script
wget -P /opt/palworld https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/update_server.sh
chmod + x /opt/palworld/update_server.sh

# Get backup script. Edit it
wget -P /opt/palworld https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/backup_server.sh
chmod + x /opt/palworld/backup_server.sh

# Get rcon config. Edit it
wget -P /opt/palworld https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/.rcon-cli.yaml

# Install crontab file
wget -P /opt/palworld https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/crontab.txt
crontab /opt/palworld/crontab.txt

# Pull server
cd /opt/palworld/update_server.sh

# Dry run server
cd /opt/palworld/server && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS

# Copy settings. Edit it
wget -P /opt/palworld/server/Pal/Saved/Config https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/PalWorldSettings.ini

# Start server
sudo systemctl start palworld
```

## FAQ

### Stop/start/restart server

```bash
sudo systemctl start palworld
sudo systemctl stop palworld
sudo systemctl restart palworld
```

Server will stop gracefully with RCON commands and notify players. Edit timings
in `/etc/systemd/system/palworld.service`

### Make backup

```bash
/opt/palworld/backup_server.sh
```

### Restore backup

- Untar archive and put in to `/opt/palworld/server/Pal/Saved` folder

### How to edit config?

```bash
sudo systemctl stop palworld

# Edit config

sudo systemctl start palworld
```

### Update server

```bash
sudo systemctl stop palworld

/opt/palworld/update_server.sh

sudo systemctl start palworld
```

### Do systemctl commands without password

```bash
sudo wget -P /etc/sudoers.d https://raw.githubusercontent.com/Xoma163/palworld-linux-server/master/palworld
chmod 600 /etc/sudoers.d/palworld
# Start new ssh session
```

## Troubleshooting

### steamcmd has been disconnected from steam with result 3

- Try to use VPN

### steamclient.so: cannot open shared object file: No such file or directory

- Ignore it

### [S_API FAIL]

- Ignore it


## Useful links

[HowTo-Palworld github](https://github.com/A1RM4X/HowTo-Palworld)

[Official guide](https://tech.palworldgame.com/dedicated-server-guide#linux)

[Server settings](https://help.dathost.net/article/150-palworld-how-to-edit-server-settings)

[Pretty server configuration generator](https://pal-conf.bluefissure.com/)

---

[Pal calculator](https://palworld.gg/breeding-calculator)

[Interactive map](https://mapgenie.io/palworld/maps/palpagos-islands)

[Pals wiki](https://game8.co/games/Palworld/archives/439556)

## Useful info

### RCON Commands

```bash
rcon-cli --config /opt/palworld/.rcon-cli.yaml "<COMMAND>"
```

- /Save
- /ShowPlayers
- /KickPlayer {SteamID}
- /BanPlayer {SteamID}
- /TeleportToPlayer {SteamID}
- /TeleportToMe {SteamID}
- /Broadcast {MessageText}
- /Info 