#!/bin/sh

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Create the SSL directory if it doesn't exist
mkdir -p /etc/nginx/ssl

SSL_KEY_NAME="inception.key"
SSL_CERT_NAME="inception.crt"


# Check if SSL key and certificate already exist
if [ ! -f /etc/nginx/ssl/${SSL_KEY_NAME} ] || [ ! -f /etc/nginx/ssl/${SSL_CERT_NAME} ]; then
    # Generate SSL key and certificate
    openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/nginx/ssl/${SSL_KEY_NAME} -out /etc/nginx/ssl/${SSL_CERT_NAME} -days 365 \
        -subj "/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCATION}/O=${SSL_ORGANIZATION}/OU=${SSL_ORG_UNIT}/CN=${SSL_COMMON_NAME}"
fi
make