# SQL Optimization Questions

## SQL-Mastery-Portfolio

---

# Introduction

SQL Optimization is one of the most important topics for:

* Backend Developers
* Database Administrators (DBA)
* Data Engineers
* Analytics Engineers
* Senior Software Engineers

Many SQL interviews focus less on writing queries and more on writing **efficient queries**.

This guide covers:

* Query Optimization
* Indexing
* Execution Plans
* Performance Tuning
* PostgreSQL Optimization
* Real Interview Questions

---

# Table of Contents

1. SQL Performance Basics
2. Query Optimization Questions
3. Indexing Questions
4. Execution Plan Questions
5. Database Design Optimization
6. Query Rewrite Scenarios
7. PostgreSQL Optimization
8. Real Interview Questions
9. Performance Tuning Checklist

---

# SQL PERFORMANCE BASICS

---

## Q1. What is Query Optimization?

### Answer

Query Optimization is the process of improving query performance by reducing:

* CPU usage
* Disk I/O
* Memory usage
* Execution time

Goal:

```text
Faster Queries
+
Less Resource Consumption
=
Better Performance
```

---

## Q2. Why is Query Optimization Important?

### Answer

Benefits:

* Faster response times
* Better scalability
* Lower database load
* Improved user experience

---

## Q3. What causes slow SQL queries?

### Answer

Common reasons:

* Missing indexes
* SELECT *
* Large table scans
* Poor joins
* Nested subqueries
* Excessive sorting
* Unoptimized aggregations

---

# INDEXING QUESTIONS

---

## Q4. What is an Index?

### Answer

An index is a database structure that improves data retrieval speed.

Similar to:

```text
Book Index
```

Instead of scanning the entire book, SQL directly locates data.

---

## Q5. When should you create an index?

### Answer

Create indexes on:

* WHERE columns
* JOIN columns
* ORDER BY columns
* GROUP BY columns

Example:

```sql
CREATE INDEX idx_employee_email
ON employees(email);
```

---

## Q6. When should you avoid indexes?

### Answer

Avoid excessive indexing on:

* Small tables
* Frequently updated columns
* Rarely queried columns

Because indexes increase:

* Storage
* Insert cost
* Update cost

---

## Q7. What is a Composite Index?

### Answer

Index containing multiple columns.

```sql
CREATE INDEX idx_department_salary
ON employees
(
department_id,
salary
);
```

Useful for:

```sql
SELECT *
FROM employees
WHERE department_id = 1
AND salary > 100000;
```

---

## Q8. Difference Between Clustered and Non-Clustered Index?

| Feature          | Clustered  | Non-Clustered |
| ---------------- | ---------- | ------------- |
| Data Sorted      | Yes        | No            |
| One Per Table    | Yes        | Multiple      |
| Read Performance | Faster     | Fast          |
| Storage          | Same Table | Separate      |

---

# QUERY OPTIMIZATION QUESTIONS

---

## Q9. Why is SELECT * bad?

### Answer

Problems:

* Reads unnecessary columns
* More I/O
* More network traffic
* Poor performance

Bad:

```sql
SELECT *
FROM employees;
```

Good:

```sql
SELECT
employee_id,
full_name
FROM employees;
```

---

## Q10. Which is faster: EXISTS or IN?

### Answer

For large datasets:

```sql
EXISTS
```

is usually faster.

Example:

```sql
SELECT *
FROM employees e
WHERE EXISTS
(
SELECT 1
FROM employee_projects ep
WHERE ep.employee_id=e.employee_id
);
```

---

## Q11. Why is JOIN usually faster than Subquery?

### Answer

JOINs allow the optimizer to generate more efficient execution plans.

Example:

```sql
SELECT
e.full_name,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id=d.department_id;
```

---

## Q12. How do you optimize a slow JOIN?

### Answer

1. Index JOIN columns

```sql
CREATE INDEX idx_department
ON employees(department_id);
```

2. Filter early

3. Avoid unnecessary columns

4. Review execution plan

---

# EXECUTION PLAN QUESTIONS

---

## Q13. What is EXPLAIN?

### Answer

Shows query execution plan.

```sql
EXPLAIN

SELECT *
FROM employees
WHERE department_id = 1;
```

---

## Q14. What is EXPLAIN ANALYZE?

### Answer

Executes query and shows:

* Actual time
* Actual rows
* Cost
* Loops

```sql
EXPLAIN ANALYZE

SELECT *
FROM employees;
```

---

## Q15. Difference Between EXPLAIN and EXPLAIN ANALYZE?

| Feature            | EXPLAIN | EXPLAIN ANALYZE |
| ------------------ | ------- | --------------- |
| Executes Query     | No      | Yes             |
| Shows Estimates    | Yes     | Yes             |
| Shows Actual Stats | No      | Yes             |

---

## Q16. What is a Sequential Scan?

### Answer

Reads every row in table.

```text
Table Scan
```

Usually slow on large tables.

---

## Q17. What is an Index Scan?

### Answer

Uses index to locate rows.

Faster than sequential scan.

---

## Q18. What is a Hash Join?

### Answer

Creates hash table for joins.

Best for:

```text
Large Tables
```

---

## Q19. What is a Nested Loop Join?

### Answer

Loops through rows repeatedly.

Good for:

```text
Small Tables
```

---

# DATABASE DESIGN OPTIMIZATION

---

## Q20. Why is Normalization important?

### Answer

Benefits:

* Reduced redundancy
* Better consistency
* Easier maintenance

---

## Q21. When should you Denormalize?

### Answer

For reporting systems.

Benefits:

* Faster reads

Tradeoff:

* More storage

---

## Q22. What is Partitioning?

### Answer

Splitting large tables into smaller parts.

Types:

* Range
* List
* Hash

---

## Q23. What is Sharding?

### Answer

Splitting data across multiple servers.

Used in:

* Large-scale systems
* Distributed databases

---

# QUERY REWRITE SCENARIOS

---

## Q24. Optimize This Query

Bad:

```sql
SELECT *
FROM employees
WHERE YEAR(joining_date)=2024;
```

Better:

```sql
SELECT *
FROM employees
WHERE joining_date >= '2024-01-01'
AND joining_date < '2025-01-01';
```

Reason:

Allows index usage.

---

## Q25. Optimize Aggregation Query

Bad:

```sql
SELECT department_id,
AVG(salary)
FROM employees
GROUP BY department_id;
```

Optimization:

```sql
CREATE INDEX idx_department
ON employees(department_id);
```

---

## Q26. Optimize Duplicate Detection

```sql
SELECT email,
COUNT(*)
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;
```

Index:

```sql
CREATE INDEX idx_email
ON employees(email);
```

---

# POSTGRESQL OPTIMIZATION

---

## Q27. What is VACUUM?

### Answer

Reclaims storage.

```sql
VACUUM employees;
```

---

## Q28. What is ANALYZE?

### Answer

Updates optimizer statistics.

```sql
ANALYZE employees;
```

---

## Q29. What is VACUUM ANALYZE?

### Answer

Combines both operations.

```sql
VACUUM ANALYZE employees;
```

---

## Q30. What is REINDEX?

### Answer

Rebuilds indexes.

```sql
REINDEX TABLE employees;
```

---

## Q31. How do you identify unused indexes?

```sql
SELECT
indexrelname,
idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0;
```

---

# INTERVIEW SCENARIOS

---

## Scenario 1

### Question

A query that runs in 1 second now takes 20 seconds.

What would you check?

### Answer

1. Execution Plan
2. Missing Indexes
3. Data Growth
4. Statistics
5. Locks
6. Hardware Resources

---

## Scenario 2

### Question

A table has 100 million rows.

How do you improve performance?

### Answer

* Partitioning
* Indexing
* Query Rewriting
* Materialized Views
* Caching

---

## Scenario 3

### Question

A report takes 5 minutes.

How would you optimize it?

### Answer

* Analyze execution plan
* Reduce joins
* Create indexes
* Precompute results
* Use materialized views

---

## Scenario 4

### Question

How do you find the slowest queries?

### PostgreSQL

```sql
SELECT
query,
calls,
mean_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC;
```

---

## Scenario 5

### Question

How do you monitor active queries?

### Solution

```sql
SELECT
pid,
query,
state
FROM pg_stat_activity;
```

---

# FAANG OPTIMIZATION QUESTIONS

---

## Amazon

* Explain execution plan
* Index strategy
* Join optimization

---

## Google

* Query cost analysis
* Recursive query optimization
* Window function optimization

---

## Microsoft

* Execution plans
* Transactions
* Index tuning

---

## Meta

* Large-scale query optimization
* Data partitioning

---

## Netflix

* Analytics optimization
* Time-series performance

---

# SQL Optimization Checklist

## Query Level

* [ ] Avoid SELECT *
* [ ] Filter Early
* [ ] Use Proper JOINs
* [ ] Use EXISTS
* [ ] Avoid Unnecessary Subqueries

---

## Index Level

* [ ] Index WHERE columns
* [ ] Index JOIN columns
* [ ] Create Composite Indexes
* [ ] Remove Unused Indexes

---

## Database Level

* [ ] VACUUM
* [ ] ANALYZE
* [ ] REINDEX
* [ ] Partition Large Tables

---

## Monitoring

* [ ] Use EXPLAIN
* [ ] Use EXPLAIN ANALYZE
* [ ] Monitor Slow Queries
* [ ] Review Execution Plans

---

# Performance Tuning Formula

```text
Good Schema
      +
Proper Indexes
      +
Efficient Queries
      +
Execution Plan Analysis
      +
Monitoring
      =
High Performance SQL
```

---

# Summary

## Topics Covered

* Query Optimization
* Indexing
* Execution Plans
* PostgreSQL Tuning
* Query Rewriting
* Performance Monitoring
* Interview Scenarios

## Questions Covered

40+ Optimization Questions

## Difficulty

* Intermediate
* Advanced
* Senior Engineer
* DBA Level

---

**Portfolio Status:** SQL Optimization Ready 🚀
