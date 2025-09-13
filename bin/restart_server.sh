#!/bin/bash

targetDir="/home/webmanager/www/book"

target=$(cat $targetDir/restart_target.txt);
if [ "$target" = "all" ]; then
    echo "Restart $target ..."
    docker compose restart
elif [ -n "$target" ]; then
    echo "Restart $target ..."
    docker compose restart $target
fi

if [ -n "$target" ]; then
    echo -n "" > $targetDir/restart_target.txt
fi
