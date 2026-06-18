# Day 05 Quick Revision Notes

## Aggregate Functions

Used to calculate values across multiple rows.

---

## COUNT()

```sql
SELECT COUNT(*)
FROM employees;
```

Returns total records.

---

## SUM()

```sql
SELECT SUM(salary)
FROM employees;
```

Returns total salary.

---

## AVG()

```sql
SELECT AVG(salary)
FROM employees;
```

Returns average salary.

---

## MIN()

```sql
SELECT MIN(salary)
FROM employees;
```

Returns smallest value.

---

## MAX()

```sql
SELECT MAX(salary)
FROM employees;
```

Returns largest value.

---

## GROUP BY

Groups records.

```sql
SELECT department,
       COUNT(*)
FROM employees
GROUP BY department;
```

---

## HAVING

Filters groups.

```sql
SELECT department,
       COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;
```

---

## Remember

WHERE → Filters rows

HAVING → Filters groups
