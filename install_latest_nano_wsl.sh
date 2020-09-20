#!/bin/bash
function main() {
      ####################
      local -r var
      var="$(curl -s 'https://www.nano-editor.org/dist/latest/?C=M;O=A' |
            grep -oP '(?<=nano-)[\d\.]+(?=\.tar\.gz)' | uniq | sort -V | tail -1)"
      ####################
      sudo su
      which nano && apt remove nano -y
      which gcc || apt install gcc -y
      which make || apt install make -y
      [ "$(find /usr/include/ -name ncurses.h | wc -l)" = 1 ] &&
            apt install libncursesw5-dev -y
      ###################
      local p
      p="$(pwd)"
      cd "$(mktemp -d)" || return 1
      #####################
      wget "https://www.nano-editor.org/dist/latest/nano-${var}.tar.xz" | tar xvf -
      ./configure --prefix=/usr \
            --sysconfdir=/etc \
            --enable-utf8 \
            --docdir="/usr/share/doc/nano-${var}" \
            --disable-dependency-tracking && make
      #####################
      make install &&
            install -v -m644 doc/{nano.html,sample.nanorc} "/usr/share/doc/nano-${var}"
      cd "${p}" || return 1
}
main
exit $?
