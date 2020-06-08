# Honeycomb
Honeycomb is the repository for the tooling infrastructure of SwarmUS


## Requirements
Honeycomb requires docker and docker compose to be installed.

## Setup

### Config

Before installation you need to do some setup for backup configuration.

Modify the env file accordingly, then create the folder tree conresponding to your backup folder on your onedrive. If you drop the files direcly in the root, it will do the same on the onedrive.

The backup dir needs to be owned by the user

Run the following command:

```
docker run -it --name onedrive_temp -v YOUR_DATA_DIR:/onedrive/conf -v "YOUR_BACKUP_DIR:/onedrive/data" driveone/onedrive:alpine-202005291951
```

Follow through the setup for the account.
[For more information check here](https://github.com/abraunegg/onedrive)

And get your drive id before proceeding

Then copy the file from `src/config/onedrive/config` and put it in your volume you've just created by inspecting the container and pasting it at the path
You need to get your driveID and change it in `src/config/onedrive/config`



`docker volume inspect onedrive_swarmus`

Change your drive id in the config file

### Backups

You can then setup a crontab for daily backup with the backup.sh script. Point to the installed script, not the cloned one.

## Usage 
Most usage will be to install and uninstall the services. Just use the associated scripts.


`sudo ./install.sh`


`sudo ./uninstall.sh`


Uninstall can take `all` as parameter if you want to remove postgres persistant storage

`sudo ./uninstall.sh all`

Modify the .env in /src/.env as needed
