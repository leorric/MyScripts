#!/bin/sh

time=`date +%s`
echo $time
for i in {1..1};do
	/opt/homebrew/Cellar/imagemagick/7.1.1-15/bin/convert ~/Desktop/Image1.jpg -resize 568x426 ~/projects/business_network/tasks/tmp/$i+568x426.jpg
#	/opt/homebrew/Cellar/imagemagick/7.1.1-15/bin/convert ~/Desktop/Image1.jpg -resize 820x820 ~/projects/business_network/tasks/tmp/$i+820x820.jpg
#	/opt/homebrew/Cellar/imagemagick/7.1.1-15/bin/convert ~/Desktop/Image1.jpg -resize 160x160 ~/projects/business_network/tasks/tmp/$i+160x160.jpg
done
ctime=`date +%s`
time=$((ctime - time))
echo $time
