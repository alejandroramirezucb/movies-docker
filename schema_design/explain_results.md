# Resultados

## Query 1: Buscar por creation_date

**Index:** `film_work_creation_date_idx ON content.film_work(creation_date)`

**Antes:**

```
Seq Scan on film_work (cost=0.00..134.50 rows=4 width=84)
Filter: (creation_date = '2021-06-15'::date)
Rows Removed by Filter: 4995
Planning Time: 0.157 ms
Execution Time: 0.924 ms
```

**Despues:**

```
Bitmap Heap Scan on film_work (cost=4.31..17.54 rows=4 width=84)
  -> Bitmap Index Scan on film_work_creation_date_idx
Execution Time: 0.048 ms
```

**Conclusion:** Pasa de 0.924 ms a 0.048 ms. Mejora un 95.8%

---

## Query 2: Buscar por rating

**Index:** `film_work_rating_idx ON content.film_work(rating)`

**Antes:**

```
Seq Scan on film_work (cost=0.00..134.50 rows=1255 width=84)
Filter: (rating > '75'::double precision)
Rows Removed by Filter: 3745
Planning Time: 0.090 ms
Execution Time: 0.858 ms
```

**Despues:**

```
Bitmap Heap Scan on film_work (cost=30.01..117.70 rows=1255 width=84)
  -> Bitmap Index Scan on film_work_rating_idx
Execution Time: 0.542 ms
```

**Conclusion:** Pasa de 0.858 ms a 0.542 ms. Mejora un 36.8%

---

## Query 3: Buscar por genre con JOINs

**Index:** `genre_name_idx ON content.genre(name)`

**Antes:**

```
Nested Loop (cost=0.28..10.45 rows=1 width=84)
  -> Nested Loop
    -> Seq Scan on genre_film_work gfw
    -> Index Scan using film_work_pkey on film_work fw
  -> Seq Scan on genre g (cost=0.00..1.12 rows=1)
    Filter: ((name)::text = 'Action'::text)
Planning Time: 0.453 ms
Execution Time: 0.079 ms
```

**Despues:**

```
Nested Loop (cost=0.28..10.45 rows=1 width=84)
  -> Nested Loop
    -> Seq Scan on genre_film_work gfw
    -> Index Scan using film_work_pkey on film_work fw
  -> Seq Scan on genre g (uses genre_name_idx)
Planning Time: 0.486 ms
Execution Time: 0.100 ms
```

**Conclusion:** No cambia mucho por que la tabla genre es pequeña. Pasa de 0.079 ms a 0.100 ms
