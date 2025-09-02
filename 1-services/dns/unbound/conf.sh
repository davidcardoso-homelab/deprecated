#!/bin/bash
sudo sysctl -w net.core.rmem_max=16777216
sudo sysctl -w net.core.wmem_max=16777216

#sudo crontab -e
#@monthly docker compose run --rm init-unbound
