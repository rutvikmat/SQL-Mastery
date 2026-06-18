# Day 02 - Filtering & Sorting Data

## Learning Objectives

By the end of Day 02 you will be able to:

* Filter records using WHERE
* Use Comparison Operators
* Use Logical Operators
* Sort data using ORDER BY
* Remove duplicates using DISTINCT
* Limit records using LIMIT
* Search patterns using LIKE
* Filter ranges using BETWEEN
* Filter multiple values using IN

---

# Sample Table

students

| id | name   | age | city      |
| -- | ------ | --- | --------- |
| 1  | Rutvik | 25  | Bangalore |
| 2  | Kavya  | 24  | Mysore    |
| 3  | Arjun  | 22  | Hubli     |
| 4  | Riya   | 21  | Bangalore |
| 5  | Rahul  | 26  | Mysore    |

---

# WHERE Clause

Used to filter rows.

```sql
SELECT *
FROM students
WHERE age > 23;
```

---

# Comparison Operators

```sql
=
>
<
>=
<=
<>
!=
```

Examples:

```sql
SELECT * FROM students
WHERE city = 'Bangalore';
```

```sql
SELECT * FROM students
WHERE age >= 25;
```

---

# Logical Operators

## AND

```sql
SELECT *
FROM students
WHERE city='Bangalore'
AND age > 22;
```

---

## OR

```sql
SELECT *
FROM students
WHERE city='Bangalore'
OR city='Mysore';
```

---

## NOT

```sql
SELECT *
FROM students
WHERE NOT city='Bangalore';
```

---

# DISTINCT

Remove duplicates.

```sql
SELECT DISTINCT city
FROM students;
```

Output:

Bangalore

Mysore

Hubli

---

# ORDER BY

Ascending:

```sql
SELECT *
FROM students
ORDER BY age ASC;
```

Descending:

```sql
SELECT *
FROM students
ORDER BY age DESC;
```

---

# LIMIT

Show limited rows.

```sql
SELECT *
FROM students
LIMIT 3;
```

---

# LIKE

Pattern Matching.

Starts with R

```sql
SELECT *
FROM students
WHERE name LIKE 'R%';
```

Ends with a

```sql
SELECT *
FROM students
WHERE name LIKE '%a';
```

Contains ut

```sql
SELECT *
FROM students
WHERE name LIKE '%ut%';
```

---

# BETWEEN

Range filtering.

```sql
SELECT *
FROM students
WHERE age BETWEEN 22 AND 25;
```

---

# IN

Multiple values.

```sql
SELECT *
FROM students
WHERE city IN ('Bangalore','Mysore');
```

---

# Skills Acquired

✅ Filtering Data

✅ Sorting Data

✅ Pattern Searching

✅ Range Queries

✅ Duplicate Removal

✅ Top N Queries

---

# Next Topic

Day 03 - DDL & Constraints
