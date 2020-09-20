#!/bin/bash
################
# $ curl -s https://gist.githubusercontent.com/eggplants/86e5416993a65b73f532387b78943b7e/\
#   raw/78c88333934fec316f719336ef0ba18dd8aca104/Ricty_on_wsl.sh | bash
################

function main() {
  # 0. workdir
  sudo su
  local p
  p="$(pwd)"
  cd "$(mktemp -d)" || return 1
  # 1. FontForge
  which fontforge || {
    add-apt-repository -y ppa:fontforge/fontforge
    apt update
    apt install -y fontforge
  }
  # 2. Inconsolata(>=2.000)
  fc-list | grep inconsolata || apt install fonts-inconsolata
  wget https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Regular.ttf
  wget https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Bold.ttf
  # 3. Migu 1M(>=2015.0712)
  wget https://jaist.dl.osdn.jp/mix-mplus-ipa/63545/migu-1m-20150712.zip
  unzip ./*migu-1m-20150712.zip
  mv migu-1m-20150712/*ttf .
  # 4. Text width correction
  wget https://raw.githubusercontent.com/rictyfonts/rictyfonts.github.io/master/files/os2version_reviser.sh
  chmod 700 os2version_reviser.sh
  ./os2version_reviser.sh ./*.ttf
  # 5. Generate Ricty*ttf
  wget https://raw.githubusercontent.com/rictyfonts/rictyfonts.github.io/master/files/ricty_generator.sh
  chmod 700 ricty_generator.sh
  ./ricty_generator.sh -n "$(date +%Y%m%d%T | tr -d :)" auto
  mkdir -p ~/Ricty
  mv Ricty*.ttf ~/Ricty
  cd "$p" || return 1
}
if [ "$1" = "-n" ]; then
  main >/dev/null
else
  main
fi
exit $?
