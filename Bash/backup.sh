#!/bin/bash
DIR_BACKUP_LOCATION="/backup"
PATH_BACKUP="/services"
DIR_BACKUP=('adhoc.*' 'adhoc-api.*')
BACKUP_ARCHIVE=$(date '+%F')
DB_BACKUP="fraktus-live"
DB_SERVICE="postgresql"

backupDir() {
cd $PATH_BACKUP
for var in ${DIR_BACKUP[@]}
do
 tar -cf $var-$BACKUP_ARCHIVE.tar $var
 mv $var-$BACKUP_ARCHIVE.* $DIR_BACKUP_LOCATION
done
}

bakupDB() {
 if [[ "$DB_SERVICE" == "postgresql" ]]; then
         cd $DIR_BACKUP_LOCATION
         pg_dump $DB_BACKUP > $DB_BACKUP-$BACKUP_ARCHIVE.dump
 else
         echo "Database service do not exist"
 fi
}

backupDir
bakupDB