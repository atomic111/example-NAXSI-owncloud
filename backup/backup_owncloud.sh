#!/bin/bash

# for x86_64

docker run --name backup_owncloud_data --volumes-from owncloud-data -v $(pwd):/backup ubuntu:15.04 tar czvf /backup/$(date +%Y-%m-%d_%H:%M)_backup_owncloud_data.tar.gz /var/www/owncloud/data
docker run --name backup_owncloud_config --volumes-from owncloud-data -v $(pwd):/backup ubuntu:15.04 tar czvf /backup/$(date +%Y-%m-%d_%H:%M)_backup_owncloud_config.tar.gz /var/www/owncloud/config

docker rm backup_owncloud_data backup_owncloud_config

