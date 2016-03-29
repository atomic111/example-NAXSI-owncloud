#!/bin/bash

display_usage() {
	echo -e "\nUsage:\n$0 [backup file name] \n"
	}

if [  $# -le 0 ]
	then
		display_usage
		exit 1
	fi

echo "restore db backup" $1

# for x86_64

docker run --name restore_db --volumes-from owncloud_postgres_data_1 -v $(pwd):/backup ubuntu:15.04 tar xzvf /backup/$1

docker rm restore_db
