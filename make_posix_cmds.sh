#!/bin/bash

url='https://pubs.opengroup.org/onlinepubs/9699919799'

curl -s "${url}/idx/utilities.html" |
  grep -oE '>[^<]+<' |
  tr -d '<>' |
  while read -r i; do
    curl -s "${url}/utilities/${i}.html" |
      grep -oEm1 '<blockquote>.*</blockquote>' |
      sed -r 's/<[^>]+>//g' |
      tee >(
        sed -r 's/^[^-]+- //' |
          trans -s en -t ja -b
      ) |
      tr \\n @
    sleep $((5 + RANDOM % 10))
  done |
  nl -nrz -w3 |
  sed -r 's/^([0-9]+)\s+/\1@/g;s/(^[0-9]+@[0-9a-z]+) - /\1@/g' >cmd_posix

# ==================
# make a table by md
# ==================

cat <<EOS >list.md
|no |command|desc_ja|desc_en|
|---|-------|-------|-------|
$(sed -r 's_(^|@|$)_|_g' cmd_posix)
EOS
