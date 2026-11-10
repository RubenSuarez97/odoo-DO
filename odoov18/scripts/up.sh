#!/usr/bin/env bash
# Levanta Odoo 18 + PostgreSQL en segundo plano
set -e
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

docker compose up -d
echo ""
echo "Odoo disponible en: http://localhost:${ODOO_PORT:-8069}"
docker compose ps
