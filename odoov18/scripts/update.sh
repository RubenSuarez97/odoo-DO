#!/usr/bin/env bash
# Actualiza módulos de Odoo y reinicia
# Uso:
#   ./scripts/update.sh mi_db l10n_ve_full,auditlog   -> actualiza esos módulos
#   ./scripts/update.sh mi_db all                     -> actualiza todos
set -e
cd "$(dirname "$0")/.."

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Uso: $0 <base_de_datos> <modulo1,modulo2|all>"
  exit 1
fi

docker compose run --rm odoo odoo -d "$1" -u "$2" --stop-after-init --no-http
docker compose restart odoo
