#!/bin/bash
#docker create --name owncloud-postgres -p 5432:5432 --volumes-from owncloud-postgres-data owncloud-postgres
docker create --name owncloud-postgres --volumes-from owncloud-postgres-data owncloud-postgres
docker start owncloud-postgres
