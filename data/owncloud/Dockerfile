# vim:set ft=dockerfile:
# encoding: utf-8
#
# owncloud volume data container Dockerfile
#
# Copyright 2016, Patrick Muench
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:15.04

MAINTAINER Patrick Meier  <patrick.meier111@gmail.com>

RUN mkdir -p /var/www/owncloud/data
RUN chmod -R 0777 /var/www/owncloud/data
RUN chown -R www-data:www-data /var/www/owncloud/data
VOLUME ["/var/www/owncloud/data"]

RUN mkdir -p /var/www/owncloud/config
RUN chmod -R 0777 /var/www/owncloud/config
RUN chown -R www-data:www-data /var/www/owncloud/config
VOLUME ["/var/www/owncloud/config"]

CMD echo "Data container only (/data, /config)"
