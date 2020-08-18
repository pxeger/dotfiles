#!/bin/sh

# ordinal numbers
day=$(date +%e)
if [[ ${date%1} ]]; then
    suffix="st"
elif [[ ${date%2} ]]; then
    suffix="nd"
elif [[ ${date%3} ]]; then
    suffix="rd"
else
    suffix="th"
fi

# final output
date "+%A, %B %e$suffix %H:%M"
