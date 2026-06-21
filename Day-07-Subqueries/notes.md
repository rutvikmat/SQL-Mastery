# Day 07 Quick Revision Notes

## Subquery

Query inside another query.

---

## Scalar Subquery

Returns one value.

```sql
SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
```

---

## Column Subquery

Returns one column.

```sql
SELECT department
FROM employees;
```

---

## Row Subquery

Returns one row.

```sql
(salary, department)
```

---

## Table Subquery

Returns multiple rows.

```sql
FROM
(
    SELECT *
    FROM employees
)
```

---

## EXISTS

Checks existence.

```sql
WHERE EXISTS(...)
```

---

## Correlated Subquery

Runs once per row.

```sql
e1.department=e2.department
```

---

## Interview Rule

Subquery = Query inside another query.
