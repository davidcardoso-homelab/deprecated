#!/bin/bash

## Se não existe, cria o diretório para o volume do Pi-hole
VOLUME="/volumes/hdd/docker/pihole"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Pi-hole..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Pi-hole já existe."
fi

## Se não existe, cria o volume do Pi-hole
if [ "$(docker volume ls -q -f name=volume_pihole)" ]; then
  echo "Docker volume para o Pi-hole já existe."
else
  echo "Criando Docker volume para o Pi-hole..."
  docker volume create --name volume_pihole --opt type=none --opt device="$VOLUME" --opt o=bind
fi
