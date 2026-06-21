# 📚 Database Normalization Guide

## Overview

Normalization is the process of organizing data in a relational database to reduce redundancy and improve data integrity.

It helps:

* Eliminate duplicate data
* Maintain consistency
* Improve database design
* Simplify maintenance
* Reduce storage requirements

This guide covers:

* 1NF (First Normal Form)
* 2NF (Second Normal Form)
* 3NF (Third Normal Form)
* BCNF (Boyce-Codd Normal Form)
* 4NF (Fourth Normal Form)
* 5NF (Fifth Normal Form)
* Denormalization

---

# 🎯 Why Normalization?

Consider the following table:

## Unnormalized Table

| Student_ID | Student_Name | Course_1 | Course_2 | Course_3 |
| ---------- | ------------ | -------- | -------- | -------- |
| 101        | Rutvik       | SQL      | Python   | Django   |
| 102        | Kavya        | Java     | SQL      | NULL     |

Problems:

❌ Repeating groups

❌ Difficult to query

❌ Data redundancy

❌ Update anomalies

---

# 📌 Goals of Normalization

A normalized database should:

✅ Eliminate duplicate data

✅ Maintain consistency

✅ Reduce update anomalies

✅ Improve maintainability

✅ Support scalable applications

---

# 🔹 First Normal Form (1NF)

## Rule

A table is in 1NF if:

* Each column contains atomic values
* No repeating groups
* Each row is unique

---

## ❌ Violates 1NF

| Student_ID | Student_Name | Courses             |
| ---------- | ------------ | ------------------- |
| 101        | Rutvik       | SQL, Python, Django |

Problem:

Multiple values stored in a single column.

---

## ✅ 1NF Version

| Student_ID | Student_Name | Course |
| ---------- | ------------ | ------ |
| 101        | Rutvik       | SQL    |
| 101        | Rutvik       | Python |
| 101        | Rutvik       | Django |

Benefits:

* Atomic values
* Easier querying
* Better indexing

---

# 🔹 Second Normal Form (2NF)

## Rule

A table must:

* Already be in 1NF
* Have no partial dependency

---

## What is Partial Dependency?

When a non-key attribute depends on only part of a composite key.

---

## Example

### Table

| Student_ID | Course_ID | Student_Name | Course_Name |
| ---------- | --------- | ------------ | ----------- |
| 101        | C01       | Rutvik       | SQL         |

Composite Key:

```text
(Student_ID, Course_ID)
```

Problems:

Student_Name depends only on Student_ID.

Course_Name depends only on Course_ID.

---

## ❌ Not in 2NF

```text
Student_ID
Course_ID
Student_Name
Course_Name
```

---

## ✅ Convert to 2NF

### Students

| Student_ID | Student_Name |
| ---------- | ------------ |
| 101        | Rutvik       |

---

### Courses

| Course_ID | Course_Name |
| --------- | ----------- |
| C01       | SQL         |

---

### Enrollments

| Student_ID | Course_ID |
| ---------- | --------- |
| 101        | C01       |

Benefits:

* Reduced duplication
* Cleaner relationships

---

# 🔹 Third Normal Form (3NF)

## Rule

A table must:

* Be in 2NF
* Have no transitive dependency

---

## What is Transitive Dependency?

When a non-key attribute depends on another non-key attribute.

---

## Example

### Employees

| Employee_ID | Employee_Name | Department_ID | Department_Name |
| ----------- | ------------- | ------------- | --------------- |
| 1           | Rutvik        | D01           | IT              |

Problem:

Department_Name depends on Department_ID.

Department_ID depends on Employee_ID.

Therefore:

Department_Name indirectly depends on Employee_ID.

---

## ❌ Not in 3NF

```text
Employee_ID
Employee_Name
Department_ID
Department_Name
```

---

## ✅ Convert to 3NF

### Employees

| Employee_ID | Employee_Name | Department_ID |
| ----------- | ------------- | ------------- |
| 1           | Rutvik        | D01           |

---

### Departments

| Department_ID | Department_Name |
| ------------- | --------------- |
| D01           | IT              |

Benefits:

* Eliminates transitive dependencies
* Better maintainability

---

# 🔹 Boyce-Codd Normal Form (BCNF)

## Rule

For every functional dependency:

```text
X → Y
```

X must be a candidate key.

---

## Why BCNF?

Sometimes 3NF still allows redundancy.

BCNF is a stronger version of 3NF.

---

## Example

### Course Assignments

| Student | Course | Instructor |
| ------- | ------ | ---------- |
| Rutvik  | SQL    | John       |
| Kavya   | SQL    | John       |

Dependencies:

```text
Course → Instructor
Student + Course → Instructor
```

Redundancy exists.

---

## BCNF Solution

### Courses

| Course | Instructor |
| ------ | ---------- |
| SQL    | John       |

---

### Enrollments

| Student | Course |
| ------- | ------ |
| Rutvik  | SQL    |

---

# 🔹 Fourth Normal Form (4NF)

## Rule

A table must:

* Be in BCNF
* Have no multi-valued dependencies

---

## Example

### Student Skills and Languages

| Student | Skill  | Language |
| ------- | ------ | -------- |
| Rutvik  | SQL    | English  |
| Rutvik  | SQL    | Kannada  |
| Rutvik  | Python | English  |
| Rutvik  | Python | Kannada  |

Problem:

Skills and languages are independent.

---

## Solution

### Student Skills

| Student | Skill  |
| ------- | ------ |
| Rutvik  | SQL    |
| Rutvik  | Python |

---

### Student Languages

| Student | Language |
| ------- | -------- |
| Rutvik  | English  |
| Rutvik  | Kannada  |

---

# 🔹 Fifth Normal Form (5NF)

## Rule

A table must:

* Be in 4NF
* Have no join dependency

---

## Purpose

Prevent redundancy caused by complex joins.

Usually required in:

* Large enterprise databases
* Data warehouses
* ERP systems

---

# 📊 Functional Dependency

## Definition

A relationship between attributes.

Example:

```text
Student_ID → Student_Name
```

Meaning:

Student_ID uniquely determines Student_Name.

---

## Types

### Full Functional Dependency

```text
(Student_ID, Course_ID)
→ Grade
```

Depends on entire key.

---

### Partial Dependency

```text
Student_ID
→ Student_Name
```

Depends on part of key.

---

### Transitive Dependency

```text
Employee_ID
→ Department_ID

Department_ID
→ Department_Name
```

Indirect dependency.

---

# 📊 Normal Forms Summary

| Normal Form | Removes                  |
| ----------- | ------------------------ |
| 1NF         | Repeating Groups         |
| 2NF         | Partial Dependency       |
| 3NF         | Transitive Dependency    |
| BCNF        | Candidate Key Violations |
| 4NF         | Multi-Valued Dependency  |
| 5NF         | Join Dependency          |

---

# 📊 Normalization Example

## Original Table

| Order_ID | Customer_Name | Product_Name |
| -------- | ------------- | ------------ |
| 1        | Rutvik        | Laptop       |
| 1        | Rutvik        | Mouse        |

Problems:

* Duplicate customer data
* Update anomalies

---

## Normalized Design

### Customers

| Customer_ID | Customer_Name |
| ----------- | ------------- |
| 1           | Rutvik        |

---

### Products

| Product_ID | Product_Name |
| ---------- | ------------ |
| 1          | Laptop       |
| 2          | Mouse        |

---

### Orders

| Order_ID | Customer_ID |
| -------- | ----------- |
| 1        | 1           |

---

### Order_Items

| Order_ID | Product_ID |
| -------- | ---------- |
| 1        | 1          |
| 1        | 2          |

Benefits:

* No duplication
* Better scalability

---

# 📊 Database Anomalies

## 1. Insert Anomaly

Cannot insert department without employee.

---

## 2. Update Anomaly

Need multiple updates for same value.

---

## 3. Delete Anomaly

Deleting employee removes department information.

---

# 📊 Advantages of Normalization

### Better Data Integrity

Reduces inconsistencies.

### Reduced Redundancy

Less duplicate data.

### Easier Maintenance

Updates become simpler.

### Better Scalability

Supports large systems.

### Improved Consistency

Single source of truth.

---

# 📊 Disadvantages of Normalization

### More Tables

Requires additional joins.

### Complex Queries

Multi-table relationships.

### Performance Cost

Heavy joins can slow queries.

---

# 📊 Denormalization

## What is Denormalization?

Intentionally introducing redundancy to improve performance.

---

## Example

Instead of:

### Employees

| Employee_ID | Department_ID |
| ----------- | ------------- |

### Departments

| Department_ID | Department_Name |
| ------------- | --------------- |

Store:

| Employee_ID | Department_Name |
| ----------- | --------------- |
| 1           | IT              |

---

## Benefits

* Faster reads
* Simpler reports

---

## Drawbacks

* Data duplication
* Update complexity

---

# 📊 Real-World Applications

## OLTP Systems

Examples:

* Banking
* E-Commerce
* Hospital Management

Recommended:

```text
3NF / BCNF
```

---

## Data Warehouses

Examples:

* Business Intelligence
* Analytics

Recommended:

```text
Denormalization
Star Schema
Snowflake Schema
```

---

# 🎯 Interview Questions

## What is Normalization?

Process of reducing redundancy and improving integrity.

---

## Why Normalize Data?

To eliminate duplicate data and maintain consistency.

---

## Difference Between 2NF and 3NF?

### 2NF

Removes partial dependency.

### 3NF

Removes transitive dependency.

---

## What is BCNF?

A stronger version of 3NF where every determinant is a candidate key.

---

## What is Denormalization?

Introducing redundancy to improve read performance.

---

# 🏆 Normalization Checklist

## 1NF

* [ ] Atomic values
* [ ] No repeating groups

## 2NF

* [ ] No partial dependency

## 3NF

* [ ] No transitive dependency

## BCNF

* [ ] Every determinant is a candidate key

## 4NF

* [ ] No multi-valued dependency

## 5NF

* [ ] No join dependency

---

# 🚀 Database Design Strategy

```text
Raw Data
    ↓
1NF
    ↓
2NF
    ↓
3NF
    ↓
BCNF
    ↓
Production Database
```

For most real-world applications such as:

* Student Management Systems
* Employee Management Systems
* E-Commerce Systems
* Hospital Management Systems

**3NF or BCNF** provides the best balance between data integrity, maintainability, and performance.
