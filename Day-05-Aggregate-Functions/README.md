# Day 05 - Aggregate Functions

## Learning Objectives

By the end of Day 05 you will be able to:

* Count Records
* Calculate Totals
* Calculate Averages
* Find Maximum Values
* Find Minimum Values
* Group Data
* Filter Groups
* Build Reports
* Generate Analytics

---

# What Are Aggregate Functions?

Aggregate Functions perform calculations on multiple rows and return a single result.

Examples:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

---

# Sample Table

employees

| emp_id | emp_name | salary | department |
| ------ | -------- | ------ | ---------- |
| 1      | John     | 50000  | IT         |
| 2      | Emma     | 60000  | HR         |
| 3      | David    | 55000  | IT         |
| 4      | Sophia   | 70000  | Finance    |
| 5      | Michael  | 65000  | IT         |

---

# COUNT()

Returns total number of rows.

```sql
SELECT COUNT(*)
FROM employees;
```

Output:

```text
5
```

---

# SUM()

Returns total value.

```sql
SELECT SUM(salary)
FROM employees;
```

Output:

```text
300000
```

---

# AVG()

Returns average value.

```sql
SELECT AVG(salary)
FROM employees;
```

Output:

```text
60000
```

---

# MIN()

Returns smallest value.

```sql
SELECT MIN(salary)
FROM employees;
```

Output:

```text
50000
```

---

# MAX()

Returns largest value.

```sql
SELECT MAX(salary)
FROM employees;
```

Output:

```text
70000
```

---

# GROUP BY

Groups rows together.

Example:

```sql
SELECT department,
       COUNT(*)
FROM employees
GROUP BY department;
```

Output:

| department | count |
| ---------- | ----- |
| IT         | 3     |
| HR         | 1     |
| Finance    | 1     |

---

# GROUP BY with SUM

```sql
SELECT department,
       SUM(salary)
FROM employees
GROUP BY department;
```

---

# GROUP BY with AVG

```sql
SELECT department,
       AVG(salary)
FROM employees
GROUP BY department;
```

---

# HAVING

Filters grouped data.

```sql
SELECT department,
       COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;
```

Output:

```text
IT
```

---

# WHERE vs HAVING

| WHERE           | HAVING         |
| --------------- | -------------- |
| Filters rows    | Filters groups |
| Before GROUP BY | After GROUP BY |

---

# Real World Examples

Total Users

```sql
SELECT COUNT(*)
FROM users;
```

Average Cycle Length

```sql
SELECT AVG(cycle_length)
FROM syncher_users;
```

Total Revenue

```sql
SELECT SUM(amount)
FROM payments;
```

Highest Salary

```sql
SELECT MAX(salary)
FROM employees;
```

---

# Skills Acquired

✅ Analytics Queries

✅ Dashboard Queries

✅ Business Reports

✅ Grouping Data

✅ Filtering Groups

---

# Next Topic

Day 06 - JOINs
INNER | LEFT | RIGHT | FULL
