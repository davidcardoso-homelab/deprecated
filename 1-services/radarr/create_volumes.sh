#!/bin/bash

## Se não existe, cria o diretório para o volume do Radarr
VOLUME="/volumes/ssd/docker/radarr_config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Radarr..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Radarr já existe."
fi

## Se não existe, cria o volume do Radarr
if [ "$(docker volume ls -q -f name=volume_radarr)" ]; then
  echo "Docker volume para o Radarr já existe."
else
  echo "Criando Docker volume para o Radarr..."
  docker volume create --name volume_radarr --opt type=none --opt device="$VOLUME" --opt o=bind
fi

VOLUME="/volumes/hdd/media/FILMES"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume de filmes..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume de filmes já existe."
fi

## Se não existe, cria o volume do Filmes
if [ "$(docker volume ls -q -f name=volume_filmes)" ]; then
  echo "Docker volume para o Filmes já existe."
else
  echo "Criando Docker volume para o Filmes..."
  docker volume create --name volume_filmes --opt type=none --opt device="$VOLUME" --opt o=bind
fi

