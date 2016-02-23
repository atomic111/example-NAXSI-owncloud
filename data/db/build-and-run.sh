#!/bin/bash

docker build -t owncloud-postgres-data . 
docker run --name owncloud-postgres-data owncloud-postgres-data
