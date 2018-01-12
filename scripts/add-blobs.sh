#!/usr/bin/env bash

set -ex

version=1.4.6

if [ ! -f "traefik-${version}_linux-amd64" -a ! -f "traefik-${version}_linux-amd64.gz" ]; then
    curl -L "https://github.com/containous/traefik/releases/download/v$version/traefik_linux-amd64" \
        -o "traefik-${version}_linux-amd64"
    echo "ce46543db09c8b885e71d8a3b89251ba4b9e1bee56f238cc05651c9eb29e32b2  traefik-${version}_linux-amd64" \
        | shasum -a 256 --check
fi

if [ -f "traefik-${version}_linux-amd64" -a ! -f "traefik-${version}_linux-amd64.gz" ]; then
    gzip -9 "traefik-${version}_linux-amd64"
fi

bosh add-blob "traefik-${version}_linux-amd64.gz" "traefik/traefik-${version}_linux-amd64.gz"
