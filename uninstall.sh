#! /bin/sh

DELETE=${1:-not-all}

# Local .env
if [ -f ./src/.env ]; then
    # Load Environment Variables
    export $(cat ./src/.env | grep -v '#' | awk '/=/ {print $1}')
else
    echo ".env file not available in src/.env"
    exit 1
fi


#Programm directory
rm -rf /usr/local/bin/honeycomb

#Data directory
if [ "$DELETE" = "all" ]
then
    echo "Deleting all"
    rm -rf "$DATA_DIRECTORY"
fi

#systemd 
systemctl stop honeycomb
systemctl disable honeycomb
rm /etc/systemd/system/honeycomb.service
rm /etc/systemd/system/honeycomb.service # and symlinks that might be related
rm /usr/lib/systemd/system/honeycomb.service 
rm /usr/lib/systemd/system/honeycomb.service # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed