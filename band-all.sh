#!/bin/bash
##################################
# $ ./band-all.sh sabacanrecords #
##################################

trap interrupt INT
interrupt() {
  echo
  cd "$p" || return
  exit 1
}

#################
savedir="${HOME}/Music"
#################

p="$(pwd)"
_check() {
  if [ -z "$(which bandcamp-dl)" ]; then
    echo -e "You should try this:\npip3 install bandcamp-downloader\nOr, configure PATH:" 1>&2
    return 1
  elif [ -z "$*" ]; then
    echo -e "Target userid is missing." 1>&2
    return 1
  elif curl -s "https://${1}.bandcamp.com/music" | grep -q 'Sorry, that something is not here.'; then
    echo -e "Target user store does not exist." 1>&2
    return 1
  elif curl -s "https://${1}.bandcamp.com/music" | grep -q 'No tracks here yet.'; then
    echo -e "Target user have not upload albums yet." 1>&2
    return 1
  else
    return 0
  fi
}
_main() {
  ##########
  mkdir -p "${savedir}"
  cd "${savedir}" || return
  ##########
  url="https://${1}.bandcamp.com/"
  misc="$(
    curl -s "${url}music" |
      grep -oE '(album|track)/[^"]+' |
      sed "s_^_${url}_g"
  )"
  count="$(echo "${misc}" | wc -l)"
  echo "${count} ${1}'s work(s) was found."

  for i in ${misc}; do
    echo -ne "Now Downloading:\n    ${i}"
    bandcamp-dl -f "${i}" 1>/dev/null 2>/dev/null
    echo "=>finished."
  done
  cd "$p" || return
  return 0
}

_check "$@"
ret="$?"
[ "$ret" = 0 ] && _main "$@"
