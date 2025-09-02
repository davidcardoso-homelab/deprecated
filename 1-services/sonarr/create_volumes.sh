#!/bin/bash

## Se não existe, cria o diretório para o volume do Sonarr
VOLUME="/volumes/ssd/docker/sonarr_config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Sonarr..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Sonarr já existe."
fi

## Se não existe, cria o volume do Sonarr
if [ "$(docker volume ls -q -f name=volume_sonarr)" ]; then
  echo "Docker volume para o Sonarr já existe."
else
  echo "Criando Docker volume para o Sonarr..."
  docker volume create --name volume_sonarr --opt type=none --opt device="$VOLUME" --opt o=bind
fi

VOLUME="/volumes/hdd/media/SERIES"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume de séries..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume de séries já existe."
fi

## Se não existe, cria o volume do Séries
if [ "$(docker volume ls -q -f name=volume_series)" ]; then
  echo "Docker volume para o Séries já existe."
else
  echo "Criando Docker volume para o Séries..."
  docker volume create --name volume_series --opt type=none --opt device="$VOLUME" --opt o=bind
fi

