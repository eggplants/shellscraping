#!/bin/bash

# http://j-lyric.net/
j-lyric() {
  curl -s "$1" \
            | egrep -o '
<h2>[^<]+</h2>
|<p class="sml">[^<]+<a[^>]+>[^>]+>
|<p id="Lyric">[^/]+</p>
|<p class="sml">[^<]+</p>' \
                          | sed -r '
s/<br>/\n/g
s/<[^>]+>//g
'
}

# https://www.uta-net.com/
uta-net() {
  curl -s "$1" \
            | egrep -o '
<h2 class="prev_pad">[^<]+</h2>
|<div class="kashi_artist">(.*?)</div>
|<div id="kashi_area" itemprop="text">(.*?)</div>
' | sed -r '
s_</br>|<br />_\n_g
s_<[^>]+>__g
'
}

# https://utaten.com/
utaten() {
  curl -s "$1"| tr -d \\n| egrep -o '
<div class="hiragana" >(.*?)</div>
|>[^<]+</d[dt]>
' | sed -r '
s_<br />_\n_g
s_<span class="ruby"><span class="rb">_[_g
s_</span><span class="rt">_(_g
s_</span></span>_)]_g
s_</dt>_:_g
s_<div class="hiragana" > +__g;s_>__g
s_</dd__g
s_^ +__g
' | head -n -3
}

# http://www.kget.jp/
kget() {
  curl -s "$1" \
            | egrep -o '
<tr>.*</tr>$
|^&#(.*?)$
' | sed -r '
s_<tr><th>__g
s_<br />_\n_g
s_<br></td></tr>__g
s_</th><td>_:_g
' | ruby -e '
require "cgi"
puts`dd status=none`.split.map{|s|CGI.unescapeHTML(s)}
' | sed -z '
s_<.*">__
s_<.*</tr>__
'
}

# https://genius.com/
genius() {
  curl -s "$1" \
            | pee "
awk '/header_with_cover_art-primary_info-title/,/song_body column_layout/'|
egrep -o '>[^<]+<'|
tr -d '><'|
awk \{ORS=NR%2?\\\":\\\":\\\"\\\n\\\"\;print\}
" "
awk '/<p><a/,/More on Genius/'|
egrep -o '
>[^<]+<|^[^<>]+(</a>)*<br>$
'|sed -r '
 s_<|>|<[^>]+>__g
$ d
'"
}

# https://kashinavi.com/
kashinv() {
  echo "yet..."
}

# https://www.utamap.com
utamap() {
  echo "yet..."
}

main() {
  case "$1" in
    *j-lyric.net*)   j-lyric $@ ;;
    *uta-net.com*)   uta-net $@ ;;
    *utaten.com*)    utaten  $@ ;;
    *kget.jp*)       kget    $@ ;;
    *genius.com*)    genius  $@ ;;
    *kashinavi.com*) kashinv $@ ;;
    *utamap.com*)    utamap  $@ ;;
    *)               return  1  ;;
  esac
  return 0
}

main $@
