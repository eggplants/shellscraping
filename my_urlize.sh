#!/usr/bin/bash
urlize() {
  if [[ $# = 0 ]]; then
    echo "base64 -d <(sed -r 's/.{5}//'<<<'b.sh/$(base64 </dev/stdin)')|bash #shellgei" | tr -d \\n
  else
    echo "base64 -d <(sed -r 's/.{5}//'<<<'b.sh/$(base64 <<<"$@")')|bash #shellgei" | tr -d \\n
  fi
  echo
}
