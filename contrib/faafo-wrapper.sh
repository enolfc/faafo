#!/bin/bash

# use the rabbitmq linked in docker
if [ "x$TRANSPORT_URL" = "x" ]; then
    if [ "x$RABBITMQ_PORT_5672_TCP_PORT" != "x" ]; then
        TRANSPORT_URL="amqp://guest:guest@rabbitmq:${RABBITMQ_PORT_5672_TCP_PORT}/"
    else
        TRANSPORT_URL='amqp://guest:guest@localhost:5672/'
    fi
fi

if [ "x$ENDPOINT_URL" = "x" ]; then
    if [ x"$API_PORT" != "x" ]; then
        ENDPOINT_URL="http://api:${API_PORT_80_TCP_PORT}"
    else
        ENDPOINT_URL='http://127.0.0.1'
    fi
fi


sed -i -e "s#transport_url = .*#transport_url = $TRANSPORT_URL#" /etc/faafo/faafo.conf
sed -i -e "s#database_url = .*#database_url = $DATABASE_URL#" /etc/faafo/faafo.conf
sed -i -e "s#endpoint_url = .*#endpoint_url = $ENDPOINT_URL#" /etc/faafo/faafo.conf

exec "$@"
