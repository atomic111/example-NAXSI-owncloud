#!/bin/bash
docker build -t owncloud-data . 
docker run --name owncloud-data owncloud-data


# old stuff
#docker run --name owncloud-postgres-data -v /var/lib/postgresql/ busybox echo PostgreSQL data-only container
#docker run --name owncloud-postgres -p 5432:5432  --volumes-from owncloud-postgres-data postgres
