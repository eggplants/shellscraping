#!/bin/bash

curl -s "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" |
    grep -oE '^[^\ \#][^:]+' | sed '1d;y/+/p/' | while read -r i; do
    echo "$i,$(
        curl -s "https://qiita.com/tags/${i,,}" |
            tr -d \\n | grep -oPm1 '(?<=<span class="tsi-Stats_count">)\d+'
    )" | tr \\n ,
    echo
done | sed 's/\([0-9]\),$/\1/g' >result
