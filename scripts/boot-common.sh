#!/bin/sh

# usage: docker_process_init_files [file [file [...]]]
#    ie: docker_process_init_files /always-initdb.d/*
# process initializer files, based on file extensions and permissions
docker_process_init_files() {
    # psql here for backwards compatibility "${psql[@]}"
    psql=( docker_process_sql )

    printf '\n'
    local f
    for f; do
        case "$f" in
            *.sh)
                # https://github.com/docker-library/postgres/issues/450#issuecomment-393167936
                # https://github.com/docker-library/postgres/pull/452
                if [ -x "$f" ]; then
                    printf '%s: running %s\n' "$0" "$f"
                    "$f"
                else
                    printf '%s: sourcing %s\n' "$0" "$f"
                    . "$f"
                fi
                ;;
            *.sql)     printf '%s: running %s\n' "$0" "$f"; docker_process_sql -f "$f"; printf '\n' ;;
            *.sql.gz)  printf '%s: running %s\n' "$0" "$f"; gunzip -c "$f" | docker_process_sql; printf '\n' ;;
            *.sql.xz)  printf '%s: running %s\n' "$0" "$f"; xzcat "$f" | docker_process_sql; printf '\n' ;;
            *.sql.zst) printf '%s: running %s\n' "$0" "$f"; zstd -dc "$f" | docker_process_sql; printf '\n' ;;
            *)         printf '%s: ignoring %s\n' "$0" "$f" ;;
        esac
        printf '\n'
    done
}

# Execute sql script, passed via stdin (or -f flag of pqsl)
# usage: docker_process_sql [psql-cli-args]
#    ie: docker_process_sql --dbname=mydb <<<'INSERT ...'
#    ie: docker_process_sql -f my-file.sql
#    ie: docker_process_sql <my-file.sql
docker_process_sql() {
    local query_runner=( psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --no-password --no-psqlrc )
    if [ -n "$POSTGRES_DB" ]; then
        query_runner+=( --dbname "$POSTGRES_DB" )
    fi

    PGHOST= PGHOSTADDR= "${query_runner[@]}" "$@"
}
