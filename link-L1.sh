#!/bin/bash

curl -s http://maltinerecords.cs8.biz/release.html |
    grep -oE 'href="[^"]+' |
    cut -b 7- |
    while read -r i; do
        [[ $i =~ http ]] &&
            echo "$i" ||
            echo "http://maltinerecords.cs8.biz/$i"
    done >links
