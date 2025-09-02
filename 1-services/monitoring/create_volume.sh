#!/bin/bash

## Se não existe, cria o diretório para o volume do Prometheus
VOLUME="/volumes/ssd/docker/prometheus"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Prometheus..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Prometheus já existe."
fi

## Se não existe, cria o volume do Prometheus
if [ "$(docker volume ls -q -f name=volume_prometheus)" ]; then
  echo "Docker volume para o Prometheus já existe."
else
  echo "Criando Docker volume para o Prometheus..."
  docker volume create --name volume_prometheus --opt type=none --opt device="$VOLUME" --opt o=bind
fi

## Se não existe, cria o diretório para o volume do Grafana
VOLUME="/volumes/hdd/docker/grafana"
if [ ! -d "$VOLUME" ]; then
  echo "Criando diretório para o volume do Grafana..."
  mkdir -p "$VOLUME"
  chmod 777 "$VOLUME"
else
  echo "Diretório para o volume do Grafana já existe."
fi

## Se não existe, cria o volume do Grafana
if [ "$(docker volume ls -q -f name=volume_grafana)" ]; then
  echo "Docker volume para o Grafana já existe."
else
  echo "Criando Docker volume para o Grafana..."
  docker volume create --name volume_grafana --opt type=none --opt device="$VOLUME" --opt o=bind
fi
