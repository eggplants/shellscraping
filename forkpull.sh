#!/bin/bash
function forkpull() {
        giturl="$1"
        echo -n "original git URL of own fork repo >>>"
        [[ -z ${giturl} ]] && read -r giturl
        [[ -z ${giturl} ]] || git remote add upstream "${giturl}"
        git fetch upstream
        git merge upstream/master
}
