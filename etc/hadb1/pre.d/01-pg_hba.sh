#!/bin/sh
set -- $DATABASE_IPS $CLUSTER_IPS
for ip do cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  citus  postgres  ${ip}  trust
EOT
done

set -- $DATABASE_IPS
for ip do cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  replication  pgautofailover_replicator  ${ip}  trust
hostssl  citus  pgautofailover_replicator  ${ip}  trust
EOT
done
