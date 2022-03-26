#!/bin/bash

cd $(dirname $BASH_SOURCE)
docker-compose exec postgres pg_dumpall -c -U postgres > backups/greenlight/`date +%d-%m-%Y"_"%H_%M_%S`.sql

endpoint="${AWS_ENDPOINT:-https://storage.yandexcloud.net}"
profile="backup-uploader@fmp-msu-yandex-cloud"
bucket="fmp-msu-backups"

aws s3 --endpoint $endpoint --profile $profile sync backups/greenlight s3://fmp-msu-backups/metal/home/fmp/bbb/backups/greenlight

