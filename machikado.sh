#!/bin/bash
curl -s 'https://lawson-print.com/products/categories/machikado?page=[1-29]'  |
egrep -B8 '<span>まちカドまぞく__[^<]+'  |  sed -r 's/^\t+//g;/^$/d;s/^--/@/g;1s/^/\n/'  |
awk -F\\n '{print substr($2,34,43)"\n"substr($8,10,29)"\n"substr($9,7)}' RS=@ |
ruby -e 'u = "https://lawson-print.com"
`dd`.split(?\n).each_slice(3).to_a.uniq.map { | a, b, c |
  puts "## [#{ c.scan(/^[^<]+/)[0] }](#{ u+b })\n![img](#{ u+a })"
}' > mazoku.md
