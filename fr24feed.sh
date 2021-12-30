#!/bin/bash

# Run this optionally with param signup: e.g., ./fr24feed.sh signup

LOGPATH=/mnt/usbnas0/appdata/fr24feed/log
CONFIGDIR=/mnt/usbnas0/appdata/fr24feed/config

IMAGE=fr24feed:latest
CONTAINER=fr24feed
NETWORK=adsb-net

# Stop and remove running readsb containers
docker stop $(docker ps -f name=$CONTAINER -q)
docker rm $(docker ps -f name=$CONTAINER -f status=exited -q)

# Create a network to receice adsb data from sdrs
[[ -z $(docker network ls -f name=$NETWORK -q) ]] && docker network create $NETWORK

# Run the container
case $1 in
  signup)
    docker run \
      -it \
      --rm \
      --name $CONTAINER \
      $IMAGE \
      --signup
  ;;
  *)
    docker run \
      -d \
      --restart on-failure:5 \
      --name $CONTAINER \
      --hostname $CONTAINER-client \
      --network $NETWORK \
      -p 8754:8754 \
      -v $CONFIGDIR:/app/config \
      -v $LOGPATH:/var/log/fr24feed \
      $IMAGE
esac
