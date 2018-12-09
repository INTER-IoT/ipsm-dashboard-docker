#!/bin/bash
. config.env

SSL=${SSL_CONFIG}/certs
CFG=scripts/environment.env

if ([ -e ${SSL}/client/default-kafka-client.key ] && [ -e ${SSL}/client/default-kafka-client.pem ] && [ -e ${SSL}/ca/ca-cert ])
then
    if [ -e ${CFG} ]
    then
        rm ${CFG}
    fi
    . ${SSL_CONFIG}/config.env
    . scripts/environment.sh
else
    . scripts/missing-config.sh
fi
