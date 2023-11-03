cat <<EOT >> /var/postgresql/data/pg_hba.conf
hostssl  citus  postgres  10.103.0.0/16  trust
EOT
