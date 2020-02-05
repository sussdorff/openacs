#!/bin/sh
# wait-for-postgres.sh

set -e

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "postgres" -U "openacs" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - Starting OpenACS Now"

/usr/local/ns/bin/nsd -f -u nsadmin -g nsadmin -t /usr/local/ns/conf/openacs-config.tcl
