# Day 01 Quick Revision Notes

## Database

Collection of organized data.

---

## DBMS

Software that manages databases.

Examples:

* PostgreSQL
* MySQL
* Oracle

---

## RDBMS

Stores data in related tables.

Uses:

* Primary Keys
* Foreign Keys

---

## SQL

Structured Query Language

Used for:

* Creating databases
* Creating tables
* Inserting data
* Retrieving data

---

## Common Data Types

### Numeric

```sql
INT
BIGINT
DECIMAL
FLOAT
```

### Text

```sql
VARCHAR
TEXT
```

### Date

```sql
DATE
TIMESTAMP
```

### Boolean

```sql
BOOLEAN
```

---

## Commands

### Create Database

```sql
CREATE DATABASE sql_mastery;
```

### Create Table

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    city VARCHAR(50)
);
```

### Insert Data

```sql
INSERT INTO students
VALUES (1,'Rutvik',25,'Bangalore');
```

### Select Data

```sql
SELECT * FROM students;
```

---

## Interview Notes

What is SQL?

SQL is a language used to interact with relational databases.

What is PostgreSQL?

An open-source relational database management system.

What is a Table?

A collection of rows and columns.

What is a Row?

A single record.

What is a Column?

An attribute of a record.
