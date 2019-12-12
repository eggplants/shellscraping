#!/bin/bash
# CREATE: 2019-11-28
# UPDATE: 2019-11-29
# NOTE: Downloaded data is following CC BY-NC 2.1(https://creativecommons.org/licenses/by-nc/2.1/jp/legalcode)
# RECOMEND: when you decompose those files, do: ls|xargs -P 30 -I@ unar @ 
LATEST=176
###############################
mkdir -p MALTINE_ALL_ALBUMS_ZIP
cd MALTINE_ALL_ALBUMS_ZIP
###############################

# MARUB-001
wget http://maltinerecords.cs8.biz/release/b1/MARUB-001.zip

# MARUG-001
wget -O ./MARUG-001.zip http://maltinerecords.cs8.biz/release/marug01/MARUG01_PowerBook.zip

# MARUI-{001..003}: BUY!!!!!!!!!
xdg-open https://www.amazon.co.jp/dp/B00MN54754 1>/dev/null 2>/dev/null
xdg-open https://music.apple.com/jp/album/567392143 1>/dev/null 2>/dev/null
xdg-open https://www.amazon.co.jp/dp/B00GTNXRHU 1>/dev/null 2>/dev/null

# MARUI-{004,005}
wget -O ./MARUI-004.zip http://maltinerecords.cs8.biz/release/marui4/marui004.zip
wget -O ./MARUI-005.zip http://maltinerecords.cs8.biz/marui5/MARUI005.zip

# MARUI-{006..009}: MP3 LISTEN!!!!!!!!!!!!
for i in mikeneko-homeless-purity-feat-nagi-nemotonijicon america-feat-nagi-nemotonijicon peppermint_escape_plan aoi-yagawa-on-the-line-prod-tomggg ;do
  xdg-open https://soundcloud.com/maltine-record/$i 1>/dev/null 2>/dev/null
done


# MARUL-{002..006}
for i in 2 3 5 6; do 
  wget -O ./MARUL-`printf %03d $i`.zip http://maltinerecords.cs8.biz/release/marul$i/marul$i.zip
done
wget -O ./MARUL-004.zip http://maltinerecords.cs8.biz/release/marul4/DJ_WILDPARTY-MIX_TAPE.zip

# ZL×MARU-001
wget -O ./ZL×MARU-001.zip http://maltinerecords.cs8.biz/release/zl_maru01/zl_maru_001.zip

# ZL×MARU-002: bandcamp
# https://zoomlens.bandcamp.com/album/always
mkdir -p zl002
paste <(
  curl -s https://zoomlens.bandcamp.com/album/always|egrep -o '"https://t4[^"]+'|cut -b2-
) <(
 curl -s https://zoomlens.bandcamp.com/album/always|egrep '^[1-6]\.'|tr \ \.  _-
)|while read u t; do
  wget -O ./zl002/$t.mp3 $u
done

zip -r ZL×MARU-002.zip zl002
rm -r zl002

# SKLxMARU-001
wget http://maltinerecords.cs8.biz/SKLxMARU-001.zip

# MARU×AM-001: BUY!!!!!!!!!
xdg-open http://smarturl.it/aijpho 1>/dev/null 2>/dev/null


# MARU-{6..99} {101..127} {141..143}
for i in 6 7 8 {10..99} {101..109} {111..127} {141..143}; do 
  wget -O ./MARU-`printf %03d $i`.zip http://maltinerecords.cs8.biz/release/$i/maru$i.zip
done

# MARU-{128..LATEST}
for i in {128..140} {144..160} {162..167} `seq 172 $LATEST`; do
  wget -O ./MARU-$i.zip http://maltinerecords.cs8.biz/release/$i/MARU$i.zip
done

# MARU-{168,171}
for i in 168 171; do
  wget http://maltinerecords.cs8.biz/release/$i/MARU-$i.zip
done
for i in 169 170; do
  wget http://maltinerecords-m.cs8.biz/$i/MARU-$i.zip
done

# MARU-009
mkdir -p maru009
paste <(
  echo http://maltinerecords.cs8.biz/release/9/0{1,2}.mp3|tr \  \\n
) <(
  echo -e "SIDE 1 - Zoukinchan\nSIDE 2 - White melo day"|tr \  _
)|while read u t; do
  wget -O ./maru009/$t.mp3 $u
done
zip -r MARU-009.zip maru009
rm -r maru009

# MARU-100: BUY!!!!!!!!!
xdg-open http://www.switch-store.net/SHOP/SS0027.html 1>/dev/null 2>/dev/null

# MARU-161: Mine sweeper
wget http://maltinerecords.cs8.biz/161/static/zip/MARU-161.zip

# MARU-137
wget -O ./MARU-137.zip http://maltinerecords.cs8.biz/release/137/MARU137_Porter_Robinson_Re_Flicker.zip

# MARU-110: Bandcamp
# https://maltinerecords2.bandcamp.com/album/maru-110-nitpicker-ep
mkdir -p maru110
paste <(
  curl -s https://maltinerecords2.bandcamp.com/album/maru-110-nitpicker-ep|
  egrep -o '"https://t4[^"]+'|cut -b2-
) <(
  curl -s https://maltinerecords2.bandcamp.com/album/maru-110-nitpicker-ep|
  sed -nr "s/^|$/\'/g;s/ /_/g;17,25s/\./-/gp"
)|while read u t; do
  wget -O ./maru110/$t.mp3 $u
done
zip -r MARU-110.zip maru110
rm -r maru110

# DEBUG: Checking lack of numbers
diff <(seq -w 3 1 $LATEST) <(ls|egrep -o '[0-9]+'|sort -n)|grep \<