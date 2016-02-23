# vim:set ft=dockerfile:
# encoding: utf-8
#
# postgres Dockerfile
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

RUN groupadd -r postgres && useradd -r -g postgres postgres

ENV PG_MAJOR 9.4

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV LANG en_US.utf8

# grab gosu for easy step-down from root

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
	&& curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install postgresql

RUN apt-get update \
	&& apt-get install -y postgresql-$PG_MAJOR \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# specify environment for postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/$PG_MAJOR/main

#bugfix: could not open temporary statistics file /var/run/postgresql/9.4-main.pg_stat_tmp/global.tmp: No such file or directory

RUN mkdir -p /var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp
RUN chown postgres.postgres /var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp -R

# Add VOLUMEs to allow backup of  databases cluster

VOLUME ["/var/lib/postgresql/"]

# Expose the PostgreSQL port
EXPOSE 5432

COPY startup_db.sh /
ENTRYPOINT ["/startup_db.sh"]

# Set the default command to run when starting the container
CMD ["postgres"]
