#!/bin/sh

docker run -d --name pgpvl8cron -e POSTGRES_PASSWORD=password -p 5432:5432 -d chapdast/pg-plv8-cron
