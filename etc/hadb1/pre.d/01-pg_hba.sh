cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  replication  pgautofailover_replicator  10.103.0.0/16  trust
hostssl  citus  pgautofailover_replicator  10.103.0.0/16  trust
hostssl  citus  postgres  10.103.0.0/16  trust
EOT
