# SQL System Design Guide

## SQL-Mastery-Portfolio

---

# Introduction

SQL System Design is a critical skill for:

* Backend Developers
* Software Engineers
* Data Engineers
* Database Architects
* Senior Engineers
* Staff Engineers

This guide covers how SQL databases are designed, scaled, optimized, and maintained in production systems.

---

# Table of Contents

1. Database Design Fundamentals
2. Schema Design
3. Normalization & Denormalization
4. Indexing Strategy
5. Scaling Databases
6. Replication
7. Partitioning
8. Sharding
9. Caching
10. High Availability
11. Database Security
12. Real System Design Scenarios
13. Interview Questions

---

# DATABASE DESIGN FUNDAMENTALS

---

## What Makes a Good Database Design?

A good database design should provide:

* Data Integrity
* Scalability
* Maintainability
* Security
* Performance

Goals:

```text
Fast Reads
+
Fast Writes
+
Data Consistency
+
Scalability
=
Good Database Design
```

---

## Database Design Process

```text
Requirements Gathering
        ↓
Entity Identification
        ↓
ER Diagram
        ↓
Normalization
        ↓
Schema Design
        ↓
Indexing
        ↓
Optimization
        ↓
Deployment
```

---

# SCHEMA DESIGN

---

## Example: Employee Management System

### Employees

```sql
CREATE TABLE employees
(
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(12,2),
    department_id INT,
    joining_date DATE
);
```

### Departments

```sql
CREATE TABLE departments
(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100)
);
```

Relationship:

```text
Departments (1)
      |
      |
Employees (Many)
```

---

# NORMALIZATION

---

## First Normal Form (1NF)

Rules:

* No repeating groups
* Atomic values only

Bad:

```text
employee_id | skills
1           | Java,Python,SQL
```

Good:

```text
employee_id | skill
1           | Java
1           | Python
1           | SQL
```

---

## Second Normal Form (2NF)

Requirements:

* 1NF
* No partial dependency

---

## Third Normal Form (3NF)

Requirements:

* 2NF
* No transitive dependency

---

## BCNF

Every determinant must be a candidate key.

---

# DENORMALIZATION

---

## Why Denormalize?

Used when:

* Reads are much higher than writes
* Reporting systems
* Analytics systems

Example:

Instead of joining 5 tables:

```text
Orders
+
Customers
+
Products
+
Categories
+
Payments
```

Store precomputed reporting data.

---

# INDEXING STRATEGY

---

## Single Column Index

```sql
CREATE INDEX idx_email
ON employees(email);
```

---

## Composite Index

```sql
CREATE INDEX idx_department_salary
ON employees
(
department_id,
salary
);
```

---

## Covering Index

Contains all required columns.

```sql
CREATE INDEX idx_employee_lookup
ON employees
(
department_id,
salary,
joining_date
);
```

---

## Indexing Rules

Index:

✅ WHERE columns

✅ JOIN columns

✅ ORDER BY columns

✅ GROUP BY columns

Avoid indexing:

❌ Frequently updated columns

❌ Small tables

---

# DATABASE SCALING

---

## Vertical Scaling

Increase:

* CPU
* RAM
* SSD

```text
4 CPU
 ↓
32 CPU
```

Advantages:

* Simple

Disadvantages:

* Limited

---

## Horizontal Scaling

Add more servers.

```text
DB Server 1
DB Server 2
DB Server 3
```

Advantages:

* Massive scalability

Disadvantages:

* More complexity

---

# REPLICATION

---

## What is Replication?

Copying data to multiple servers.

---

## Primary-Replica Architecture

```text
          Primary
             |
    -----------------
    |       |       |
 Replica Replica Replica
```

Writes:

```text
Primary
```

Reads:

```text
Replicas
```

Benefits:

* Read scalability
* High availability

---

# PARTITIONING

---

## What is Partitioning?

Split large tables into smaller partitions.

---

## Range Partitioning

Example:

```sql
CREATE TABLE sales
(
sale_date DATE
)
PARTITION BY RANGE(sale_date);
```

---

## List Partitioning

Example:

```sql
PARTITION BY LIST(region);
```

---

## Hash Partitioning

Example:

```sql
PARTITION BY HASH(customer_id);
```

---

## Benefits

* Faster queries
* Easier maintenance
* Better scalability

---

# SHARDING

---

## What is Sharding?

Splitting data across multiple database servers.

Example:

```text
Users 1-1M
      ↓
Shard 1

Users 1M-2M
      ↓
Shard 2

Users 2M-3M
      ↓
Shard 3
```

---

## Sharding Key

Common Keys:

* User ID
* Customer ID
* Region

---

## Challenges

* Cross-shard joins
* Transactions
* Rebalancing

---

# CACHING

---

## Why Use Cache?

Avoid hitting database repeatedly.

---

## Redis Example

```text
Application
     |
Redis Cache
     |
PostgreSQL
```

---

## Benefits

* Faster response
* Reduced DB load

---

# HIGH AVAILABILITY

---

## Goals

Avoid downtime.

---

## Architecture

```text
Load Balancer
       |
   Primary DB
       |
    Replicas
```

---

## Failover

If primary fails:

```text
Replica → New Primary
```

---

# DATABASE SECURITY

---

## Authentication

Use:

```sql
CREATE USER app_user;
```

---

## Authorization

```sql
GRANT SELECT
ON employees
TO app_user;
```

---

## Encryption

Encrypt:

* Data at Rest
* Data in Transit

Use:

```text
SSL/TLS
```

---

# REAL SYSTEM DESIGN SCENARIOS

---

# Scenario 1

## Design Instagram Database

Entities:

```text
Users
Posts
Comments
Likes
Followers
Messages
```

Relationships:

```text
Users
  |
Posts
  |
Comments
```

---

## Scaling Strategy

* PostgreSQL
* Read Replicas
* Redis Cache
* CDN
* Sharding by User ID

---

# Scenario 2

## Design E-Commerce Database

Entities:

```text
Customers
Products
Orders
Payments
Reviews
```

Tables:

```text
customers
products
orders
order_items
payments
reviews
```

---

## Scaling Strategy

* Partition Orders
* Index Product Searches
* Redis Caching

---

# Scenario 3

## Design Banking System

Requirements:

* ACID Compliance
* Transactions
* Audit Logs

Tables:

```text
accounts
transactions
beneficiaries
audit_logs
```

---

## Architecture

```text
Application
      |
PostgreSQL
      |
Replication
      |
Backup
```

---

# Scenario 4

## Design Hospital Management System

Entities:

```text
Patients
Doctors
Appointments
Prescriptions
Bills
```

---

## Optimization

Indexes:

```sql
CREATE INDEX idx_patient
ON appointments(patient_id);

CREATE INDEX idx_doctor
ON appointments(doctor_id);
```

---

# INTERVIEW QUESTIONS

---

## Q1. Difference Between Partitioning and Sharding?

| Partitioning   | Sharding            |
| -------------- | ------------------- |
| Same Server    | Multiple Servers    |
| Easier         | Harder              |
| Faster Queries | Massive Scalability |

---

## Q2. How Do You Scale PostgreSQL?

### Answer

1. Indexing
2. Query Optimization
3. Read Replicas
4. Partitioning
5. Caching
6. Sharding

---

## Q3. How Would You Handle 100 Million Rows?

### Answer

* Partitioning
* Proper Indexing
* Materialized Views
* Read Replicas

---

## Q4. Why Use Read Replicas?

### Answer

To distribute read traffic.

```text
Reads → Replica
Writes → Primary
```

---

## Q5. How Would You Design a High Traffic System?

### Answer

```text
Load Balancer
       |
Application Servers
       |
Redis Cache
       |
PostgreSQL Primary
       |
Read Replicas
```

---

# Senior-Level Interview Topics

---

## Must Know

* Normalization
* Denormalization
* Indexing
* Replication
* Partitioning
* Sharding
* Caching
* High Availability

---

## Staff Engineer Topics

* Multi-region Databases
* Distributed Transactions
* CQRS
* Event Sourcing
* Data Warehousing

---

# System Design Interview Checklist

## Database Design

* [ ] ER Diagrams
* [ ] Relationships
* [ ] Constraints

---

## Performance

* [ ] Indexes
* [ ] Query Optimization
* [ ] Caching

---

## Scalability

* [ ] Replication
* [ ] Partitioning
* [ ] Sharding

---

## Reliability

* [ ] Backups
* [ ] Failover
* [ ] Disaster Recovery

---

# SQL System Design Formula

```text
Good Schema
      +
Indexes
      +
Caching
      +
Replication
      +
Partitioning
      +
Monitoring
      =
Scalable SQL System
```

---

# Summary

## Topics Covered

* Database Design
* Normalization
* Denormalization
* Indexing
* Replication
* Partitioning
* Sharding
* Caching
* High Availability
* Security
* System Design Interviews

## Target Roles

* Backend Developer
* Data Engineer
* Database Administrator
* Software Engineer
* Senior Engineer
* Staff Engineer

---

**Portfolio Status:** SQL System Design Ready 🚀
