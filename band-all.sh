#!/bin/bash
##################################
# $ ./band-all.sh sabacanrecords #
##################################


trap interrupt INT
interrupt(){ echo;cd "$p";exit 1;}

#################
savedir="${HOME}/Music"
#################

p="`pwd`"
_check(){
  [ -z "`which bandcamp-dl`" ]&&{
    echo -e "You should try this:\npip3 install bandcamp-downloader\nOr, configure PATH:" 1>&2
    return 1
  }
  [ -z "$@" ]&&{
    echo -e "Target userid is missing." 1>&2
    return 1
  }
  [ -n "`curl -s https://${1}.bandcamp.com/music|grep 'Sorry, that something isn’t here.'`" ]&&{
    echo -e "Target user store does not exist." 1>&2
    return 1
  }
  [ -n "`curl -s https://${1}.bandcamp.com/music|grep 'No tracks here yet.'`" ]&&{
    echo -e "Target user have not upload albums yet." 1>&2
    return 1
  }
  return 0
}
_main(){
  ##########
  mkdir -p "${savedir}"
  cd "${savedir}"
  ##########
   url="https://${1}.bandcamp.com/"
   misc="`
      curl -s "${url}music"|
       egrep -o '(album|track)/[^"]+'|
       sed "s_^_${url}_g"
       `"
  echo "$(echo "$misc"|wc -l) ${1}'s work(s) was found."

  for i in `echo $misc`; do
    echo -ne "Now Downloading:\n    ${i}"
    bandcamp-dl -f "${i}" 1>/dev/null 2>/dev/null
    echo "=>finished."
  done
  cd "$p"
  return 0
}

_check $@; ret="$?"
[ "$ret" = 0 ]&&_main $@