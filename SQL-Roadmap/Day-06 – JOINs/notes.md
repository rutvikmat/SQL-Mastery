# Day 06 Quick Revision Notes

## INNER JOIN

Matching rows only.

```sql
SELECT *
FROM students s
INNER JOIN enrollments e
ON s.student_id=e.student_id;
```

---

## LEFT JOIN

All rows from left table.

```sql
LEFT JOIN
```

---

## RIGHT JOIN

All rows from right table.

```sql
RIGHT JOIN
```

---

## FULL OUTER JOIN

All rows from both tables.

```sql
FULL OUTER JOIN
```

---

## SELF JOIN

Table joined with itself.

```sql
employees e
employees m
```

---

## CROSS JOIN

Every combination.

```sql
CROSS JOIN
```

---

## Important

JOIN condition uses:

```sql
ON
```

Example:

```sql
ON s.student_id=e.student_id
```
