#!/bin/bash

## Se não existe, cria o diretório para o volume do Unbound
VOLUME="/volumes/ssd/docker/unbound"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Unbound..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Unbound já existe."
fi

## Se não existe, cria o volume do Unbound
if [ "$(docker volume ls -q -f name=volume_unbound)" ]; then
  echo "Docker volume para o Unbound já existe."
else
  echo "Criando Docker volume para o Unbound..."
  docker volume create --name volume_unbound --opt type=none --opt device="$VOLUME" --opt o=bind
fi
