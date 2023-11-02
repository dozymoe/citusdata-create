cat <<EOT >> /var/postgresql/data/pg_ident.conf
pgautofailover  postgres  pgautofailover_replicator
EOT
