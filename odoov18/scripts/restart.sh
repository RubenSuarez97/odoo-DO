#!/usr/bin/env bash
# Reinicia el servicio de Odoo (útil tras editar odoo.conf o módulos)
set -e
cd "$(dirname "$0")/.."

docker compose restart odoo
