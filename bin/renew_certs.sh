#!/bin/bash

echo "[i]Renew cert ..."
result=$(certbot renew)
#echo $result
result=$(echo $result | grep "Certificate not yet due for renewal")
if [ -z "$result" ]; then
    sleep 5s
    echo "[i]Restart nginx ..."
    systemctl restart nginx
else
    echo "[i]Skiped because that certificate not yet due for renewal."
fi
