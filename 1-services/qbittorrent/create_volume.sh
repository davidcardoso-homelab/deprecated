#!/bin/bash

## Se não existe, cria o diretório para o volume do qBittorrent
VOLUME="/volumes/ssd/docker/qbittorrent_config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do qBittorrent..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do qBittorrent já existe."
fi

## Se não existe, cria o volume do qBittorrent
if [ "$(docker volume ls -q -f name=volume_qbittorrent)" ]; then
  echo "Docker volume para o qBittorrent já existe."
else
  echo "Criando Docker volume para o qBittorrent..."
  docker volume create --name volume_qbittorrent --opt type=none --opt device="$VOLUME" --opt o=bind
fi


VOLUME="/volumes/hdd/media/downloads"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume de downloads..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume de downloads já existe."
fi

## Se não existe, cria o volume do qBittorrent
if [ "$(docker volume ls -q -f name=volume_downloads)" ]; then
  echo "Docker volume para o volume de downloads já existe."
else
  echo "Criando Docker volume para o volume de downloads..."
  docker volume create --name volume_downloads --opt type=none --opt device="$VOLUME" --opt o=bind
fi
