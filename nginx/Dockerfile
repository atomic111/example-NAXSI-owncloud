# vim:set ft=dockerfile:
# encoding: utf-8
#
# owncloud - nginx Dockerfile
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

# Install stuff - supervisor, nginx and php dependencies

RUN apt-get update \
    && apt-get install -y ffmpeg supervisor nginx nginx-extras php5 php5-gd php-xml-parser php5-intl php5-json php5-mcrypt php5-fpm php-apc php5-imap php5-mcrypt php5-curl php5-imagick php5-pgsql php5-mysql php5-sqlite php5-apcu smbclient curl libcurl3 bzip2 unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install OwnCloud

ENV OWNCLOUD_VERSION 9.0.0
RUN curl https://download.owncloud.org/community/owncloud-${OWNCLOUD_VERSION}.tar.bz2 | tar jx -C /var/www/
COPY occ.sh /usr/bin/occ

# Install owncloud video plugin

ENV VIDEOJS_NAME master.zip
ENV VIDEOJS_UNPACK files_videoplayer-master

RUN curl -Lo /var/www/owncloud/apps/${VIDEOJS_NAME} https://github.com/owncloud/files_videoplayer/archive/${VIDEOJS_NAME}
RUN unzip -d /var/www/owncloud/apps/ /var/www/owncloud/apps/${VIDEOJS_NAME}
RUN mv /var/www/owncloud/apps/${VIDEOJS_UNPACK} /var/www/owncloud/apps/files_videojs-sublime
RUN rm /var/www/owncloud/apps/${VIDEOJS_NAME}

# Install Galleryplus owncloud plugin

ENV GALLERYPLUS_NAME stable9.zip
ENV GALLERYPLUS_UNPACK galleryplus-stable9

RUN curl -Lo /var/www/owncloud/apps/${GALLERYPLUS_NAME} https://github.com/interfasys/galleryplus/archive/${GALLERYPLUS_NAME}
RUN unzip -d /var/www/owncloud/apps/ /var/www/owncloud/apps/${GALLERYPLUS_NAME}
RUN mv /var/www/owncloud/apps/${GALLERYPLUS_UNPACK} /var/www/owncloud/apps/galleryplus
RUN rm /var/www/owncloud/apps/${GALLERYPLUS_NAME}

  # Correct permissions

RUN chown -R www-data:www-data /var/www

# Configure Owncloud

#RUN sed -i -e "s/^php_value upload_max_filesize\s*513M/php_value upload_max_filesize 10G/" /var/www/owncloud/.htaccess
#RUN sed -i -e "s/^php_value post_max_size 513M/php_value post_max_size 10G/" /var/www/owncloud/.htaccess
RUN sed -i -e "s/^php_value upload_max_filesize\s*513M/php_value upload_max_filesize 10G/" /var/www/owncloud/.htaccess
RUN sed -i -e "s/^php_value post_max_size 513M/php_value post_max_size 10G/" /var/www/owncloud/.htaccess
RUN sed -i -e "s/^upload_max_filesize=513M/upload_max_filesize=10G/" /var/www/owncloud/.user.ini
RUN sed -i -e "s/^post_max_size=513M/post_max_size=10G/" /var/www/owncloud/.user.ini

# Configure nginx

COPY nginx.conf /etc/nginx/nginx.conf

# Configure php

COPY php.ini /etc/php5/fpm/php.ini
COPY php-cli.ini /etc/php5/cli/php.ini
COPY www.conf /etc/php5/fpm/pool.d/www.conf

# Configure supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy run

COPY run.sh /usr/bin/run.sh

EXPOSE 80

WORKDIR /var/www/owncloud
# USER www-data
ENTRYPOINT ["/usr/bin/run.sh"]
