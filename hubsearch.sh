#!/bin/bash
# more advanced tool: https://github.com/feinoujc/gh-search-cli

iter_page(){
  n=$(
      curl -s "https://github.com/search?q=${1}"|
       grep -oE 'data-search-type="Repositories">[0-9]+<'|
        grep -oE '[0-9]+'|
         head -1
     )
  seq "$((n/10))"
}

hub-search(){
  [ -z "${1}" ]&&{ echo "Keyword is empty." 1>&2;exit 1;}
  rm /tmp/a 2>/dev/null
  f=0
  for i in $(iter_page "$@");do
    f=1
    curl -s "https://github.com/search?p=${[^:]::i}&q=${1}" >> /tmp/a
    echo -ne "${i} pages\r"
    sleep 1 # for safe
  done 2>/dev/null

  [[ ${f} = 0 ]]&&{ echo "you have temporary blocked from github..." 1>&2;exit 1;}

  echo -e "$(
    sed 's/ /\n/g' /tmp/a|
    grep -E 'href="/|programmingLanguage'|
      grep -E 'itemprop|/em'|
      grep -oE '"[^"]+"|>[^<]+<'|
        sed -r ':j;N;$!bj;s/\n//g;s/<"/\n/g'|
        grep -oE '/[^/]+/[^"]+"|>.*$'|
          grep -v '<>'|
          sed -r 's/>/::->/g;s_^/_- _g;s/"|<//g'|
            sed -r ':j;N;$!bj;s/\n//g;s/- /\n&/g'|
            sed -r 's_^- ([^/]+)/_- \\e[1;42;49m\1\\e[0m/_g'
              #|sed -r 's_(- .*m/)(.*)$_\1\\e[3;49;41m\2\\e[0m_g'|
              #sed -r 's_(::->)(.*$)_\1\e[1;37;41m\2\\e[0m_g'
  )" | grep -E "${1}|$" --color=always -i | rev | sed -r 's/^([^:]+::)([^:]+::)/\2/g' | rev
  exit 0
}