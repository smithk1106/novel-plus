#!/bin/bash

curDir=$(pwd)
baseDir=/home/webmanager/www/book
logFile=$baseDir/bin/backup_db.log
targetDir=$baseDir/bak/db
sqlFile=novel_plus_$(date +%Y%m%d).sql
zipFile=novel_plus_$(date +%Y%m%d).tar.xz
startTime=$(date +%s)

if [ ! -d "$targetDir" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [i]Creating directory: $targetDir ..." >> $logFile
    mkdir -p $targetDir
fi
cd $targetDir

if [ ! -f "$sqlFile" ]; then
    cd $baseDir
    echo "$(date '+%Y-%m-%d %H:%M:%S') [i]Backup data to $sqlFile" >> $logFile
    docker exec -it novel-db mysqldump -h localhost -pDemo_20250808 novel_plus > $targetDir/$sqlFile
fi

cd $targetDir
if [ ! -f "$zipFile" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [i]Compress to $zipFile" >> $logFile
    tar cvJf $zipFile $sqlFile
fi

chown webmanager:webmanager $zipFile

rm -f $sqlFile
cd $curDir

usedTime=$(expr `date +%s` - $startTime)
printf -v usedTimeFmt "%02d:%02d:%02d" $(expr $usedTime / 3600) $(expr $usedTime % 3600 / 60) $(expr $usedTime % 60)
echo "$(date '+%Y-%m-%d %H:%M:%S') [i]Finished. Used time: $usedTimeFmt" >> $logFile
