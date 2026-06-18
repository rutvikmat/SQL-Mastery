# Day 01 - SQL Fundamentals

## 🎯 Learning Objectives

By the end of Day 01, you will be able to:

* Understand Databases and RDBMS
* Understand SQL and PostgreSQL
* Create Databases
* Create Tables
* Insert Records
* Retrieve Data using SELECT
* Understand SQL Syntax
* Work with Basic Data Types

---

# What is a Database?

A database is an organized collection of data that can be stored, managed, and retrieved efficiently.

Example:

| ID | Name   | City      |
| -- | ------ | --------- |
| 1  | Rutvik | Bangalore |
| 2  | Kavya  | Mysore    |

---

# What is DBMS?

Database Management System (DBMS) is software used to create and manage databases.

Examples:

* PostgreSQL
* MySQL
* Oracle
* SQL Server

---

# What is RDBMS?

Relational Database Management System stores data in related tables.

Example:

Students Table

| student_id | name   |
| ---------- | ------ |
| 1          | Rutvik |

Courses Table

| course_id | course_name |
| --------- | ----------- |
| 101       | SQL         |

Enrollments Table

| student_id | course_id |
| ---------- | --------- |
| 1          | 101       |

---

# SQL vs NoSQL

| SQL               | NoSQL           |
| ----------------- | --------------- |
| Relational        | Non Relational  |
| Fixed Schema      | Flexible Schema |
| Supports JOINs    | No JOINs        |
| ACID Transactions | BASE            |
| PostgreSQL        | MongoDB         |

---

# SQL Syntax

```sql
SELECT * FROM students;
```

---

# Data Types

## Numeric

```sql
INT
BIGINT
DECIMAL
FLOAT
```

## Character

```sql
VARCHAR
CHAR
TEXT
```

## Date & Time

```sql
DATE
TIME
TIMESTAMP
```

## Boolean

```sql
BOOLEAN
```

---

# Creating Database

```sql
CREATE DATABASE sql_mastery;
```

---

# Creating Table

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    city VARCHAR(50)
);
```

---

# Insert Data

```sql
INSERT INTO students
VALUES (1,'Rutvik',25,'Bangalore');
```

---

# Retrieve Data

```sql
SELECT * FROM students;
```

---

# Commands Learned

* CREATE DATABASE
* CREATE TABLE
* INSERT
* SELECT

---

# Key Takeaways

✅ Database stores data

✅ PostgreSQL is an RDBMS

✅ SQL is used to communicate with databases

✅ Tables store records

✅ SELECT retrieves data

✅ INSERT adds data

---

# Next Topic

Day 02 - Filtering & Sorting Data
