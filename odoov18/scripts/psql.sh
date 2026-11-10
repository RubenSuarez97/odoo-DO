#!/usr/bin/env bash
# Consola psql dentro del contenedor de PostgreSQL
# Uso: ./scripts/psql.sh [nombre_db]
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

DB="${1:-${POSTGRES_DB:-postgres}}"
docker compose exec db psql -U "${POSTGRES_USER:-odoo}" "$DB"
