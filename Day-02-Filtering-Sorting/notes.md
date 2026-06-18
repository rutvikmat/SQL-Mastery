# Day 02 Quick Revision Notes

## WHERE

Filters records.

```sql
SELECT *
FROM students
WHERE age > 20;
```

---

## Comparison Operators

```sql
=
>
<
>=
<=
<>
!=
```

---

## Logical Operators

### AND

Both conditions true.

### OR

Any condition true.

### NOT

Reverse condition.

---

## DISTINCT

Remove duplicate values.

```sql
SELECT DISTINCT city
FROM students;
```

---

## ORDER BY

Ascending:

```sql
ORDER BY age ASC;
```

Descending:

```sql
ORDER BY age DESC;
```

---

## LIMIT

```sql
LIMIT 5;
```

---

## LIKE

Starts With

```sql
'R%'
```

Ends With

```sql
'%a'
```

Contains

```sql
'%ut%'
```

---

## BETWEEN

```sql
BETWEEN 20 AND 30
```

---

## IN

```sql
IN ('Bangalore','Mysore')
```
