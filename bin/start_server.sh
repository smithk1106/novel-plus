#!/bin/sh

jarFile="$1"
if [ -z "$jarFile" ]; then
    echo "Usage: $0 jarFile"
    exit 101
fi

java -cp bin/ ReplaceEnv config/shardingsphere-jdbc.yml
java -Dspring.profiles.active=$PROFILE -jar $jarFile
