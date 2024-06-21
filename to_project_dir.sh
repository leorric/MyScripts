#!/bin/bash

an_dir=/Users/I335512/SAPDevelop/AN
sa_dir=/Users/I335512/SAPDevelop/seller-app
cx_dir=/Users/I335512/projects/commerce_cloud

if [ "$1" = "an" ]; then
	 echo "go to $an_dir"
	 cd $an_dir
elif [ "$1" = "sa" ]; then
	 echo "go to $sa_dir"
	 cd $sa_dir
else
	 echo "go to default cx directory"
	 cd $cx_dir
fi
