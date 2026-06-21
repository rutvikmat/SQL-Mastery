# 🏗️ Database Design Guide

## Overview

Database design is the process of creating a structured blueprint for storing, managing, and retrieving data efficiently.

A well-designed database should be:

* Scalable
* Maintainable
* Consistent
* Secure
* High Performance

This guide covers the complete database design lifecycle from requirements gathering to production deployment.

---

# 🎯 Objectives of Database Design

A good database design should:

✅ Eliminate data redundancy

✅ Ensure data integrity

✅ Improve query performance

✅ Support business requirements

✅ Scale with application growth

✅ Simplify maintenance

---

# 📚 Database Design Lifecycle

```text
Business Requirements
        ↓
Requirement Analysis
        ↓
Conceptual Design
        ↓
Logical Design
        ↓
Normalization
        ↓
Physical Design
        ↓
Implementation
        ↓
Optimization
        ↓
Production Deployment
```

---

# 🔹 Phase 1: Requirement Analysis

## Purpose

Understand business needs before creating tables.

---

## Questions to Ask

### Business Questions

* What problem are we solving?
* Who will use the system?
* What reports are required?
* What data must be stored?

### Technical Questions

* Expected user count?
* Expected database size?
* Read-heavy or write-heavy?
* Security requirements?

---

## Example

### Hospital Management System

Requirements:

* Store patients
* Store doctors
* Manage appointments
* Manage billing
* Generate reports

---

# 🔹 Phase 2: Identify Entities

## What is an Entity?

An entity is a real-world object represented in the database.

Examples:

```text
Student
Employee
Customer
Product
Doctor
Patient
Order
Invoice
```

---

## Example

Hospital System

Entities:

```text
Patients
Doctors
Appointments
Prescriptions
Rooms
Admissions
Billing
Payments
```

---

# 🔹 Phase 3: Identify Attributes

## What is an Attribute?

An attribute describes an entity.

---

### Patient Entity

```text
Patient_ID
Full_Name
Gender
Date_Of_Birth
Blood_Group
Phone
Email
```

---

### Doctor Entity

```text
Doctor_ID
Full_Name
Specialization
Experience
Consultation_Fee
```

---

# 🔹 Phase 4: Define Relationships

## Types of Relationships

### One-to-One (1:1)

Example:

```text
Person
    ↔
Passport
```

One person has one passport.

---

### One-to-Many (1:N)

Example:

```text
Department
      ↓
Employees
```

One department has many employees.

---

### Many-to-Many (M:N)

Example:

```text
Students
      ↔
Courses
```

Many students can enroll in many courses.

Requires a junction table.

---

# 🔹 Entity Relationship Diagram (ERD)

## Purpose

Visual representation of relationships.

---

## Example

```text
Customers
    │
    │
Orders
    │
    │
Order_Items
    │
    │
Products
```

---

## Hospital ERD

```text
Departments
      │
      │
Doctors
      │
      │
Appointments
      │
      │
Patients
      │
      ├── Medical_Records
      │
      ├── Prescriptions
      │
      ├── Billing
      │
      │
      └── Admissions
              │
              │
            Rooms
```

---

# 🔹 Primary Keys

## Definition

Uniquely identifies each row.

---

## Example

```sql
CREATE TABLE patients
(
    patient_id SERIAL PRIMARY KEY
);
```

---

## Characteristics

* Unique
* Not Null
* Stable
* Minimal

---

## Good Primary Keys

```text
student_id
employee_id
customer_id
product_id
order_id
```

---

## Avoid

```text
email
phone
full_name
```

These can change.

---

# 🔹 Foreign Keys

## Purpose

Maintain relationships between tables.

---

## Example

```sql
CREATE TABLE employees
(
    employee_id SERIAL PRIMARY KEY,

    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
```

---

## Benefits

* Prevent orphan records
* Maintain integrity
* Enforce relationships

---

# 🔹 Normalization

## Purpose

Reduce redundancy and improve consistency.

---

### First Normal Form (1NF)

Rules:

* Atomic values
* No repeating groups

---

### Second Normal Form (2NF)

Rules:

* Must be in 1NF
* No partial dependency

---

### Third Normal Form (3NF)

Rules:

* Must be in 2NF
* No transitive dependency

---

### BCNF

Every determinant must be a candidate key.

---

## Recommended

For most applications:

```text
3NF
or
BCNF
```

---

# 🔹 Data Types

Choosing the correct data type is critical.

---

## Numeric Types

```sql
INT
BIGINT
DECIMAL(10,2)
NUMERIC
FLOAT
```

---

## String Types

```sql
VARCHAR(100)
TEXT
CHAR(10)
```

---

## Date Types

```sql
DATE
TIME
TIMESTAMP
```

---

## Boolean

```sql
BOOLEAN
```

---

## UUID

```sql
UUID
```

Used in distributed systems.

---

# 🔹 Constraints

## NOT NULL

```sql
full_name VARCHAR(100) NOT NULL
```

---

## UNIQUE

```sql
email VARCHAR(255) UNIQUE
```

---

## CHECK

```sql
CHECK (salary > 0)
```

---

## DEFAULT

```sql
created_at TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
```

---

# 🔹 Naming Conventions

## Table Names

Use plural nouns.

### Recommended

```text
employees
customers
orders
products
patients
```

---

## Column Names

Use snake_case.

### Recommended

```text
employee_id
created_at
updated_at
```

---

## Avoid

```text
EmployeeID
CreatedAt
EMPLOYEE_ID
```

---

# 🔹 Audit Columns

Every production table should contain:

```sql
created_at TIMESTAMP
updated_at TIMESTAMP
```

Recommended:

```sql
created_by
updated_by
```

---

# 🔹 Junction Tables

Used in Many-to-Many relationships.

---

## Example

Students ↔ Courses

### Enrollment Table

```sql
CREATE TABLE enrollments
(
    student_id INT,
    course_id INT,

    PRIMARY KEY
    (
        student_id,
        course_id
    )
);
```

---

# 🔹 Database Indexing

## Purpose

Improve query performance.

---

## Create Index

```sql
CREATE INDEX idx_employee_name
ON employees(full_name);
```

---

## Index Columns Used In

```text
WHERE
JOIN
ORDER BY
GROUP BY
```

---

## Common Index Targets

```text
email
department_id
customer_id
order_date
created_at
```

---

# 🔹 Views

## Purpose

Simplify complex queries.

---

## Example

```sql
CREATE VIEW active_customers AS

SELECT *
FROM customers
WHERE status='Active';
```

---

## Benefits

* Reusability
* Security
* Simplicity

---

# 🔹 Transactions

## Purpose

Maintain consistency.

---

## Example

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

COMMIT;
```

---

# 🔹 ACID Properties

## Atomicity

All operations succeed or fail together.

---

## Consistency

Database remains valid.

---

## Isolation

Transactions do not interfere.

---

## Durability

Committed changes are permanent.

---

# 🔹 Security Design

## Authentication

Control who can access data.

---

## Authorization

Control what users can do.

---

## Principle of Least Privilege

Grant only required permissions.

---

## Sensitive Data

Protect:

```text
Passwords
Financial Data
Medical Data
Personal Information
```

---

# 🔹 Backup Strategy

## Full Backup

Complete database backup.

---

## Incremental Backup

Only changed data.

---

## Recommended

```text
Daily Incremental
Weekly Full Backup
```

---

# 🔹 Scalability Considerations

## Vertical Scaling

Increase server resources.

```text
More RAM
More CPU
More Storage
```

---

## Horizontal Scaling

Distribute data.

```text
Replication
Sharding
Partitioning
```

---

# 🔹 Database Design Patterns

## Master-Detail Pattern

Example:

```text
Orders
      ↓
Order_Items
```

---

## Lookup Table Pattern

Example:

```text
Countries
States
Departments
Categories
```

---

## Audit Pattern

Track changes.

```text
created_at
updated_at
deleted_at
```

---

# 🔹 Common Database Mistakes

## ❌ Missing Primary Keys

Every table should have one.

---

## ❌ No Foreign Keys

Leads to orphan data.

---

## ❌ Poor Naming

Creates confusion.

---

## ❌ Incorrect Data Types

Impacts performance.

---

## ❌ Excessive NULL Values

Reduces data quality.

---

## ❌ Over-Normalization

Too many joins.

---

## ❌ Under-Normalization

Duplicate data.

---

# 🔹 Real-World Database Examples

## Student Management System

Tables:

```text
students
courses
instructors
enrollments
attendance
exams
marks
```

---

## Employee Management System

Tables:

```text
employees
departments
attendance
payroll
performance_reviews
```

---

## E-Commerce System

Tables:

```text
customers
products
orders
payments
shipments
reviews
```

---

## Hospital Management System

Tables:

```text
patients
doctors
appointments
medical_records
prescriptions
billing
payments
```

---

# 📊 Database Design Checklist

## Requirements

* [ ] Business Requirements Collected
* [ ] Functional Requirements Defined

---

## Design

* [ ] Entities Identified
* [ ] Attributes Defined
* [ ] Relationships Mapped

---

## Schema

* [ ] Primary Keys Added
* [ ] Foreign Keys Added
* [ ] Constraints Added

---

## Quality

* [ ] Normalized to 3NF
* [ ] Naming Standards Followed
* [ ] Data Types Optimized

---

## Performance

* [ ] Indexes Created
* [ ] Queries Optimized

---

## Security

* [ ] Roles Defined
* [ ] Permissions Applied

---

## Documentation

* [ ] ER Diagram Created
* [ ] Schema Documented
* [ ] Business Rules Documented

---

# 🏆 Database Design Golden Rules

### Rule #1

Understand the business before creating tables.

---

### Rule #2

Design relationships carefully.

---

### Rule #3

Normalize first, optimize later.

---

### Rule #4

Always use primary keys.

---

### Rule #5

Protect data integrity with constraints.

---

### Rule #6

Choose proper data types.

---

### Rule #7

Use indexes wisely.

---

### Rule #8

Design for scalability.

---

### Rule #9

Document everything.

---

### Rule #10

Think like a Database Architect.

---

# 🚀 Database Design Workflow

```text
Business Problem
       ↓
Requirements Gathering
       ↓
Entity Identification
       ↓
Relationship Mapping
       ↓
Normalization
       ↓
Schema Design
       ↓
Implementation
       ↓
Indexing
       ↓
Optimization
       ↓
Production Deployment
```

Following this guide will help you design scalable, maintainable, and enterprise-grade databases suitable for backend systems, analytics platforms, data engineering pipelines, and AI/ML applications.
