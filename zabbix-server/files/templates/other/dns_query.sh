#!/usr/bin/bash

RESPONSE=`/usr/bin/dig @8.8.8.8 ciscorf.ru A | grep 185.127.24.110`

if [ -z "$RESPONSE" ];
then
    echo 0
else
    echo 1
fi