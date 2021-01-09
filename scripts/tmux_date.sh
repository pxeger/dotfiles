#!/bin/sh

# ordinal numbers
day=$(date +%d)
case $day in
    *1) suffix=st;;
    *2) suffix=nd;;
    *3) suffix=rd;;
    *) suffix=th;;
esac

# final output
date "+%A, %B %-d$suffix %H:%M"
