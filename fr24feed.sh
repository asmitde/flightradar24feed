#!/bin/sh

LOGPATH=/mnt/usbnas0/appdata/fr24feed/log
CONFIGDIR=/mnt/usbnas0/appdata/fr24feed/config
CONFIGFILE=fr24feed.ini
IMAGE=fr24feed:test
CONTAINER=fr24feed

# Stop and remove running readsb containers
docker stop $CONTAINER
docker rm $CONTAINER

docker run \
 -d \
 --name $CONTAINER \
 --hostname $CONTAINER \
 -p 8754:8754 \
 -v $CONFIGDIR:/app/fr24feed_armhf/config
 -v $LOGPATH:/var/log/fr24feed \
 $IMAGE
