#!/bin/bash

# for x86_64

docker exec -it owncloud-postgres /bin/bash -c "gosu postgres pg_dumpall > /var/lib/postgresql/db.backup"
docker run --name backup_db --volumes-from owncloud-postgres-data -v $(pwd):/backup ubuntu:15.04 tar czvf /backup/$(date +%Y-%m-%d_%H%M)_backup_db.tar.gz /var/lib/postgresql/

docker rm backup_db
