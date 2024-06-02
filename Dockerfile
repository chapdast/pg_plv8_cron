FROM sibedge/postgres-plv8:16.2-3.2.2 AS plv8 

ARG PG_CRON_VERSION=1.6.2
RUN apk add --no-cache --virtual .build-deps build-base ca-certificates openssl tar clang15 llvm15
RUN wget -O /pg_cron-$PG_CRON_VERSION.tgz https://github.com/citusdata/pg_cron/archive/v$PG_CRON_VERSION.tar.gz 
RUN tar xvzf /pg_cron-$PG_CRON_VERSION.tgz

WORKDIR /pg_cron-$PG_CRON_VERSION
RUN sed -i.bak -e 's/-Werror//g' Makefile 
RUN sed -i.bak -e 's/-Wno-implicit-fallthrough//g' Makefile
RUN make
RUN make install 
WORKDIR /
RUN rm -rf pg_cron-$PG_CRON_VERSION.tgz && rm -rf pg_cron-*

CMD ["-c", "shared_preload_libraries=pg_cron", "-c", "cron.database_name=postgres"]