#!/usr/bin/env bash
# Detiene los contenedores (los datos se conservan en los volúmenes)
set -e
cd "$(dirname "$0")/.."

docker compose down
