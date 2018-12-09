#!/bin/bash
echo "Setting up named volume for Dashboard SSL configuration..."
docker volume rm -f dashboard-ssl #> /dev/null 2>&1
docker volume create dashboard-ssl #> /dev/null 2>&1
echo "Volume created"
echo "Populating volume..."
docker run -v dashboard-ssl:/data --name helper busybox true
docker cp ${SSL}/client/default-kafka-client.key helper:/data
docker cp ${SSL}/client/default-kafka-client.pem helper:/data
docker cp ${SSL}/ca/ca-cert helper:/data
docker rm helper  #> /dev/null 2>&1
echo "...done"
