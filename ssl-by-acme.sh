#!/bin/env bash

domain="denilai-2.duckdns.org"

sudo groupadd ssl
sudo usermod -aG ssl "$USER"

sudo apt update && sudo apt install socat curl -y

sudo mkdir -p "/etc/ssl/xray/$domain"
sudo chown "$USER:ssl" /etc/ssl/xray -R

curl https://get.acme.sh | sh

export PATH="$HOME/.acme.sh":$PATH
export DuckDNS_Token="token"

acme.sh --register-account -m kirill_denisov_2000@outlook.com
acme.sh --issue --dns dns_duckdns -d denilai-2.duckdns.org --ecc --dnssleep 60

acme.sh --install-cert -d denilai-2.duckdns.org --fullchain-file /etc/ssl/xray/denilai.duckdns.org/fullchain.pem --key-file /etc/ssl/xray/denilai.duckdns.org/private.key --reloadcmd "sudo chown walter:ssl -R /etc/ssl/xray && marzban restart"
