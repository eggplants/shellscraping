#!/bin/bash

t='https://ownedmedia-library.com/'

for i in {1..75}; do
   echo -ne "${i}:\r" 1>&2
   curl -s "${t}page/${i}/" |
      grep -oP "(?<=${t})\d+-[^/]+"
done | sort | uniq | sort -n |
   while read -r i; do
      echo -ne "${i}\r" 1>&2
      curl -s "${t}${i}/" |
         grep -oP '(?<="https://twitter.com/)[a-zA-Z0-9_]+(?=")'
   done | sort | uniq |
   while read -r i; do
      echo -ne "${i}:\r" 1>&2
      f="$(twarc users "${i}" | jq .followers_count)"
      [[ f -le 1000 ]] && echo "${i} ${f}"
      sleep 12
   done >ownedmedia_twitter_account_list
