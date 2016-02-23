# NAXSI for owncloud
Create a NAXSI web application firewall for owncloud

## What is this repository for?

This repository provides owncloud with NAXSI web application firewall for x86 on Docker. It contains 5 container:

- owncloud-naxsi: runs the naxsi web application firewall
- owncloud-nginx: runs the nginxs webserver with owncloud installation
- owncloud-data: is a data volume container for owncloud-nginx and contains the data
- owncloud-postgres: runs the postgresal database
- owncloud-postgres-data: contains the data for postgresql database

Also the repo includes simple backup and restore scripts.

## Prerequisites

- Install Docker

## Usage

Just execute the start.sh. It will build all needed images and start the containers.

## Owncloud Login

The default user is admin with password admin.

## How to use NAXSI with elasticsearch to generate whitelist rules ###

* test elasticsearch:
`curl -XGET http://elasticsearch:9200/`

* create nxapi tabel:
`curl -XPUT 'http://elasticsearch:9200/nxapi/'`

* write stuff to db:
`nxtool.py -c /etc/nginx/nxapi.json --files=/var/log/nginx/naxsi_error.log`

* check command:
`curl -XPOST "http://elasticsearch:9200/nxapi/events/_search?pretty" -d '{}'` or `nxtool.py -x -c /etc/nginx/nxapi.json -s 127.0.0.1`

* generate whitelist:
`nxtool.py -c /etc/nginx/nxapi.json -s 127.0.0.1 -f --slack`

* generate whitelist for a special uri
`nxtool.py -c /etc/nginx/nxapi.json -s 127.0.0.1 -f --filter 'uri /core/img/actions/delete.svg' --slack`

* save the rule in
`/etc/nginx/naxsi_whitelist.rules`

* tag the rule in the elasticsearch db
`nxtool.py -c /etc/nginx/nxapi.json -s 127.0.0.1 -w /etc/nginx/naxsi_whitelist.rules --tag`

## Contributors + Kudos

* Patrick Münch [atomic111](https://github.com/atomic111)
* Dominik Richter [arlimus](https://github.com/arlimus)
* Christoph Hartmann [chris-rock](https://github.com/chris-rock)

## TODO

* Write permanant NAXSI events to elasticsearch
* Clean NAXSI logs
* Use Kibana for visualization
* Clean rules

## License and Author

* Author:: Patrick Muench <patrick.muench1111@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
