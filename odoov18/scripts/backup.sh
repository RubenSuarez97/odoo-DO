#!/usr/bin/env bash
# Genera un dump de la base de datos en ./backups/
# Uso: ./scripts/backup.sh [nombre_db]
set -e
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

DB="${1:-${POSTGRES_DB:-postgres}}"
FILE="backups/${DB}_$(date +%Y%m%d_%H%M%S).dump"

docker compose exec db pg_dump -U "${POSTGRES_USER:-odoo}" -Fc "$DB" > "$FILE"
echo "Backup creado: $FILE"
