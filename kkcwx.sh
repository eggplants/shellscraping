#!/bin/bash
########
# help #
########
function help() {
  cat <<"EOS"
kkcwx - 0.0.1 2019-
MIT License.
kkcwx is conversion (hiragana -> kanji) command.
This converts hiragana in the given sentence to kanji (or katakana).
Repository: https://gist.github.com/eggplants/d44fff3ec3a7b89bce04053b3db3c94e/
    Author: haruna <github.com/eggplants>
Usage:
  kkcwx [text]
Examples:
kkcwx わたしは おいしい みせをしっている
kkcwx "
きみがよは
ちよにやちよに
さざれいしの
いわおとなりて
こけのむすまで
"
echo あかしろきいろ|kkcwx
kkcwx<<💩
わたしまけましたわ
うんこです
💩
Flags:
  -h, --help      help for align
EOS
}
###########
# PROCESS #
###########
function process() {

  cat - | while read -r s; do
    # kkcに入力, 出力をsedで整形
    echo "$s" | kkc |
      sed -nr 's@[^<]*<([^>/]*)[^<]+@\1@gp'
  done
}
########
# main #
########
function main() {
  [[ "$1" =~ --help|-h ]] && help
  ([[ "$#" -gt 0 ]] || cat - && echo "$@") | process
  exit 0
}

main "$@"
exit 1
