#!/bin/bash
if [[ $# == 0 ]]; then
	echo "Missing argument. Program terminated."
	exit
fi
if [[ $1 == 0 ]]; then
	cat bookmark.txt
	exit
fi

url=$(cat bookmark.txt | grep $1. | cut -f 2)
echo "open $url"
open $url
