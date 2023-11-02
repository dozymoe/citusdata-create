cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  pg_auto_failover  autoctl_node  hadb1.test  scram-sha-256  map=pgautofailover
hostssl  pg_auto_failover  autoctl_node  hadb2.test  scram-sha-256  map=pgautofailover
EOT
