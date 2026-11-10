#!/usr/bin/env bash
# Uso:
#   ./scripts/shell.sh            -> bash dentro del contenedor de Odoo
#   ./scripts/shell.sh mi_db      -> odoo shell sobre la base "mi_db"
cd "$(dirname "$0")/.."

if [ -n "$1" ]; then
  docker compose exec odoo odoo shell -d "$1" --no-http
else
  docker compose exec odoo bash
fi
