#!/bin/bash

# Define where we want to output our private key and certificate
SSL_DIR="app/nginx/certs"
PRIVATE_KEY="${SSL_DIR}/selfsigned.key"
CERTIFICATE="${SSL_DIR}/selfsigned.crt"

# Generate a new private key if one doesn't already exist
if [ ! -f "$PRIVATE_KEY" ]; then
    openssl genrsa -out "$PRIVATE_KEY" 2048
fi

# Generate a new self-signed certificate
openssl req -new -x509 -key "$PRIVATE_KEY" -out "$CERTIFICATE" -days 365 -subj "/CN=localhost" -nodes