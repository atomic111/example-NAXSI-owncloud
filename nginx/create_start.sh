#!/bin/bash
#docker create --name owncloud-nginx -p 80:80 --volumes-from owncloud-data --link owncloud-postgres:postgres owncloud-nginx
docker create --name owncloud-nginx --volumes-from owncloud-data --link owncloud-postgres:postgres owncloud-nginx
docker start owncloud-nginx
