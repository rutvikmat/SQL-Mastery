# Day 03 - DDL & Constraints

## Learning Objectives

By the end of Day 03 you will be able to:

* Create Tables Professionally
* Modify Existing Tables
* Delete Tables
* Truncate Tables
* Use Primary Keys
* Use Foreign Keys
* Apply UNIQUE Constraints
* Apply NOT NULL Constraints
* Apply CHECK Constraints
* Design Relational Databases

---

# What is DDL?

DDL stands for Data Definition Language.

Used to define database structure.

Commands:

```sql
CREATE
ALTER
DROP
TRUNCATE
```

---

# CREATE TABLE

Creates a new table.

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100)
);
```

---

# ALTER TABLE

Modifies an existing table.

Add column:

```sql
ALTER TABLE students
ADD email VARCHAR(100);
```

Rename column:

```sql
ALTER TABLE students
RENAME COLUMN name TO full_name;
```

---

# DROP TABLE

Deletes the table permanently.

```sql
DROP TABLE students;
```

⚠ Cannot be undone.

---

# TRUNCATE TABLE

Removes all records.

```sql
TRUNCATE TABLE students;
```

Table structure remains.

---

# Constraints

Constraints enforce data integrity.

Examples:

* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* NOT NULL
* CHECK
* DEFAULT

---

# PRIMARY KEY

Uniquely identifies each row.

```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
```

Rules:

* Unique
* Cannot be NULL
* One primary key per table

---

# UNIQUE

Prevents duplicate values.

```sql
email VARCHAR(100) UNIQUE
```

Valid:

```text
rutvik@gmail.com
kavya@gmail.com
```

Invalid:

```text
rutvik@gmail.com
rutvik@gmail.com
```

---

# NOT NULL

Ensures value is mandatory.

```sql
name VARCHAR(100) NOT NULL
```

Invalid:

```sql
INSERT INTO students(id)
VALUES(1);
```

---

# CHECK

Applies custom rules.

```sql
age INT CHECK(age >= 18)
```

Valid:

```text
25
```

Invalid:

```text
15
```

---

# DEFAULT

Provides default value.

```sql
status VARCHAR(20)
DEFAULT 'ACTIVE'
```

---

# FOREIGN KEY

Creates relationships.

Students Table

```sql
CREATE TABLE students(
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);
```

Courses Table

```sql
CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);
```

Enrollments Table

```sql
CREATE TABLE enrollments(
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY(student_id)
        REFERENCES students(student_id),
    FOREIGN KEY(course_id)
        REFERENCES courses(course_id)
);
```

---

# Why Constraints Matter

Without constraints:

❌ Duplicate records

❌ Invalid data

❌ Broken relationships

❌ Data corruption

With constraints:

✅ Reliable database

✅ Consistent data

✅ Production-ready systems

---

# Real World Example

Syncher Users

```sql
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK(age >= 13),
    status VARCHAR(20) DEFAULT 'ACTIVE'
);
```

---

# Skills Acquired

✅ Database Design

✅ Table Relationships

✅ Data Integrity

✅ Production Database Foundations

---

# Next Topic

Day 04 - DML Commands
INSERT | UPDATE | DELETE
