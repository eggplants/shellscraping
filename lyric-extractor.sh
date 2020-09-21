#!/bin/bash

# http://j-lyric.net/
j-lyric() {
  curl -s "$1" | grep -oP '(?<=class="cap"><h2)(.*)?(?=class="fnt")' |
    grep -oP '(?<=>)[^<]+' |
    sed -z 's/：./：/'
}

# https://www.uta-net.com/
uta-net() {
  curl -s "$1" | tr -d \\n |
    grep -oP '(?<=class="prev_pad").*(?="view_mylink")' |
    grep -oP '(?<=>)[^<]+' |
    sed -z 's/：\n/ ：/g' |
    sed -r '2,6d;/^\W+$/d'
}

# https://utaten.com/
utaten() {
  curl -s "$1" | tr -d \\n\\r\  |
    grep -oP '(?<="movieTtl_mainTxt").*(?="lyricLink")' |
    grep -oP '(?<=>)[^<]+' |
    sed 2d
  curl -s "$1" | tr -d \\n\\r\  |
    grep -oP '(?<="lyricBody").*(?="btn_sbs")' |
    sed -r 's/<span class="rt">(\w+)<\/span>/ 〈\1〉/g  ;
                         s/<span class="rb">(\w+)<\/span>/《\1》/g' |
    grep -oP '(?<=>)[^<]+' |
    ruby <<'EOS'
    puts`dd`.split(/\n\n/).map{_1.gsub(?\n,"")+?\n*2}
EOS
}

# http://www.kget.jp/
kget() {
  curl -s "$1" | tr -d \\n\\r\  |
    grep -oP '(?<=id="status-heading").*(?="ad-wrap")' |
    grep -oP '(?<=>)[^<]+'
  curl -s "$1" | tr -d \\n\\r\  |
    grep -oP '(?<="float:right;"></a>).*?(?=</div><!--close)' |
    ruby -rcgi <<'EOS'
    puts`dd`.split("<br/>").map{CGI.unescapeHTML(_1)}
EOS
}

# https://genius.com/
genius() {
  curl -s "$1" | grep -oP '(?<=<title>)(.*?)(?= Lyrics | Genius Lyrics)'
  curl -s "$1" | tr -d \\n\\r |
    grep -oP '(?<=class="lyrics").*(?="recirculated_content")' |
    grep -oP '(?<=<p>).*(?=<\/p>)' |
    sed -zr 's/<br>/\n/g' |
    sed -r 's/<.*?>//g'
}

# https://kashinavi.com/
kashinv() {
  curl -s "$1" | iconv -f sjis -t utf8 -c | tr -d \\n\\r |
    grep -oP '(?<=div align=center>).*?(?=#cccccc)' |
    grep -oP '(?<=>)[^<]+' | sed -z 's/：./：/'
  curl -s "$1" | iconv -f sjis -t utf8 -c | tr -d \\n\\r |
    grep -oP '(?<=class="kashi").*?(?=noshade)' |
    grep -oP '(?<=;">).*?(?=<\/div>)' |
    sed -z 's/<br>/\n/g'

}

# https://www.utamap.com
utamap() {
  curl -s "$1" | iconv -f EUCJP -t utf8 -c | tr -d \\n\\r |
    grep -oP '(?<="kasi1").*?(?=<\/table>)' |
    grep -oP '(?<=>)[^<]+' |
    sed 's/&.*;//g'
  curl -s "$1" | iconv -f EUCJP -t utf8 -c | tr -d \\n\\r |
    grep -oP '(?<=kasi_honbun">).*?(?=<!--)' |
    sed -z 's/<br>/\n/g'
}

main() {
  for arg in "$@"; do
    case "$arg" in
      *j-lyric.net*) j-lyric "$arg" ;;
      *uta-net.com*) uta-net "$arg" ;;
      *utaten.com*) utaten "$arg" ;;
      *kget.jp*) kget "$arg" ;;
      *genius.com*) genius "$arg" ;;
      *kashinavi.com*) kashinv "$arg" ;;
      *utamap.com*) utamap "$arg" ;;
      *) : ;;
    esac
  done
  return 0
}

main "$@"
exit $?
