cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  replication  pgautofailover_replicator  hadb2.test  scram-sha-256  map=pgautofailover
EOT
