#!/bin/bash

backups_dir="backups/greenlight"

cd $(dirname $BASH_SOURCE)
docker-compose exec -T postgres pg_dumpall -c -U postgres > $backups_dir/`date +%d-%m-%Y"_"%H_%M_%S`.sql

# Keep 5 most recent backups
ls -tp $backups_dir | grep -v '/$' | tail -n +6 | xargs -I {} rm -- $backups_dir/{}

endpoint="${AWS_ENDPOINT:-https://storage.yandexcloud.net}"
profile="backup-uploader@fmp-msu-yandex-cloud"
bucket="fmp-msu-backups"

aws s3 --endpoint $endpoint --profile $profile sync $$backups_dir s3://fmp-msu-backups/metal/home/fmp/bbb/$$backups_dir

