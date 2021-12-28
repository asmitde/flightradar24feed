#!/bin/sh

ARCH=armhf
REPO=https://repo-feed.flightradar24.com
CHANGELOG=CHANGELOG.md
CHANGELOG_URL=$REPO/$CHANGELOG

wget --spider $CHANGELOG_URL
if [ $? -eq 0 ]
then
    wget -q -O $CHANGELOG $CHANGELOG_URL
else
    echo "[ERROR] Changelog file not available at $CHANGELOG_URL"
    return 1
fi

VERSIONS=$(sed -nr 's/.*# \[(.*)\].*/\1/p' $CHANGELOG)

for ver in $VERSIONS
do
    BINARY=fr24feed_${ver}_${ARCH}.tgz
    BINARY_URL=$REPO/rpi_binaries/$BINARY

    wget --spider $BINARY_URL
    if [ $? -eq 0 ]
    then
        wget -q -O $BINARY $BINARY_URL
        break
    else
        echo "[ERROR] Binary version $ver not available at $BINARY_URL"
    fi
done

if [ -e $BINARY ]
then
    tar -xzvf $BINARY
    rm -v $BINARY $CHANGELOG ${0##*/}
else
    echo "[ERROR] No matching binary found"
    return 1
fi