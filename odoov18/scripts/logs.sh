#!/usr/bin/env bash
# Muestra los logs de Odoo en tiempo real (Ctrl+C para salir)
cd "$(dirname "$0")/.."

docker compose logs -f --tail=100 odoo
