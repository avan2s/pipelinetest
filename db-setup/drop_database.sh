#!/bin/sh
set -e
# sh ./wait_for_mysql.sh
# https://github.com/ufoscout/docker-compose-wait
# https://stackoverflow.com/questions/35069027/docker-wait-for-postgresql-to-be-running
echo "waiting for database..."
bash -c 'while !</dev/tcp/postgres/5432; do sleep 1; done; echo "connection established"'
echo "connection successfully established"

if [ ! -f ./liquibase.properties ]; then
echo "interpolate liquibase environment variables as liquibase properties"
envsubst < liquibase_template.properties > liquibase.properties
fi 

echo "try to drop database..."
sh ./liquibase drop-all
echo "try to drop database... Done"

exec "$@"