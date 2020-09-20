#!/bin/bash
curl -s "https://api.github.com/users/[github_userid]/repos" |
  grep html_url |
    awk -F'"' '$0=$4' |
      sort | uniq -u  |
        while read i
          do git clone "${i}.git"
            done
