# vim:set ft=dockerfile:
# encoding: utf-8
#
# Nginx - Naxsi Dockerfile
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

# get build essentials

RUN apt-get update \
    && apt-get install -y supervisor curl python-pip python-geoip python-twisted-web openssl gcc unzip build-essential \
    && apt-get build-dep -y nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Enviroment Variables

ENV LEARNING_MODE no
ENV BUILD_PATH /opt
ENV PROXY_REDIRECT_IP 12.12.12.12
ENV NGINX_VERSION 1.9.6
ENV NAXSI_VERSION master
ENV OPENSSL_VERSION 1.0.2g
ENV PCRE_VERSION 8.37
ENV CLEAR_HEADER_VERSION 0.29

# download sources

WORKDIR ${BUILD_PATH}

RUN curl -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    curl -O ftp://ftp.pca.dfn.de/pub/tools/net/openssl/source//openssl-${OPENSSL_VERSION}.tar.gz && \
    curl -O http://ftp.cs.stanford.edu/pub/exim/pcre/pcre-${PCRE_VERSION}.tar.gz && \
    curl -LO https://github.com/nbs-system/naxsi/archive/${NAXSI_VERSION}.tar.gz && \
    curl -LO https://github.com/openresty/headers-more-nginx-module/archive/v${CLEAR_HEADER_VERSION}.tar.gz

RUN tar xzf nginx-${NGINX_VERSION}.tar.gz && \
    tar xzf ${NAXSI_VERSION}.tar.gz && \
    tar xzf openssl-${OPENSSL_VERSION}.tar.gz && \
    tar xzf pcre-${PCRE_VERSION}.tar.gz && \
    tar xzf v${CLEAR_HEADER_VERSION}.tar.gz && \
	  rm *.tar.gz

# Build Nginx with Naxsi
RUN cd ${BUILD_PATH}/nginx-${NGINX_VERSION} && ./configure \
         --conf-path=/etc/nginx/nginx.conf \
         --add-module=../naxsi-${NAXSI_VERSION}/naxsi_src/ \
         --add-module=${BUILD_PATH}/headers-more-nginx-module-${CLEAR_HEADER_VERSION} \
         --error-log-path=/var/log/nginx/error.log \
         --with-openssl=${BUILD_PATH}/openssl-${OPENSSL_VERSION} \
         --with-pcre=${BUILD_PATH}/pcre-${PCRE_VERSION} \
         --http-client-body-temp-path=/var/lib/nginx/body \
         --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
         --http-log-path=/var/log/nginx/access.log \
         --http-proxy-temp-path=/var/lib/nginx/proxy \
         --lock-path=/var/lock/nginx.lock \
         --pid-path=/var/run/nginx.pid \
         --with-http_ssl_module \
         --with-file-aio \
         --with-http_gzip_static_module \
         --with-http_stub_status_module \
         --with-ipv6 \
         --without-mail_pop3_module \
         --without-mail_smtp_module \
         --without-mail_imap_module \
         --without-http_uwsgi_module \
         --without-http_scgi_module \
         --without-http_autoindex_module \
         --without-http_ssi_module \
         --prefix=/usr

RUN cd ${BUILD_PATH}/nginx-${NGINX_VERSION} && make && make install
RUN mkdir /var/lib/nginx

# Install nxapi / nxtool

RUN cd /${BUILD_PATH}/naxsi-${NAXSI_VERSION} && \
     cp naxsi_config/naxsi_core.rules /etc/nginx/ && \
     cd nxapi && \
     pip install -r requirements.txt && \
     python setup.py install

# Configure supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY dhparam4096.pem /etc/ssl/nginx/dhparam.pem
COPY server.crt /etc/ssl/nginx/ssl.crt
COPY server.key /etc/ssl/nginx/ssl.key
COPY naxsi_core.rules /etc/nginx/naxsi_core.rules
COPY web_server.rules /etc/nginx/web_server.rules
COPY scanner.rules /etc/nginx/scanner.rules
COPY naxsi.rules /etc/nginx/naxsi.rules
COPY nxapi.json /etc/nginx/nxapi.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY naxsi_spec.rules /etc/nginx/naxsi_spec.rules
COPY naxsi_main.rules /etc/nginx/naxsi_main.rules
COPY naxsi_whitelist.rules /etc/nginx/naxsi_whitelist.rules

EXPOSE 443

COPY run.sh /run.sh
RUN chmod 755 /run.sh

ENTRYPOINT ["/run.sh"]
