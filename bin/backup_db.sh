#!/bin/bash

curDir=$(pwd)
targetDir=/home/webmanager/www/book/bak/db
sqlFile=novel_plus_$(date +%Y%m%d).sql
zipFile=novel_plus_$(date +%Y%m%d).tar.xz
startTime=$(date +%s)

if [ ! -d "$targetDir" ]; then
    echo "[i]Creating directory: $targetDir ..."
    mkdir -p $targetDir
fi
cd $targetDir

if [ ! -f "$sqlFile" ]; then
    echo "[i]Backup data to $sqlFile"
    docker exec -it novel-db mysqldump -h localhost -pDemo_20250808 novel_plus > $sqlFile
fi

if [ ! -f "$zipFile" ]; then
    echo "[i]Compress to $zipFile"
    tar cvJf $zipFile $sqlFile
fi

rm -f $sqlFile
cd $curDir

usedTime=$(expr `date +%s` - $startTime)
printf -v usedTimeFmt "%02d:%02d:%02d" $(expr $usedTime / 3600) $(expr $usedTime % 3600 / 60) $(expr $usedTime % 60)
echo "[i]Finished. Used time: $usedTimeFmt"
