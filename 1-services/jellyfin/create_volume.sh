#!/bin/bash

## Se não existe, cria o diretório para o volume do Jellyfin
VOLUME="/volumes/ssd/docker/jellyfin/config"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Jellyfin..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Jellyfin já existe."
fi

## Se não existe, cria o volume do Jellyfin
if [ "$(docker volume ls -q -f name=volume_jellyfin)" ]; then
  echo "Docker volume para o Jellyfin já existe."
else
  echo "Criando Docker volume para o Jellyfin..."
  docker volume create --name volume_jellyfin_config --opt type=none --opt device="$VOLUME" --opt o=bind
fi

## Se não existe, cria o diretório para o volume do Jellyfin
VOLUME="/volumes/ssd/docker/jellyfin/cache"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Jellyfin..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Jellyfin já existe."
fi

## Se não existe, cria o volume do Jellyfin
if [ "$(docker volume ls -q -f name=volume_jellyfin_cache)" ]; then
  echo "Docker volume para o Jellyfin já existe."
else
  echo "Criando Docker volume para o Jellyfin..."
  docker volume create --name volume_jellyfin_cache --opt type=none --opt device="$VOLUME" --opt o=bind
fi

## Se não existe, cria o diretório para o volume de medias
VOLUME="/volumes/hdd/media/"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume de medias..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume de medias já existe."
fi

## Se não existe, cria o volume do medias
if [ "$(docker volume ls -q -f name=volume_media)" ]; then
  echo "Docker volume para o medias já existe."
else
  echo "Criando Docker volume para o medias..."
  docker volume create --name volume_media --opt type=none --opt device="$VOLUME" --opt o=bind
fi
