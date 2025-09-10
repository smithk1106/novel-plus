#!/bin/bash

projectDir="/Users/webstory/Websites/wdllstudio.com/book/src_xxy"
remoteServer="webmanager@133.130.66.33"
remoteDir="~/www/book"

site="$1"
isAll="$2"

if [ -z "$site" ] || [ "$site" = "front" ]; then
    scp "$projectDir/novel-front/target/build/novel-front.jar" book_server:$remoteDir/front/
    scp -r "$projectDir/novel-front/target/build/config" book_server:$remoteDir/front/
    ssh book_server "cd $remoteDir/front/templates; git pull"
    if [ "$isAll" = "all" ]; then
        scp -r "$projectDir/templates" book_server:$remoteDir/front/
    fi
fi

if [ -z "$site" ] || [ "$site" = "admin" ]; then
    scp "$projectDir/novel-admin/target/build/novel-admin.jar" book_server:$remoteDir/admin/
    scp -r "$projectDir/novel-admin/target/build/config" book_server:$remoteDir/admin/
fi

if [ -z "$site" ] || [ "$site" = "crawl" ]; then
    scp "$projectDir/novel-crawl2/target/novel-crawl2.jar" book_server:$remoteDir/crawl2/
    scp -r "$projectDir/novel-crawl2/target/rule" book_server:$remoteDir/crawl2/
fi

if [ -z "$site" ] || [ "$site" = "docker" ]; then
    scp "$projectDir/docker-compose_prod.yml" book_server:$remoteDir/docker-compose.yml
    scp "$projectDir/.env" book_server:$remoteDir/
fi

#scp "~/Websites/wdllstudio.com/book/src_xxy/bak/db/novel_plus_20250906.sql" book_server:"~/www/book/share/novel_plus.sql"
#scp -r "/Users/webstory/Websites/wdllstudio.com/book/src_xxy/docker/download/pic/localPic" book_server:"~/www/book/download/pic/"
