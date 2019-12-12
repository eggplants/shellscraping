#!/bin/bash

############################
# $ sudo bash all-clone.sh #
############################

############################
      name="eggplants"
############################

if [ ${EUID:-${UID}} != 0 ]; then
	echo "[⚠]This script must be run as root..."
	exit 1
fi

echo "[-]Now fetching ${name}'s gists information..."

size="$(
	curl -s "https://gist.github.com/${name}" |
		grep -A 1 " All gists" | grep -oE "[0-9]+" -m 1
)"

pagesize="$((size / 10 + 1))"
id=()
echo "[-]Now fetching ids of repo(s)..."
for ((p = 1; p <= pagesize; p++)); do
	id+=($(
		curl -s "https://api.github.com/users/${name}/gists?page=${p}" |
			grep -oE '"id": "[^"]+' | cut -b8-
	))
done

echo "    =>${size} public repo(s) was found."

for i in "${id[@]}"; do

	seq -s'#' 40 | tr -d 0-9

	echo -n "[-]filename fetching..."
	filename="$(
		curl -s "https://api.github.com/gists/${i}" |
			grep -E "\"filename\":" | cut -b20- |
			tr -d \\n | sed 's/",/:/g;s/:$//;s/ /_/g'
	)"
	echo "=>\"${filename}\""

	echo -n "[-]cloning...:${i}"
	git clone "https://gist.github.com/${i}.git"
	mv "${i}/" "${filename}/"

	echo "=>finished."
done

echo "[+]ALL CLONE WAS COMPLETE."

exit 0