#!/bin/bash
grep -oE '>[^<]+' <(curl -s "https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html")|
tr -d \>|tail -n +4|while read i;do which $i||{ sleep 1;sudo apt install -y $i;};done
