#!/bin/sh
set -e
# sh ./wait_for_mysql.sh
# https://github.com/ufoscout/docker-compose-wait
# https://stackoverflow.com/questions/35069027/docker-wait-for-postgresql-to-be-running
echo "waiting for database..."
bash -c 'while !</dev/tcp/${DB_HOST}/5432; do sleep 1; done; echo "connection established"'
echo "connection successfully established"

if [ "$CLEAR_CHECK_SUMS" = "true" ]
then
  echo "clear check sums..."
  sh ./liquibase clearCheckSums
fi

echo "Try to execute liquibase..."
envsubst < liquibase_template.properties > ./liquibase.properties
sh ./liquibase update --defaultsFile ./liquibase.properties
echo "Done"

exec "$@"