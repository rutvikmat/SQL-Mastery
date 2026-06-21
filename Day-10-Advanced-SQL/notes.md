# Day 10 Quick Revision Notes

## CTE

```sql
WITH temp AS
(
    SELECT *
    FROM employees
)
SELECT *
FROM temp;
```

---

## Recursive CTE

```sql
WITH RECURSIVE ...
```

Used for hierarchies.

---

## Window Functions

```sql
OVER()
```

---

## ROW_NUMBER()

Unique numbering.

---

## RANK()

Same rank for ties.

Gaps appear.

---

## DENSE_RANK()

Same rank for ties.

No gaps.

---

## LEAD()

Next row.

---

## LAG()

Previous row.

---

## PARTITION BY

Creates groups inside window functions.

Most important interview topic after JOINs.
