
#!/bin/bash
t='https://ownedmedia-library.com/'
for i in {1..75}
{ echo -n "${i}:" 1>&2
  curl -s "${t}page/${i}/" |
  grep -oP "(?<=${t})\d+-[^/]+"
} | sort | uniq | sort -n |
while read i
do echo -e "${i}" 1>&2
   curl -s "${t}${i}/" |
   grep -oP '(?<="https://twitter.com/)[a-zA-Z0-9_]+(?=")'
done | sort | uniq |
while read i
do echo -n "${i}:" 1>&2
   f="`twarc users "${i}"|jq .followers_count`"
   [[ f -le 1000 ]]&&echo "${i} ${f}"
   sleep 12
done > c
