#!/bin/bash
KAFKA_HOST=${IPSM_HOST}
KAFKA_PORT=9092
ZOOKEEPER_HOST=${IPSM_HOST}
ZOOKEEPER_PORT=2181
cat <<EOF >scripts/environment.env
NODE_ENV=production
#-----------------------------------------------------------------------------------------
# Kafka bootstrap broker(s) list (comma separated)
#-----------------------------------------------------------------------------------------
KAFKA_BOOTSTRAP_BROKERS=${KAFKA_HOST}:${KAFKA_PORT}

#-----------------------------------------------------------------------------------------
# Zookeeper bootstrap
#-----------------------------------------------------------------------------------------
ZOOKEEPER=${ZOOKEEPER_HOST}:${ZOOKEEPER_PORT}

#-----------------------------------------------------------------------------------------
# default Kafka client configuration data
#-----------------------------------------------------------------------------------------
KAFKA_CLIENT_SSL_CERT=/ssl/default-kafka-client.pem
KAFKA_CLIENT_SSL_KEY=/ssl/default-kafka-client.key
KAFKA_CLIENT_SSL_PASS=${CLIENT_PASS}
#-------------------------------------------------------------
# needed since we are using self-signed certificate for Kafka
KAFKA_CA_CERT=/ssl/ca-cert

#-----------------------------------------------------------------------------------------
# full path to kafkacat with all possible "-X ..." configuration parameters
#-----------------------------------------------------------------------------------------
KAFKACAT=/usr/local/bin/kafkacat -X security.protocol=ssl -X ssl.ca.location=/ssl/ca-cert -X ssl.certificate.location=/ssl/default-kafka-client.pem -X ssl.key.location=/ssl/default-kafka-client.key -X ssl.key.password='${CLIENT_PASS}'

#-----------------------------------------------------------------------------------------
# URL address for the IPSM API
#-----------------------------------------------------------------------------------------
IPSM_API_URL=http://${IPSM_HOST}:${IPSM_PORT}/
EOF

. ./scripts/initialize-volume.sh
cat << EOF

IPSM Dashboard docker compose configuration created successfully.

    Usage: docker-compose up  -d

EOF
