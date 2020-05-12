# Honeycomb
Honeycomb is the repository for the tooling infrastructure of SwarmUS


## Requirements
Honeycomb requires docker and docker compose to be installed.

## Usage 
Most usage will be to install and uninstall the services. Just use the associated scripts.

`sudo ./install.sh`


`sudo ./uninstall.sh`


Uninstall can take `all` as parameter if you want to remove postgres persistant storage

`sudo ./uninstall.sh all`

Modify the .env in /src/.env as needed
