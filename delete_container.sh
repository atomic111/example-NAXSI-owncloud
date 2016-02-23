#!/bin/bash

#echo "stop container"
#docker stop owncloud-data owncloud-postgres-data owncloud-postgres owncloud-nginx owncloud-naxsi elasticsearch
echo "remove container"
docker rm -f owncloud-data owncloud-postgres-data owncloud-postgres owncloud-nginx owncloud-naxsi elasticsearch
