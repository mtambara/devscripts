#!/bin/bash

cd /home/matthew/Documents/meetings

if [ -z "$1" ]; then
	touch `date +%F`
else
	touch `date +%F`-$1
fi

unset -v latest
for file in ./*; do
  [[ $file -nt $latest ]] && latest=$file
done

subl $latest