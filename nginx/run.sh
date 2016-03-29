#!/usr/bin/env bash
# encoding: utf-8
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

set -e

if [ ! -f /var/www/owncloud/config/config.php ]; then

    # create autoconfig.php for owncloud

    echo -e '<?php' >> /var/www/owncloud/config/autoconfig.php
    echo -e '$AUTOCONFIG = array(' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "dbtype"        => "pgsql",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "dbname"        => "owncloud",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "dbuser"        => "postgres",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "dbpass"        => "",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "dbhost"        => "postgres",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "dbtableprefix" => "",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "adminlogin"    => "admin",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "adminpass"     => "admin",' >> /var/www/owncloud/config/autoconfig.php
    echo -e '  "directory"     => "/var/www/owncloud/data",' >> /var/www/owncloud/config/autoconfig.php
    echo -e ');' >> /var/www/owncloud/config/autoconfig.php

    # create config.php for owncloud

    echo -e "<?php" >> /var/www/owncloud/config/config.php
    echo -e "\$CONFIG = array (" >> /var/www/owncloud/config/config.php
    echo -e "  'memcache.local' => '\\OC\\Memcache\\APCu'," >> /var/www/owncloud/config/config.php
    echo -e "   'forcessl' => false," >> /var/www/owncloud/config/config.php
    echo -e "  'session_lifetime' => 60 * 15 * 1," >> /var/www/owncloud/config/config.php
    #Multiple Domains Reverse SSL Proxy
    #echo -e "  'overwritehost' => 'yourdomain.de'," >> /var/www/owncloud/config/config.php
    #echo -e "  'overwriteprotocol' => 'https'," >> /var/www/owncloud/config/config.php
    #echo -e "  'overwritewebroot' => '/'," >> /var/www/owncloud/config/config.php
    #echo -e "  'overwritecondaddr' => '^10\.0\.0\.1$'," >> /var/www/owncloud/config/config.php
    echo -e ");" >> /var/www/owncloud/config/config.php
fi

# BUG: https://forum.owncloud.org/viewtopic.php?t=30540&p=97096
#curl -o /var/www/owncloud/config/ca-bundle.crt https://raw.githubusercontent.com/owncloud/core/stable8.1/config/ca-bundle.crt

# configure bigger filesize for upload
#sed -i -e "s/^php_value upload_max_filesize\s*513M/php_value upload_max_filesize 10G/" /var/www/owncloud/.htaccess
#sed -i -e "s/^php_value post_max_size 513M/php_value post_max_size 10G/" /var/www/owncloud/.htaccess

#sed -i -e "s/^upload_max_filesize=513M/upload_max_filesize=10G/" /var/www/owncloud/.user.ini
#sed -i -e "s/^post_max_size=513M/post_max_size=10G/" /var/www/owncloud/.user.ini

chown -R www-data:www-data /var/www/owncloud/config/

supervisord
