# Docker

## Comandos de Docker

```bash
docker run -d \
 --name postgres \
 -p 5432:5432 \
 -v $HOME/postgresql/data:/var/lib/postgresql/data \
 -e POSTGRES_PASSWORD=123qwe \
 -e POSTGRES_USER=app \
 -e POSTGRES_DB=movies_database \
 postgres:16
```
**Explicación:**

- `docker run` - Crea e inicia contenedor
- `-d` - Ejecuta en background
- `--name postgres` - Llama al contenedor "postgres"
- `-p 5432:5432` - Mapea el puerto local 5432 al puerto del contenedor 5432
- `-v $HOME/postgresql/data:/var/lib/postgresql/data` - Guarda datos en la carpeta local
- `-e POSTGRES_PASSWORD=123qwe` - Configura la contraseña del super usuario
- `-e POSTGRES_USER=app` - Configura el usuario principal
- `-e POSTGRES_DB=movies_database` - Configura la base de datos default
- `postgres:16` - Imagen PostgreSQL versión 16

---

## Comandos de PostgreSQL

### Conexión local (desde host):
```bash
psql -h 127.0.0.1 -U app -d movies_database
```

**Explicación:**
- `psql` - Cliente PostgreSQL
- `-h 127.0.0.1` - Host (IP localhost)
- `-U app` - Usuario (app)
- `-d movies_database` - Base datos de destino

---

### Conexión dentro del contenedor Docker:
```bash
docker exec -it postgres psql -h 127.0.0.1 -U app -d movies_database
```

**Explicación:**
- `docker exec` - Ejecuta el comando dentro contenedor
- `-it` - Interactivo + terminal
- `postgres` - Nombre del contenedor
- `psql -h 127.0.0.1 -U app -d movies_database` 

---

### Instalar PostgreSQL en Linux:
```bash
sudo apt install postgresql
```

**Explicación:**
- `sudo` - Permisos de administrador
- `apt install` - Instala paquete
- `postgresql` - Cliente PostgreSQL

---

## Resultados EXPLAIN ANALYZE

📊 [**Ver Comparación Before/After**](./schema_design/explain_analyze_results.md)
