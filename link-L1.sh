#!/bin/sh
curl -s http://maltinerecords.cs8.biz/release.html |
egrep -o 'href="[^"]+'                             |
cut -b 7-                                          |
while read i; do
[ $i =~ http ]                                     \
&&echo "$i"                                        \
||echo "http://maltinerecords.cs8.biz/$i"
done > links