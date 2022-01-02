#!/usr/bin/env bash

set -ex

version="1.7.34"

if [ ! -f "traefik-${version}_linux-amd64" -a ! -f "traefik-${version}_linux-amd64.gz" ]; then
    curl -L "https://github.com/containous/traefik/releases/download/v$version/traefik_linux-amd64" \
        -o "traefik-${version}_linux-amd64"
    echo "54fc261ff3ebb2568c9e32e6ae665d6f22e4c922a2c11b348771d5b143226ef1  traefik-${version}_linux-amd64" \
        | shasum -a 256 --check
fi

if [ -f "traefik-${version}_linux-amd64" -a ! -f "traefik-${version}_linux-amd64.gz" ]; then
    gzip -9 "traefik-${version}_linux-amd64"
fi

bosh add-blob "traefik-${version}_linux-amd64.gz" "traefik/traefik-${version}_linux-amd64.gz"
