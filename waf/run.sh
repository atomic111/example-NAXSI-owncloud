#!/usr/bin/env bash

set -e

if [ x${PROXY_REDIRECT_IP} = x"12.12.12.12" ]; 	then
    echo "You need to set the PROXY_REDIRECT_IP env variable"
    echo "Run the following command:"
	  echo "    docker run -e PROXY_REDIRECT_IP=<ip_to_application> -p 443:443  naxsi"
    exit 1
else
    sed -i "s#proxy_redirect_ip#${PROXY_REDIRECT_IP}#" /etc/nginx/nginx.conf
fi

if [ x${LEARNING_MODE} != x"yes" ]; then
    sed -i 's/LearningMode;//g' /etc/nginx/naxsi.rules
    echo "Production mode, the LearningMode is disabled and is blocking malicious requests"
else
    echo "LearningMode is enabled"
fi
echo "Naxsi validate requests of the application $PROXY_REDIRECT_IP"

supervisord
