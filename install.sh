#! /bin/bash

# Local .env
if [ -f ./src/.env ]; then
    # Load Environment Variables
    export $(cat ./src/.env | grep -v '#' | awk '/=/ {print $1}')
else
    echo ".env file not available in src/.env"
    exit 1
fi

#Programm directory
mkdir "$BIN_DIRECTORY"
cp -R ./src/. "$BIN_DIRECTORY"

#Data directory
mkdir "$DATA_DIRECTORY"

#systemd 
cp honeycomb.service /etc/systemd/system/honeycomb.service
chmod 644 /etc/systemd/system/honeycomb.service
systemctl enable honeycomb
systemctl start honeycomb