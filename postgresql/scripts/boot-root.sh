#!/bin/sh
exec 2>&1

groupmod -g $ACTING_GID postgres
usermod -u $ACTING_UID postgres
chown -R $ACTING_UID:$ACTING_GID /var/lib/postgresql /var/run/postgresql

export HOME=/var/lib/postgresql
exec su - postgres /boot-user.sh
