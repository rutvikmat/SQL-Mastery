# Day 04 - Data Manipulation Language (DML)

## Learning Objectives

By the end of Day 04, you will be able to:

* Insert Records
* Update Existing Records
* Delete Records
* Understand CRUD Operations
* Manipulate Production Data Safely
* Write Real-World Data Modification Queries

---

# What is DML?

DML = Data Manipulation Language

Used to work with the data stored inside tables.

Commands:

```sql
INSERT
UPDATE
DELETE
```

---

# INSERT Statement

Used to add records.

Syntax:

```sql
INSERT INTO table_name
VALUES (...);
```

Example:

```sql
INSERT INTO students
VALUES (
    1,
    'Rutvik',
    25,
    'Bangalore'
);
```

---

# INSERT Specific Columns

```sql
INSERT INTO students(
    id,
    name,
    city
)
VALUES(
    2,
    'Kavya',
    'Mysore'
);
```

---

# Multiple Inserts

```sql
INSERT INTO students
VALUES
(3,'Arjun',22,'Hubli'),
(4,'Riya',21,'Belgaum'),
(5,'Rahul',24,'Mysore');
```

---

# UPDATE Statement

Used to modify records.

Syntax:

```sql
UPDATE table_name
SET column_name=value
WHERE condition;
```

---

# Update One Record

```sql
UPDATE students
SET city='Bangalore'
WHERE id=3;
```

---

# Update Multiple Columns

```sql
UPDATE students
SET age=26,
    city='Mumbai'
WHERE id=1;
```

---

# WARNING

Without WHERE:

```sql
UPDATE students
SET city='Delhi';
```

Every row gets updated.

---

# DELETE Statement

Used to remove records.

Syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

---

# Delete One Record

```sql
DELETE FROM students
WHERE id=5;
```

---

# Delete Multiple Records

```sql
DELETE FROM students
WHERE city='Mysore';
```

---

# DANGEROUS QUERY

```sql
DELETE FROM students;
```

Deletes ALL rows.

---

# CRUD Operations

| Operation | SQL    |
| --------- | ------ |
| Create    | INSERT |
| Read      | SELECT |
| Update    | UPDATE |
| Delete    | DELETE |

---

# Real World Example

User Registration

```sql
INSERT INTO users(...)
VALUES(...);
```

Profile Update

```sql
UPDATE users
SET email='new@gmail.com'
WHERE user_id=1;
```

Delete Account

```sql
DELETE FROM users
WHERE user_id=1;
```

---

# Skills Acquired

✅ Insert Data

✅ Modify Data

✅ Remove Data

✅ CRUD Operations

✅ Production Data Handling

---

# Next Topic

Day 05 - Aggregate Functions
COUNT | SUM | AVG | MIN | MAX
