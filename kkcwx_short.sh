#!/bin/bash
process(){
for s in $(cat - );do
  echo "$s"|kkc|
  sed -nr '
  s@.:\s|>>\s@@g
  s@<([^/]+)/[^>]+>@\1@gp'
done
}
main(){
([[ "$#" > 0 ]] && echo "$@" || cat - )| process
}
main "$@"
