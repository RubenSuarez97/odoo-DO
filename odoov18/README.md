# Odoo 18 - Estructura de Despliegue (Docker)

Estructura base para desplegar **Odoo 18 Community + PostgreSQL 15** en producción
detrás de nginx con SSL.

## Requisitos en el servidor

- Docker + Docker Compose plugin
- nginx instalado en el host
- certbot instalado en el host

## Despliegue paso a paso

```bash
# 1. Clonar
git clone -b 18.0 <url-del-repo> /opt/odoov18
cd /opt/odoov18/odoov18

# 2. Crear el .env con valores reales
cp .env.example .env
nano .env        # POSTGRES_PASSWORD fuerte

# 3. Cambiar la contraseña maestra en config/odoo.conf
nano config/odoo.conf   # admin_passwd

# 4. (Opcional) Subir addons Enterprise a addons/enterprise/
#    Nunca se suben a git - son licencia de pago.

# 5. Levantar
./scripts/up.sh

# 6. Crear/restaurar la base de datos
#    Opción A - por la interfaz web (mientras list_db este activo temporalmente):
#    http://IP:8069/web/database/manager
#    Opción B - por consola:
docker compose exec odoo odoo -d <nombre_db> -i base --stop-after-init --without-demo=all

# 7. Configurar nginx (ver nginx/odoo.example.com.conf)
sudo cp nginx/odoo.example.com.conf /etc/nginx/sites-available/<dominio>
# editar server_name y rutas de logs
sudo ln -s /etc/nginx/sites-available/<dominio> /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

# 8. SSL
sudo certbot --nginx -d <dominio>
```

## Scripts disponibles

| Script | Uso |
|--------|-----|
| `scripts/up.sh` | Levantar servicios |
| `scripts/down.sh` | Detener servicios |
| `scripts/logs.sh` | Ver logs de Odoo |
| `scripts/restart.sh` | Reiniciar Odoo |
| `scripts/shell.sh` | Shell dentro del contenedor |
| `scripts/psql.sh` | Consola PostgreSQL |
| `scripts/backup.sh <db>` | Dump de la base a `./backups/` |
| `scripts/update.sh <db> <modulos>` | Actualizar módulos |

## Seguridad

- El puerto 8069 solo escucha en `127.0.0.1` (nginx es la entrada pública).
- `list_db = False` oculta el gestor de bases de datos en producción.
- `dbfilter = ^%d$` restringe qué base responde por dominio.
- Las contraseñas viven en `.env` y `config/odoo.conf` del servidor, nunca en git.

## Autor

Ruben Suarez <suarezruben.e20@gmail.com>
