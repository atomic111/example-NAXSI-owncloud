#!/bin/bash

cd ./data/db
sh build-and-run.sh

cd ../owncloud/
sh build-and-run.sh

cd ../../db/
sh build-image.sh
sh create_start.sh

cd ../nginx/
sh build-image.sh
sh create_start.sh

cd ../waf/
sh build-image.sh
sh create_start.sh
