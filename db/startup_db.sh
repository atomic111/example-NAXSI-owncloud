#!/bin/bash

PG_MAJOR="9.4"

# init postgres database
gosu postgres /usr/lib/postgresql/$PG_MAJOR/bin/initdb

# configure postgres database
sed -i "/^#listen_addresses/i listen_addresses='*'" /etc/postgresql/$PG_MAJOR/main/postgresql.conf
sed -i 's/^ssl = true/ssl = false/g' /etc/postgresql/$PG_MAJOR/main/postgresql.conf
sed -i "/^# DO NOT DISABLE\!/i # Allow access from any IP address" /etc/postgresql/$PG_MAJOR/main/pg_hba.conf
sed -i "/^# DO NOT DISABLE\!/i host all all 0.0.0.0/0 trust\n\n\n" /etc/postgresql/$PG_MAJOR/main/pg_hba.conf

# start postgres database
gosu postgres /usr/lib/postgresql/$PG_MAJOR/bin/postgres -D /var/lib/postgresql/$PG_MAJOR/main -c config_file=/etc/postgresql/$PG_MAJOR/main/postgresql.conf
