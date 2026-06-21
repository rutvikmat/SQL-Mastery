# Day 06 - SQL JOINs

## Learning Objectives

By the end of Day 06 you will be able to:

* Understand Relationships
* Combine Multiple Tables
* Use INNER JOIN
* Use LEFT JOIN
* Use RIGHT JOIN
* Use FULL OUTER JOIN
* Use SELF JOIN
* Use CROSS JOIN

---

# Why JOINs?

Real-world databases are normalized.

Instead of:

```text
Student | Course | Faculty
```

We store:

```text
students
courses
enrollments
faculty
```

JOIN helps us combine them.

---

# Sample Tables

## Students

| student_id | name   |
| ---------- | ------ |
| 1          | Rutvik |
| 2          | Kavya  |
| 3          | Arjun  |

---

## Enrollments

| student_id | course |
| ---------- | ------ |
| 1          | SQL    |
| 2          | Python |

---

# INNER JOIN

Returns matching records from both tables.

```sql
SELECT s.student_id,
       s.name,
       e.course
FROM students s
INNER JOIN enrollments e
ON s.student_id = e.student_id;
```

Output:

| student_id | name   | course |
| ---------- | ------ | ------ |
| 1          | Rutvik | SQL    |
| 2          | Kavya  | Python |

---

# LEFT JOIN

Returns:

* All rows from left table
* Matching rows from right table

```sql
SELECT s.student_id,
       s.name,
       e.course
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id;
```

Output:

| student_id | name   | course |
| ---------- | ------ | ------ |
| 1          | Rutvik | SQL    |
| 2          | Kavya  | Python |
| 3          | Arjun  | NULL   |

---

# RIGHT JOIN

Returns:

* All rows from right table
* Matching rows from left table

```sql
SELECT s.student_id,
       s.name,
       e.course
FROM students s
RIGHT JOIN enrollments e
ON s.student_id = e.student_id;
```

---

# FULL OUTER JOIN

Returns:

* All rows from both tables

```sql
SELECT s.student_id,
       s.name,
       e.course
FROM students s
FULL OUTER JOIN enrollments e
ON s.student_id = e.student_id;
```

---

# SELF JOIN

Joining a table with itself.

Example:

Employee Manager System

```sql
CREATE TABLE employees(
    emp_id INT,
    emp_name VARCHAR(100),
    manager_id INT
);
```

Query:

```sql
SELECT e.emp_name AS employee,
       m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;
```

---

# CROSS JOIN

Returns every combination.

```sql
SELECT *
FROM students
CROSS JOIN courses;
```

Example:

3 Students × 4 Courses

Result:

12 rows

---

# JOIN Summary

| JOIN  | Result              |
| ----- | ------------------- |
| INNER | Matching only       |
| LEFT  | All Left + Matches  |
| RIGHT | All Right + Matches |
| FULL  | All Both Tables     |
| SELF  | Same Table          |
| CROSS | Every Combination   |

---

# Real World Example

Syncher Database

users

cycles

symptoms

predictions

To show user prediction:

```sql
SELECT u.full_name,
       p.predicted_date
FROM users u
INNER JOIN predictions p
ON u.user_id = p.user_id;
```

---

# Skills Acquired

✅ Table Relationships

✅ Data Integration

✅ Multi-table Queries

✅ Interview Ready JOIN Knowledge

---

# Next Topic

Day 07 - Subqueries
