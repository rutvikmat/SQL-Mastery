# 🚀 Intermediate SQL Practice Set

## Overview

Welcome to the Intermediate SQL Practice Set.

This section is designed for learners who have completed SQL fundamentals and are ready to work with real-world database problems involving multiple tables, data relationships, aggregations, subqueries, business reporting, and analytical queries.

The goal of this practice set is to bridge the gap between basic SQL knowledge and advanced SQL development used in:

* Backend Development
* Data Analytics
* Business Intelligence
* Data Engineering
* Database Administration
* Technical Interviews

---

# 🎯 Learning Objectives

After completing this practice set, you will be able to:

✅ Write complex JOIN queries

✅ Analyze business data using aggregations

✅ Solve real-world reporting problems

✅ Work with multiple related tables

✅ Use subqueries effectively

✅ Apply string and date functions

✅ Build analytical reports

✅ Prepare for SQL interviews

---

# 📚 Prerequisites

Before attempting this practice set, you should be comfortable with:

### SQL Fundamentals

* SELECT
* WHERE
* ORDER BY
* LIMIT

### DML Commands

* INSERT
* UPDATE
* DELETE

### Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MAX()
* MIN()

### GROUP BY

### HAVING

---

# 📊 Dataset Used

The questions are based on a simplified Employee Management System.

---

## Employees Table

```sql
employees
(
    employee_id,
    full_name,
    email,
    department_id,
    manager_id,
    salary,
    city,
    joining_date
)
```

---

## Departments Table

```sql
departments
(
    department_id,
    department_name,
    location
)
```

---

## Projects Table

```sql
projects
(
    project_id,
    project_name,
    budget,
    start_date
)
```

---

## Employee Projects Table

```sql
employee_projects
(
    employee_id,
    project_id,
    assigned_date
)
```

---

# 🏗 Practice Structure

The practice set contains 100 carefully selected questions.

---

## Section 1 – JOIN Queries

Questions:

```text
1 - 20
```

Topics:

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL JOIN
* SELF JOIN
* Multi-Table JOINs

Skills Developed:

* Relationship Analysis
* Multi-Table Reporting
* Data Integration

---

## Section 2 – Aggregate Queries

Questions:

```text
21 - 35
```

Topics:

* COUNT()
* SUM()
* AVG()
* MAX()
* MIN()
* GROUP BY
* HAVING

Skills Developed:

* Business Reporting
* KPI Calculations
* Summary Reports

---

## Section 3 – Subqueries

Questions:

```text
36 - 50
```

Topics:

* Scalar Subqueries
* Nested Subqueries
* Correlated Subqueries
* EXISTS
* IN
* NOT EXISTS

Skills Developed:

* Advanced Filtering
* Complex Data Analysis

---

## Section 4 – String & Date Functions

Questions:

```text
51 - 65
```

Topics:

* CONCAT()
* UPPER()
* LOWER()
* LENGTH()
* SUBSTRING()

Date Functions:

* CURRENT_DATE
* CURRENT_TIMESTAMP
* EXTRACT()
* AGE()

Skills Developed:

* Data Cleaning
* Data Transformation

---

## Section 5 – CASE Statements

Questions:

```text
66 - 75
```

Topics:

* Conditional Logic
* Categorization
* Business Rules

Skills Developed:

* Dynamic Reporting
* Classification

---

## Section 6 – Views & Indexes

Questions:

```text
76 - 85
```

Topics:

* CREATE VIEW
* CREATE INDEX
* Query Optimization

Skills Developed:

* Database Design
* Reporting Layer Development

---

## Section 7 – Business Analytics

Questions:

```text
86 - 100
```

Topics:

* Revenue Analysis
* Department Analytics
* Employee Analytics
* Project Analytics

Skills Developed:

* Dashboard Development
* Business Intelligence

---

# 📈 Difficulty Breakdown

| Section         | Difficulty |
| --------------- | ---------- |
| JOINs           | ⭐⭐⭐        |
| Aggregates      | ⭐⭐⭐        |
| Subqueries      | ⭐⭐⭐⭐       |
| Functions       | ⭐⭐⭐        |
| CASE Statements | ⭐⭐⭐        |
| Views & Indexes | ⭐⭐⭐⭐       |
| Analytics       | ⭐⭐⭐⭐⭐      |

---

# 🏆 Skills Covered

## Relational Database Concepts

* Primary Keys
* Foreign Keys
* Relationships
* Data Integrity

---

## Query Writing

* JOINs
* Aggregations
* Filtering
* Sorting

---

## Advanced SQL

* Subqueries
* EXISTS
* CASE
* Views

---

## Reporting

* Department Reports
* Salary Reports
* Project Reports
* Performance Reports

---

# 🎯 Interview Preparation Coverage

This practice set prepares you for:

### Software Engineer Interviews

Topics Covered:

* JOINs
* Subqueries
* Aggregations

---

### Backend Developer Interviews

Topics Covered:

* Database Design
* Relationships
* Query Optimization

---

### Data Analyst Interviews

Topics Covered:

* Reporting
* KPI Analysis
* Data Transformation

---

### Data Engineer Interviews

Topics Covered:

* SQL Logic
* Business Analytics
* Data Processing

---

# 📊 Real-World Scenarios Covered

The questions simulate scenarios from:

### Human Resource Systems

* Employee Reports
* Salary Analysis
* Department Performance

---

### Project Management Systems

* Project Allocation
* Resource Utilization

---

### Business Intelligence

* KPI Reporting
* Dashboard Metrics

---

### Corporate Analytics

* Workforce Analysis
* Cost Analysis

---

# 📚 Recommended Approach

For each question:

### Step 1

Read the problem carefully.

### Step 2

Attempt your own solution.

### Step 3

Validate results.

### Step 4

Compare with provided solution.

### Step 5

Optimize the query.

---

# 🚀 Mastery Checklist

## JOINs

* [ ] INNER JOIN
* [ ] LEFT JOIN
* [ ] RIGHT JOIN
* [ ] FULL JOIN
* [ ] SELF JOIN

---

## Aggregations

* [ ] COUNT()
* [ ] SUM()
* [ ] AVG()
* [ ] MAX()
* [ ] MIN()

---

## Grouping

* [ ] GROUP BY
* [ ] HAVING

---

## Subqueries

* [ ] Scalar
* [ ] Nested
* [ ] Correlated

---

## Functions

* [ ] String Functions
* [ ] Date Functions

---

## CASE Statements

* [ ] Basic CASE
* [ ] Nested CASE

---

## Views

* [ ] Create Views
* [ ] Query Views

---

## Analytics

* [ ] Employee Analytics
* [ ] Department Analytics
* [ ] Project Analytics

---

# 📂 Files Included

```text
Intermediate/
│
├── README.md
├── 100_Queries.sql
└── Solutions.sql
```

---

# 🎓 Learning Outcome

After completing this Intermediate SQL Practice Set, you will be able to:

* Build complex SQL reports
* Solve interview-level SQL problems
* Work with relational data models
* Perform analytical reporting
* Design business dashboards
* Prepare for advanced SQL concepts

---

# 🛣 Next Step

After completing this set, move to:

```text
Intermediate SQL
       ↓
Advanced SQL
       ↓
CTEs
       ↓
Window Functions
       ↓
Query Optimization
       ↓
Database Engineering
       ↓
SQL Mastery
```

---

# 🏁 Goal

Complete all 100 questions without referring to the solutions.

If you can solve at least 80 out of 100 independently, you are ready to begin Advanced SQL and tackle real-world database projects with confidence.

Happy Learning and Happy Querying 🚀
