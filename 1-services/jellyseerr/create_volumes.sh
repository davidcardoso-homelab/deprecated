#!/bin/bash

## Se não existe, cria o diretório para o volume do Jellyseerr
VOLUME="/volumes/ssd/docker/jellyseerr_config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Jellyseerr..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Jellyseerr já existe."
fi

## Se não existe, cria o volume do Jellyseerr
if [ "$(docker volume ls -q -f name=volume_jellyseerr)" ]; then
  echo "Docker volume para o Jellyseerr já existe."
else
  echo "Criando Docker volume para o Jellyseerr..."
  docker volume create --name volume_jellyseerr --opt type=none --opt device="$VOLUME" --opt o=bind
fi
