#!/bin/bash
process() {
  cat - | while read -r s; do
    echo "$s" | kkc |
      sed -nr '
  s@.:\s|>>\s@@g
  s@<([^/]+)/[^>]+>@\1@gp'
  done
}
main() {
  ([[ "$#" -gt 0 ]] || cat - && echo "$@") | process
}
main "$@"
