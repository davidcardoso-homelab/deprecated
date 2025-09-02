# Homelab Docker Stack

Este repositório contém a infraestrutura do seu homelab, orquestrada via Docker Compose, com foco em modularidade, monitoramento, proxy reverso e serviços de DNS.

## Estrutura do Projeto

```
.
├── 0-reverse-proxy/
│   ├── create_volume.sh
│   ├── docker-compose.yaml
│   └── traefik.yaml
├── 1-services/
│   ├── bazarr/
│   │   ├── create_volumes.sh
│   │   └── docker-compose.yaml
│   ├── dns/
│   │   ├── docker-compose.yaml
│   │   ├── dnsperf/
│   │   ├── pi-hole/
│   │   └── unbound/
│   ├── homarr/
│   │   ├── create_volume.sh
│   │   └── docker-compose.yaml
│   ├── jellyfin/
│   │   ├── create_volume.sh
│   │   └── docker-compose.yaml
│   ├── jellyseerr/
│   │   ├── create_volumes.sh
│   │   └── docker-compose.yaml
│   ├── monitoring/
│   │   ├── create_volume.sh
│   │   └── ...
│   ├── prowlarr/
│   │   └── ...
│   ├── qbittorrent/
│   │   └── ...
│   ├── radarr/
│   │   └── create_volumes.sh
│   └── sonarr/
│       └── create_volumes.sh
├── create_dirs_for_volumes.sh
├── docker-compose.yaml
└── README.md
```

## Serviços Principais

- **Traefik**: Proxy reverso, roteamento e dashboard ([0-reverse-proxy/docker-compose.yaml](0-reverse-proxy/docker-compose.yaml))
- **Pi-hole**: Bloqueador de anúncios e servidor DNS ([1-services/dns/pi-hole/docker-compose.yaml](1-services/dns/pi-hole/docker-compose.yaml))
- **Unbound**: Resolver DNS recursivo ([1-services/dns/unbound/docker-compose.yaml](1-services/dns/unbound/docker-compose.yaml))
- **Homarr**: Dashboard para gerenciamento dos serviços ([1-services/homarr/docker-compose.yaml](1-services/homarr/docker-compose.yaml))
- **Prometheus**: Coleta de métricas ([1-services/monitoring/docker-compose.yaml](1-services/monitoring/docker-compose.yaml))
- **Grafana**: Visualização de métricas ([1-services/monitoring/docker-compose.yaml](1-services/monitoring/docker-compose.yaml))
- **Node Exporter**: Exportação de métricas do host ([1-services/monitoring/docker-compose.yaml](1-services/monitoring/docker-compose.yaml))
- **cAdvisor**: Métricas de containers Docker ([1-services/monitoring/docker-compose.yaml](1-services/monitoring/docker-compose.yaml))
- **Jellyfin**: Servidor de mídia ([1-services/jellyfin/docker-compose.yaml](1-services/jellyfin/docker-compose.yaml))
- **Jellyseerr**: Solicitação de mídia ([1-services/jellyseerr/docker-compose.yaml](1-services/jellyseerr/docker-compose.yaml))
- **Bazarr**: Legendas automáticas ([1-services/bazarr/docker-compose.yaml](1-services/bazarr/docker-compose.yaml))
- **Radarr**: Gerenciamento de filmes ([1-services/radarr/docker-compose.yaml](1-services/radarr/docker-compose.yaml))
- **Sonarr**: Gerenciamento de séries ([1-services/sonarr/docker-compose.yaml](1-services/sonarr/docker-compose.yaml))
- **Prowlarr**: Indexador de torrents e usenet ([1-services/prowlarr/docker-compose.yaml](1-services/prowlarr/docker-compose.yaml))
- **qBittorrent**: Cliente torrent ([1-services/qbittorrent/docker-compose.yaml](1-services/qbittorrent/docker-compose.yaml))
- **dnsperf**: Testes de performance DNS ([1-services/dns/dnsperf/](1-services/dns/dnsperf/))


## Volumes e Persistência

Os dados de cada serviço são persistidos em volumes Docker, que são mapeados para diretórios específicos no host. Os scripts `create_volume.sh` ou `create_volumes.sh` em cada serviço garantem que os diretórios e volumes existam antes de subir os containers.

Para criar todos os diretórios e volumes necessários, execute:

```sh
./create_dirs_for_volumes.sh
```

> **Atenção:**  
> Cada serviço possui seu próprio script de criação de diretórios e volumes, como [`1-services/jellyfin/create_volume.sh`](1-services/jellyfin/create_volume.sh), [`1-services/sonarr/create_volumes.sh`](1-services/sonarr/create_volumes.sh), [`1-services/radarr/create_volumes.sh`](1-services/radarr/create_volumes.sh), [`1-services/bazarr/create_volumes.sh`](1-services/bazarr/create_volumes.sh), [`1-services/jellyseerr/create_volumes.sh`](1-services/jellyseerr/create_volumes.sh), [`1-services/prowlarr/create_volumes.sh`](1-services/prowlarr/create_volumes.sh), [`1-services/qbittorrent/create_volume.sh`](1-services/qbittorrent/create_volume.sh), [`1-services/homarr/create_volume.sh`](1-services/homarr/create_volume.sh), [`1-services/monitoring/create_volume.sh`](1-services/monitoring/create_volume.sh), [`0-reverse-proxy/create_volume.sh`](0-reverse-proxy/create_volume.sh), entre outros.  
> **É fundamental revisar e ajustar os caminhos dos diretórios de volumes em cada um desses scripts conforme a estrutura de discos e partições do seu ambiente local** (por exemplo, `/volumes/ssd/docker/...` ou `/volumes/hdd/media/...`).  
> Isso garante que os volumes Docker sejam criados corretamente e os dados sejam persistidos nos locais desejados.

## Como subir o ambiente

1. Certifique-se de que os volumes estão criados:
   ```sh
   ./create_dirs_for_volumes.sh
   ```

2. Suba todos os serviços:
   ```sh
   docker compose -f docker-compose.yaml up -d
   ```

   O arquivo `docker-compose.yaml` principal faz o include dos outros arquivos de cada serviço.

## Acesso aos Serviços

- **Traefik Dashboard**: http://traefik.homelab
- **Homarr Dashboard**: http://home.homelab
- **Grafana**: http://grafana.homelab
- **Prometheus**: http://prometheus.homelab
- **Pi-hole**: http://dns.homelab
- **Jellyfin**: http://media.homelab
- **Jellyseerr**: http://jellyseerr.homelab
- **Bazarr**: http://bazarr.homelab
- **Radarr**: http://radarr.homelab
- **Sonarr**: http://sonarr.homelab
- **Prowlarr**: http://prowlarr.homelab
- **qBittorrent**: http://qbittorrent.homelab
- **Unbound**: (sem interface web, serviço de backend)
- **dnsperf**: (sem interface web, utilizado para testes internos)

> Certifique-se de configurar o DNS local ou arquivo `/etc/hosts` para resolver os domínios `.homelab` para o IP do seu servidor.

## Monitoramento

- **Prometheus** coleta métricas dos containers e do host.
- **Grafana** exibe dashboards customizáveis.
- **cAdvisor** e **Node Exporter** fornecem métricas detalhadas de containers e do sistema.

## DNS

- **Pi-hole** atua como servidor DNS principal, bloqueando anúncios.
- **Unbound** é utilizado como resolver recursivo, aumentando a privacidade e a performance.

## Scripts Úteis

- `create_dirs_for_volumes.sh`: Cria todos os diretórios e volumes necessários para persistência dos dados.
- Cada serviço possui seu próprio `create_volume.sh` ou `create_volumes.sh` para criação individual dos volumes.

## Observações

- As redes Docker são definidas para isolar e conectar os serviços conforme necessário (`proxy`, `monitoring`, `dns`).
- Os arquivos `.env` são usados para variáveis sensíveis (ex: senha da API do Pi-hole).

## Configuração de Credenciais do Pi-hole

O Pi-hole utiliza uma senha de API para acesso ao painel administrativo e integração com exportadores de métricas. Essa senha é definida por meio de um arquivo `.env` localizado em [`1-services/dns/pi-hole/.env`](1-services/dns/pi-hole/.env).  
Você pode usar o arquivo de exemplo [`1-services/dns/pi-hole/.env.sample`](1-services/dns/pi-hole/.env.sample) como base.

### Como configurar

1. Copie o arquivo de exemplo:
   ```sh
   cp 1-services/dns/pi-hole/.env.sample 1-services/dns/pi-hole/.env
   ```

2. Edite o arquivo [`1-services/dns/pi-hole/.env`](1-services/dns/pi-hole/.env):

   ```env
   PIHOLE_API_PASSWORD="sua_senha_segura_aqui"
   ```

3. Certifique-se de que o arquivo `.env` está presente antes de subir os containers do Pi-hole.

4. O valor definido em `PIHOLE_API_PASSWORD` será utilizado tanto pelo container do Pi-hole quanto pelo pihole-exporter para autenticação.

> **Dica:** Para gerar uma senha segura, você pode usar o comando abaixo no terminal:
>
> ```sh
> openssl rand -hex 16
> ```

**Importante:**  
Nunca compartilhe sua senha do Pi-hole publicamente. O arquivo `.env` pode ser adicionado ao `.gitignore` caso o