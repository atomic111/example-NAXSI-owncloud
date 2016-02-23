#!/bin/bash

# Generate private key
echo "generate private key"
openssl genrsa -aes256 -out server.key 4096


# Generate a CSR (Certificate Signing Request)
echo "generate a CSR"
openssl req -new -key server.key -out server.csr


# Remove Passphrase from Key
echo "remove passphrase from key"
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key


# Generating a Self-Signed Certificate
echo "generate self-signed cert"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt


#Concatenate the cert with the key file and then have OpenSSL convert it to PKCS#12
echo "create PKCS12"
openssl pkcs12 -export -nodes -name owncloud -in server.crt -inkey server.key -out owncloud.p12


# verify work
echo "verify work"
keytool -v -list -storetype pkcs12 -keystore owncloud.p12

# create dhparam
echo "generate dhparam"
openssl dhparam -out dhparam.pem 4096

#one liner
#  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/example/example.key  -out /etc/ssl/example/example.crt
