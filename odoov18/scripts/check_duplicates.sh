#!/usr/bin/env bash
# Lista módulos duplicados entre las rutas del addons_path
# Odoo usa la PRIMERA copia encontrada (en el orden del path) e ignora el resto
# Uso: ./scripts/check_duplicates.sh
cd "$(dirname "$0")/.."

docker compose exec odoo python3 <<'EOF'
import configparser, os
from collections import defaultdict

# Rutas que Odoo agrega automaticamente + las del odoo.conf (mismo orden real)
p = configparser.RawConfigParser()
p.read('/etc/odoo/odoo.conf')
conf = [x.strip() for x in p.get('options', 'addons_path').split(',') if x.strip()]
paths = ['/usr/lib/python3/dist-packages/odoo/addons', '/var/lib/odoo/addons/18.0'] + conf
paths = list(dict.fromkeys(paths))  # quita rutas repetidas manteniendo el orden

seen = defaultdict(list)
for base in paths:
    if not os.path.isdir(base):
        continue
    for name in sorted(os.listdir(base)):
        if os.path.isfile(os.path.join(base, name, '__manifest__.py')):
            seen[name].append(os.path.join(base, name))

dups = {k: v for k, v in seen.items() if len(v) > 1}
print(f"{len(seen)} modulos visibles en {len(paths)} rutas")
if not dups:
    print("OK: sin modulos duplicados")
else:
    print(f"\n{len(dups)} modulo(s) duplicado(s):")
    for name, locs in sorted(dups.items()):
        print(f"\n  {name}")
        for i, l in enumerate(locs):
            print(f"    {'(ODoo USA ESTA)' if i == 0 else '(ignorada)'}  {l}")
EOF
