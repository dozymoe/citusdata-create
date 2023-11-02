#!/bin/sh
exec 2>&1

groupmod -g $ACTING_GID postgres
usermod -u $ACTING_UID postgres
chown -R $ACTING_UID:$ACTING_GID /var/lib/postgresql /var/run/postgresql

# Don't forget to pass down the environment!
cat <<EOT >> /etc/environment
PGDATA=${PGDATA}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
MONITOR_PASSWORD=${MONITOR_PASSWORD}
REPLICATION_PASSWORD=${REPLICATION_PASSWORD}
DATABASE_PORT=${DATABASE_PORT}
MONITOR_PORT=${MONITOR_PORT}
CLUSTER_PORT=${CLUSTER_PORT}
PG_NAME=${PG_NAME}
PG_AUTOCTL_MONITOR=${PG_AUTOCTL_MONITOR}
EOT

exec su - postgres /boot-user.sh