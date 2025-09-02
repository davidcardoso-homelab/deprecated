#!/bin/bash

## Se não existe, cria o diretório para o volume do Prowlarr
VOLUME="/volumes/ssd/docker/prowlarr_config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Prowlarr..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Prowlarr já existe."
fi

## Se não existe, cria o volume do Prowlarr
if [ "$(docker volume ls -q -f name=volume_prowlarr)" ]; then
  echo "Docker volume para o Prowlarr já existe."
else
  echo "Criando Docker volume para o Prowlarr..."
  docker volume create --name volume_prowlarr --opt type=none --opt device="$VOLUME" --opt o=bind
fi
