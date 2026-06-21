# Day 07 - SQL Subqueries

## Learning Objectives

By the end of Day 07 you will be able to:

* Understand Subqueries
* Write Scalar Subqueries
* Write Row Subqueries
* Write Column Subqueries
* Write Table Subqueries
* Write Correlated Subqueries
* Solve Advanced SQL Problems

---

# What is a Subquery?

A query written inside another query.

Syntax:

```sql
SELECT *
FROM table_name
WHERE column_name =
(
    SELECT ...
);
```

---

# Types of Subqueries

1. Scalar Subquery
2. Row Subquery
3. Column Subquery
4. Table Subquery
5. Correlated Subquery

---

# Scalar Subquery

Returns a single value.

Example:

Average Salary

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

# Row Subquery

Returns one row.

Example:

```sql
SELECT *
FROM employees
WHERE (salary, department) =
(
    SELECT salary, department
    FROM employees
    WHERE emp_id = 1
);
```

---

# Column Subquery

Returns one column.

Example:

```sql
SELECT *
FROM employees
WHERE department IN
(
    SELECT department
    FROM employees
    WHERE salary > 60000
);
```

---

# Table Subquery

Returns multiple rows and columns.

Example:

```sql
SELECT *
FROM
(
    SELECT *
    FROM employees
    WHERE salary > 50000
) AS high_salary_employees;
```

---

# Subquery with IN

Find employees from departments where salary > 60000.

```sql
SELECT *
FROM employees
WHERE department IN
(
    SELECT department
    FROM employees
    WHERE salary > 60000
);
```

---

# Subquery with EXISTS

Checks whether records exist.

```sql
SELECT *
FROM departments d
WHERE EXISTS
(
    SELECT 1
    FROM employees e
    WHERE e.department = d.department_name
);
```

---

# Correlated Subquery

Executed once for every row.

Example:

Find employees earning more than department average.

```sql
SELECT *
FROM employees e1
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department = e2.department
);
```

---

# Real World Example

Syncher Users

Find users with cycle length above average.

```sql
SELECT *
FROM syncher_users
WHERE cycle_length >
(
    SELECT AVG(cycle_length)
    FROM syncher_users
);
```

---

# Skills Acquired

✅ Advanced Querying

✅ Nested Queries

✅ Correlated Queries

✅ Interview-Level SQL

---

# Next Topic

Day 08 - SQL Functions
String | Numeric | Date Functions
