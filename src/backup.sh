#!/bin/bash

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -e

# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
else
    echo ".env file not available in src/.env"
    exit 1
fi

CURRENT=`date +%d-%m-%Y"_"%H_%M_%S`
TEMP_DIRECTORY="${BACKUP_TEMP_DIRECTORY}/${CURRENT}"


echo "Making temporary backup to $TEMP_DIRECTORY"
# Making directory
mkdir -p "$TEMP_DIRECTORY"

echo "Backing up jira..."
#Backing up jira data
docker exec -t honeycomb_jira-postgresql_1 pg_dumpall -c -U "$JIRA_DB_USER" > "${TEMP_DIRECTORY}/jira_postgres.sql"

echo "Backing up confluence..."
#Backing up confluence data
docker exec -t honeycomb_confluence-postgresql_1 pg_dumpall -c -U "$CONFLUENCE_DB_USER" > "${TEMP_DIRECTORY}/confluence_postgres.sql"

echo "Backing up easyBI..."
#Backing up easyBI data
docker exec -t honeycomb_easyBI-postgresql_1 pg_dumpall -c -U "$EASYBI_DB_USER" > "${TEMP_DIRECTORY}/easyBI_postgres.sql"

#Creating symbolic link
ln -s "${DATA_DIRECTORY}/confluence" "${TEMP_DIRECTORY}/confluence"
ln -s "${DATA_DIRECTORY}/jira" "${TEMP_DIRECTORY}/jira"

echo "bundle and compress it"

cd "$BACKUP_TEMP_DIRECTORY"
tar -czhf "${BACKUP_SUB_DIRECTORY}/${CURRENT}".tar.gz "${CURRENT}"

echo "cleaning up ${TEMP_DIRECTORY}"
unlink "${TEMP_DIRECTORY}/jira"
unlink "${TEMP_DIRECTORY}/confluence"
rm -rf "${TEMP_DIRECTORY}"

echo "completed"
