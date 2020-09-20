#!/bin/bash
# for person won't install shellcheck...
main() {
  [ -z "$1" ] && return 1
  shfmt -i 2 -ci -bn -s -kp -sr -w "$1"
  bash -n "$1"
  xsel -bi <"$1"
  # xdg-open https://www.shellcheck.net/
  return 0
}
main "$@"
