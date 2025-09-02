#!/bin/bash

## Se não existe, cria o diretório para o volume do Homarr
VOLUME="/volumes/hdd/docker/homarr"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Homarr..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Homarr já existe."
fi

## Se não existe, cria o volume do Homarr
if [ "$(docker volume ls -q -f name=volume_homarr)" ]; then
  echo "Docker volume para o Homarr já existe."
else
  echo "Criando Docker volume para o Homarr..."
  docker volume create --name volume_homarr --opt type=none --opt device="$VOLUME" --opt o=bind
fi
