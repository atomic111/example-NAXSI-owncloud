#!/bin/bash

# to create naxsi rules
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -d elasticsearch elasticsearch -Des.network.host=0.0.0.0
docker create --name owncloud-naxsi -e PROXY_REDIRECT_IP=owncloud -e LEARNING_MODE=yes --link owncloud-nginx:owncloud --link elasticsearch:elasticsearch -p 443:443 owncloud-naxsi

#productiv
#docker create --name owncloud-naxsi -e PROXY_REDIRECT_IP=owncloud --link owncloud-nginx:owncloud -p 443:443 owncloud-naxsi
docker start owncloud-naxsi
