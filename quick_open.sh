#!/bin/bash
bookmark=/Users/I335512/Documents/bookmark.txt
if [[ $# == 0 ]]; then
	cat $bookmark
	exit
fi

echo "1st arg is: $1"
url=$(cat $bookmark | grep "^$1)" | cut -f 2)
echo "open $url"
open $url
