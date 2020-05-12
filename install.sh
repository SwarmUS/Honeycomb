#! /bin/sh

#Programm directory
mkdir /usr/local/bin/honeycomb
cp -R ./src/. /usr/local/bin/honeycomb

#Data directory
mkdir /usr/local/lib/honeycomb

#systemd 
cp honeycomb.service /etc/systemd/system/honeycomb.service
chmod 644 /etc/systemd/system/honeycomb.service
systemctl enable honeycomb
systemctl start honeycomb