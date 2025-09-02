#!/bin/bash

### TRAEFIK
./0-reverse-proxy/create_volume.sh

### PI-HOLE
./1-services/dns/pi-hole/create_volume.sh

### UNBOUND
./1-services/dns/unbound/create_volume.sh

### HOMARR
./1-services/homarr/create_volume.sh

### PROMETHEUS E GRAFANA
./1-services/monitoring/create_volume.sh

### JELLYFIN
./1-services/jellyfin/create_volume.sh

### QBITTORRENT
./1-services/qbittorrent/create_volume.sh

### SONARR
./1-services/sonarr/create_volumes.sh

### PROWLARR
./1-services/prowlarr/create_volumes.sh

## RADARR
./1-services/radarr/create_volumes.sh

## JELLYSEERR
./1-services/jellyseerr/create_volumes.sh

## BAZARR
./1-services/bazarr/create_volumes.sh
