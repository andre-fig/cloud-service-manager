#!/bin/bash

# Variáveis
REPO_URL="https://github.com/usuario/repositorio.git"
PROJECT_ID="seu-projeto-id"
ZONE="us-central1-a"
VM_NAME="vm-docker-containers"
MACHINE_TYPE="e2-medium" # Ajuste conforme necessário
GITHUB_BRANCH="main" # Ajuste conforme necessário

# 1. Autenticar no Google Cloud
gcloud auth login

# 2. Configurar o projeto
gcloud config set project $PROJECT_ID

# 3. Criar uma VM com Docker instalado
gcloud compute instances create $VM_NAME \
    --zone=$ZONE \
    --machine-type=$MACHINE_TYPE \
    --image-family=cos-stable \
    --image-project=cos-cloud \
    --boot-disk-size=10GB \
    --metadata=startup-script='#! /bin/bash
        sudo apt-get update
        sudo apt-get install -y git docker.io docker-compose
        git clone '$REPO_URL' /home/docker-app
        cd /home/docker-app
        git checkout '$GITHUB_BRANCH'
        sudo docker-compose up -d
    ' \
    --tags=http-server,https-server

# 4. Configurar o firewall para expor as portas
gcloud compute firewall-rules create allow-web-traffic \
    --allow tcp:5432,tcp:6379,tcp:5672,tcp:8080 \
    --target-tags=http-server,https-server \
    --description="Permitir tráfego para PostgreSQL, Redis, RabbitMQ, e LocalStack" \
    --direction=INGRESS

echo "Containers estão sendo inicializados. Acesse as portas configuradas nas próximas instruções."
