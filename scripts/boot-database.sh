#!/bin/sh
exec 2>&1

if [ -e /tmp/pg_autoctl/var/postgresql/data/pg_autoctl.pid ]
then
    rm /tmp/pg_autoctl/var/postgresql/data/pg_autoctl.pid
fi

test ! -e /var/postgresql/data/pg_hba.conf
INITIALIZE_DB=$?

pg_autoctl create coordinator --ssl-self-signed \
    --hostname=$(hostname) --pgport=${DATABASE_PORT} --name=${PG_NAME} \
    --skip-pg-hba

. /boot-common.sh

if [ $INITIALIZE_DB -eq 0 ]
then
    docker_process_init_files /initdb.pre.d/*
fi

pg_autoctl run &
PID=$!

if [ $INITIALIZE_DB -eq 0 ]
then
    until pg_isready -p ${DATABASE_PORT}
    do
        sleep 10
    done
    docker_process_init_files /initdb.post.d/*
fi

wait
