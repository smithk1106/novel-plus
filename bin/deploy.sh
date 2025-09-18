#!/bin/bash

projectDir="/Users/webstory/Websites/wdllstudio.com/book/src_xxy"
remoteServer="book_server"
remoteDir="~/www/book"

site="$1"

if [ -z "$site" ]; then
    echo "Usage: $0 all|front|admin|crawler2|docker"
    exit 101
fi

# Delete all ".DS_Store" files
find $projectDir/docker -maxdepth 5 -name ".DS_Store" -exec rm {} \;

if [ "$site" = "all" ] || [ "$site" = "front" ]; then
    scp "$projectDir/docker/front/novel-front.jar" $remoteServer:$remoteDir/docker/front/
    scp -r "$projectDir/docker/front/config" $remoteServer:$remoteDir/docker/front/
    scp -r "$projectDir/docker/front/bin" $remoteServer:$remoteDir/docker/front/
    ssh $remoteServer "cd $remoteDir/docker/front/templates; git pull"
    ssh $remoteServer "chmod +x $remoteDir/docker/front/bin/*.sh"
fi

if [ "$site" = "all" ] || [ "$site" = "admin" ]; then
    scp "$projectDir/docker/admin/novel-admin.jar" $remoteServer:$remoteDir/docker/admin/
    scp -r "$projectDir/docker/admin/config" $remoteServer:$remoteDir/docker/admin/
    scp -r "$projectDir/docker/admin/bin" $remoteServer:$remoteDir/docker/admin/
    ssh $remoteServer "chmod +x $remoteDir/docker/admin/bin/*.sh"
fi

if [ "$site" = "all" ] || [ "$site" = "crawler2" ]; then
    scp "$projectDir/docker/crawl2/novel-crawl2.jar" $remoteServer:$remoteDir/docker/crawl2/
    scp -r "$projectDir/docker/crawl2/rule" $remoteServer:$remoteDir/docker/crawl2/
fi

if [ "$site" = "all" ] || [ "$site" = "docker" ]; then
    scp "$projectDir/docker-compose_prod.yml" $remoteServer:$remoteDir/docker-compose.yml
    scp "$projectDir/.env_prod" $remoteServer:$remoteDir/.env
fi

if [ ! "$site" = "docker" ]; then
    ssh $remoteServer "echo -n $site > $remoteDir/restart_target.txt"
fi

#scp "~/Websites/wdllstudio.com/book/src_xxy/bak/db/novel_plus_20250906.sql" book_server:"~/www/book/share/novel_plus.sql"
#scp -r "/Users/webstory/Websites/wdllstudio.com/book/src_xxy/docker/download/pic/localPic" book_server:"~/www/book/download/pic/"
