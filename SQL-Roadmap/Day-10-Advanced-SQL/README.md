# Day 10 - Advanced SQL

## Learning Objectives

By the end of Day 10 you will be able to:

* Use Common Table Expressions
* Build Recursive Queries
* Use Window Functions
* Rank Records
* Analyze Trends
* Generate Analytics Reports
* Write Senior-Level SQL Queries

---

# Common Table Expressions (CTE)

A CTE is a temporary named result set.

Syntax:

```sql
WITH cte_name AS
(
    SELECT ...
)
SELECT *
FROM cte_name;
```

---

# Example

```sql
WITH high_salary_employees AS
(
    SELECT *
    FROM employees
    WHERE salary > 70000
)
SELECT *
FROM high_salary_employees;
```

Benefits:

* Easier to read
* Reusable
* Better query organization

---

# Multiple CTEs

```sql
WITH department_avg AS
(
    SELECT department,
           AVG(salary) avg_salary
    FROM employees
    GROUP BY department
),
high_salary AS
(
    SELECT *
    FROM employees
    WHERE salary > 70000
)
SELECT *
FROM high_salary;
```

---

# Recursive CTE

Used for hierarchical data.

Examples:

* Employee Hierarchy
* Organization Structure
* Categories
* Family Trees

---

# Employee Hierarchy

```sql
WITH RECURSIVE employee_tree AS
(
    SELECT emp_id,
           emp_name,
           manager_id
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id,
           e.emp_name,
           e.manager_id
    FROM employees e
    JOIN employee_tree et
    ON e.manager_id = et.emp_id
)
SELECT *
FROM employee_tree;
```

---

# Window Functions

Perform calculations across rows without grouping them.

Unlike GROUP BY:

GROUP BY reduces rows.

Window Functions keep rows.

---

# Sample Table

| emp_name | salary |
| -------- | ------ |
| John     | 50000  |
| Emma     | 70000  |
| David    | 70000  |
| Sophia   | 90000  |

---

# ROW_NUMBER()

Assigns unique numbers.

```sql
SELECT emp_name,
       salary,
       ROW_NUMBER()
       OVER(
            ORDER BY salary DESC
       ) AS row_num
FROM employees;
```

Output:

| Name   | Salary | Row |
| ------ | ------ | --- |
| Sophia | 90000  | 1   |
| Emma   | 70000  | 2   |
| David  | 70000  | 3   |
| John   | 50000  | 4   |

---

# RANK()

Gives same rank for ties.

```sql
SELECT emp_name,
       salary,
       RANK()
       OVER(
            ORDER BY salary DESC
       ) rank_no
FROM employees;
```

Output:

| Name   | Salary | Rank |
| ------ | ------ | ---- |
| Sophia | 90000  | 1    |
| Emma   | 70000  | 2    |
| David  | 70000  | 2    |
| John   | 50000  | 4    |

---

# DENSE_RANK()

No gaps.

```sql
SELECT emp_name,
       salary,
       DENSE_RANK()
       OVER(
            ORDER BY salary DESC
       ) dense_rank_no
FROM employees;
```

Output:

| Name   | Salary | Rank |
| ------ | ------ | ---- |
| Sophia | 90000  | 1    |
| Emma   | 70000  | 2    |
| David  | 70000  | 2    |
| John   | 50000  | 3    |

---

# LEAD()

Shows next row value.

```sql
SELECT emp_name,
       salary,
       LEAD(salary)
       OVER(
            ORDER BY salary
       ) next_salary
FROM employees;
```

---

# LAG()

Shows previous row value.

```sql
SELECT emp_name,
       salary,
       LAG(salary)
       OVER(
            ORDER BY salary
       ) previous_salary
FROM employees;
```

---

# PARTITION BY

Group inside window functions.

```sql
SELECT emp_name,
       department,
       salary,
       RANK()
       OVER(
           PARTITION BY department
           ORDER BY salary DESC
       )
FROM employees;
```

Ranks employees within departments.

---

# Real World Example

Find highest paid employee in each department.

```sql
WITH ranked_employees AS
(
    SELECT *,
           ROW_NUMBER()
           OVER(
               PARTITION BY department
               ORDER BY salary DESC
           ) rank_no
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE rank_no = 1;
```

---

# Syncher Analytics Example

```sql
SELECT user_id,
       cycle_length,
       LAG(cycle_length)
       OVER(
           ORDER BY user_id
       ) previous_cycle
FROM syncher_users;
```

Used to track cycle changes over time.

---

# Skills Acquired

✅ Advanced Analytics

✅ Ranking Systems

✅ Trend Analysis

✅ Hierarchical Queries

✅ Professional SQL Development

---

# SQL Mastery Complete

You now understand:

* Fundamentals
* Filtering
* DDL
* DML
* Aggregations
* JOINs
* Subqueries
* Functions
* Transactions
* Advanced SQL

You are now ready for real-world SQL projects.
