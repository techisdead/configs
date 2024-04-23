#!/bin/sh

PCKG=${1}
URL=${2}

wget $URL -O ${PCKG}.deb
gdebi ${PCKG}.deb
