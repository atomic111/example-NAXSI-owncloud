#!/bin/bash

display_usage() {
	echo -e "\nUsage:\n$0 [owncloud config backup file name] [owncloud data backup file name] \n"
	}

if [  $# -le 1 ]
	then
		display_usage
		exit 1
	fi

# for x86_64

echo "restore" $1
docker run --name restore_owncloud_config --volumes-from owncloud_data_1 -v $(pwd):/backup ubuntu:15.04 tar xzvf /backup/$1
echo "restore" $2
docker run --name restore_owncloud_data --volumes-from owncloud_data_1 -v $(pwd):/backup ubuntu:15.04 tar xzvf /backup/$2


docker rm restore_owncloud_config restore_owncloud_data
