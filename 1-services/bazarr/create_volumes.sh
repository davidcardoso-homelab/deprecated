#!/bin/bash

## Se não existe, cria o diretório para o volume do Bazarr
VOLUME="/volumes/ssd/docker/bazarr_config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Bazarr..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Bazarr já existe."
fi

## Se não existe, cria o volume do Bazarr
if [ "$(docker volume ls -q -f name=volume_bazarr)" ]; then
  echo "Docker volume para o Bazarr já existe."
else
  echo "Criando Docker volume para o Bazarr..."
  docker volume create --name volume_bazarr --opt type=none --opt device="$VOLUME" --opt o=bind
fi
