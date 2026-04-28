# Docker

## Comandos

```bash
psql -h 127.0.0.1 -U app -d movies_database
```

Conecta a la base de datos con el usuario app

---

```bash
docker exec -it postgres psql -h 127.0.0.1 -U app -d movies_database
```

Ejecuta psql dentro del contenedor Docker "postgres" y se conecta a la base de datos

---

```bash
sudo apt install postgresql
```

Instala PostgreSQL en Linux

## Resultados

📊 [**Resultados**](./schema_design/explain_results.md)
