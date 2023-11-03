#!/bin/sh
set -- $DATABASE_IPS $CLUSTER_IPS
for ip do cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  pg_auto_failover  autoctl_node  ${ip}  scram-sha-256
EOT
done
