#!/usr/bin/env sh
set -eu

cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.template

envsubst '${RELATIVE_URL_ROOT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

rm /etc/nginx/conf.d/default.conf.template

exec "$@"
