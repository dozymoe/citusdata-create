cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  pg_auto_failover  autoctl_node  10.103.0.0/16  scram-sha-256
EOT
