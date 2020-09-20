#!/bin/bash
curl -s 'http://maltinerecords.cs8.biz/release.html' |
  grep -oE 'href="[^"]+' |
  cut -b 7- |
  while read -r i; do
    [[ $i =~ http ]] &&
      echo "$i" ||
      echo "http://maltinerecords.cs8.biz/$i"
  done |
  while read -r i; do
    curl -m 2 -s "$i" |
      grep -oE 'href="[^"]+' |
      cut -b 7- |
      grep -E '(mp3|7z|rar|zip)$' |
      while read -r f; do
        if [[ "$f" =~ ^http ]]; then
          echo "$f"
        elif [[ "$f" =~ ^/release ]]; then
          echo "http://maltinerecords.cs8.biz/$f"
        elif [[ "$f" =~ ^\. ]]; then
          echo "${i}${f/./}"
        else
          echo "$i$f"
        fi
      done
  done |
  sed -r "s_//_/_g;s_htmlrelease_html/release_g" |
  uniq >links
