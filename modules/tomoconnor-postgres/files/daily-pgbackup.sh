#!/bin/bash
#daily psql backup script
set -u
set -e

dumpdir=/var/backups/postgresql
dow=$(date +%w)
weeknum=$(date +%U)
date=$(date +"%Y-%m-%d")
mkdir -p $dumpdir
dailydir=$dumpdir/daily/$dow
weeklydir=$dumpdir/weekly/$weeknum
mkdir -p $dailydir
mkdir -p $weeklydir
find $dumpdir -name "*.sql" -mtime +10 -exec rm {} \; 
for database in $(su - postgres -c "psql -l -t" | cut -d'|' -f 1 | grep -v template0); 
do 
        su - postgres -c "pg_dump $database" |bzip2 > $dailydir/$database.sql.bz2; 
done

su - postgres -c "pg_dumpall -g"|bzip2 > $dailydir/global.sql.bz2

