cat <<EOT >> /var/postgresql/data/pg_ident.conf
pgautofailover  postgres  autoctl_node
EOT
