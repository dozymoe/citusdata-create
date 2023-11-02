#!/bin/sh
echo "ALTER USER autoctl_node PASSWORD '${MONITOR_PASSWORD}'" | psql -p ${MONITOR_PORT}
