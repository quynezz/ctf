#!/usr/bin/env bash

if [ -f flag.zip ]; then
    touch flag.zip
fi

cat part_a* >>flag.zip

# unzip and read the file
unzip -q -P "supersecret" flag.zip

flag="flag.txt"
if [ -f $flag ]; then
    cat $flag
fi
