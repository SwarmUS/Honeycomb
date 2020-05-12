#! /bin/sh

DELETE=${1:-not-all}

helpFunction()
{
   echo ""
   echo "Usage: $0 -a parameterA -b parameterB -c parameterC"
   echo -e "\t-a Delete all this includes the data directory at /usr/lib/honeycomb. Default is false "
   exit 1 # Exit script after printing help
}

#Programm directory
rm -rf /usr/local/bin/honeycomb

#Data directory
if [ "$DELETE" = "all" ]
then
    echo "Deleting all"
    rm -rf /usr/local/lib/honeycomb
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