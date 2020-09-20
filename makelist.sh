#!/bin/bash
curl -s 'https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml' |
    grep -oE '^[^\ \#][^:]+' |
    sed 1d |
    nl -nrz -w3 -s, |
    sed 1inum,name
