curl -s http://maltinerecords.cs8.biz/release.html| 
egrep -o 'href="[^"]+'                            |
cut -b 7-                                         | 
while read i; do [[ $i =~ http ]]                 \
&&echo "$i"                                       \
||echo "http://maltinerecords.cs8.biz/$i"
done                                              |
while read i; do 
curl -m 2 -s $i                                   |
egrep -o 'href="[^"]+'                            |
cut -b 7-                                         |
egrep "*(mp3|7z|rar|zip)$"                        |
while read f; do 
  if [[ "$f" =~ ^http ]]; then
    echo $f
  elif [[ "$f" =~ ^/release ]]; then
    echo http://maltinerecords.cs8.biz/$f
  elif [[ "$f" =~ ^\. ]]; then
    echo $i`sed 's/.//'<<<$f`
  else 
    echo $i$f
  fi
done
done                                              |
sed -r "s_//_/_g;s_htmlrelease_html/release_g"    |
uniq>link