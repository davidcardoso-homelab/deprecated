#!/bin/bash

## Se não existe, cria o diretório para o volume do Traefik
VOLUME="/volumes/hdd/docker/traefik"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Traefik..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Traefik já existe."
fi

## Se não existe, cria o volume do Traefik
if [ "$(docker volume ls -q -f name=volume_traefik)" ]; then
  echo "Docker volume para o Traefik já existe."
else
  echo "Criando Docker volume para o Traefik..."
  docker volume create --name volume_traefik --opt type=none --opt device="$VOLUME" --opt o=bind
fi
