#!/bin/bash

# Espera até que o LocalStack esteja disponível
until curl -s http://localhost:4566 > /dev/null; do
  echo "Aguardando o LocalStack iniciar..."
  sleep 2
done

# Cria o bucket S3
aws --endpoint-url=http://localhost:4566 s3 mb s3://tcsg-local-public-files/
