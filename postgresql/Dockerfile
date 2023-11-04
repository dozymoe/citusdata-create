FROM postgres:15

ARG CITUS_VER=12.0

# These files can become huge, gigabytes, bug in docker
# See: https://github.com/sagemathinc/cocalc/issues/2287
RUN rm /var/log/faillog /var/log/lastlog

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl procps iputils-ping vim-tiny

RUN apt-get update && apt-get install -y \
        pg-auto-failover-cli \
        postgresql-15-auto-failover

# CitusData
RUN curl -s https://install.citusdata.com/community/deb.sh | bash
RUN apt-get update && apt-get install -y \
        postgresql-15-citus-$CITUS_VER \
        postgresql-15-hll \
        postgresql-15-topn
RUN echo "shared_preload_libraries='citus,pgautofailover'" \
        >> /usr/share/postgresql/postgresql.conf.sample

RUN apt-get autoclean -y && rm -rf /var/lib/apt/lists/*

#HEALTHCHECK &{["CMD-SHELL" "./pg_healthcheck"] "4s" "0s" "6s" '\x00'}

