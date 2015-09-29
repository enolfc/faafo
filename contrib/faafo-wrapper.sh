#!/bin/bash

URL_MESSAGING='amqp://guest:guest@localhost:5672/'
URL_DATABASE='sqlite:////tmp/sqlite.db'
URL_ENDPOINT='http://127.0.0.1'

# use the rabbitmq linked in docker
if [ "x$RABBITMQ_PORT_5672_TCP_PORT" != "x" ]; then
    URL_MESSAGING="amqp://guest:guest@rabbitmq:${RABBITMQ_PORT_5672_TCP_PORT}/"
fi

if [ x"$API_PORT" != "x" ]; then
    URL_ENDPOINT="http://api:${API_PORT_80_TCP_PORT}"
fi


sed -i -e "s#transport_url = .*#transport_url = $URL_MESSAGING#" /etc/faafo/faafo.conf
sed -i -e "s#database_url = .*#database_url = $URL_DATABASE#" /etc/faafo/faafo.conf
sed -i -e "s#endpoint_url = .*#endpoint_url = $URL_ENDPOINT#" /etc/faafo/faafo.conf

exec "$@"
