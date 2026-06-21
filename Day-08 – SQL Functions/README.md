# Day 08 - SQL Functions

## Learning Objectives

By the end of Day 08 you will be able to:

* Work with String Functions
* Work with Numeric Functions
* Work with Date Functions
* Handle NULL Values
* Use Conditional Expressions
* Build Professional Reports

---

# SQL Function Categories

1. String Functions
2. Numeric Functions
3. Date Functions
4. Conditional Functions

---

# STRING FUNCTIONS

## UPPER()

Converts text to uppercase.

```sql
SELECT UPPER('rutvik');
```

Output:

```text
RUTVIK
```

---

## LOWER()

Converts text to lowercase.

```sql
SELECT LOWER('RUTVIK');
```

Output:

```text
rutvik
```

---

## LENGTH()

Returns number of characters.

```sql
SELECT LENGTH('Rutvik');
```

Output:

```text
6
```

---

## CONCAT()

Combines strings.

```sql
SELECT CONCAT('Rutvik',' ','Mathapati');
```

Output:

```text
Rutvik Mathapati
```

---

## SUBSTRING()

Extracts part of a string.

```sql
SELECT SUBSTRING('PostgreSQL',1,4);
```

Output:

```text
Post
```

---

## REPLACE()

Replace text.

```sql
SELECT REPLACE(
    'I Love MySQL',
    'MySQL',
    'PostgreSQL'
);
```

Output:

```text
I Love PostgreSQL
```

---

# NUMERIC FUNCTIONS

## ROUND()

Rounds values.

```sql
SELECT ROUND(15.678,2);
```

Output:

```text
15.68
```

---

## ABS()

Absolute value.

```sql
SELECT ABS(-25);
```

Output:

```text
25
```

---

## MOD()

Remainder.

```sql
SELECT MOD(10,3);
```

Output:

```text
1
```

---

## FLOOR()

Rounds down.

```sql
SELECT FLOOR(15.9);
```

Output:

```text
15
```

---

## CEILING()

Rounds up.

```sql
SELECT CEILING(15.1);
```

Output:

```text
16
```

---

# DATE FUNCTIONS

## CURRENT_DATE

Returns today's date.

```sql
SELECT CURRENT_DATE;
```

---

## CURRENT_TIME

Returns current time.

```sql
SELECT CURRENT_TIME;
```

---

## CURRENT_TIMESTAMP

Returns date and time.

```sql
SELECT CURRENT_TIMESTAMP;
```

---

## AGE()

Calculate age.

```sql
SELECT AGE('2000-01-01');
```

---

## EXTRACT()

Extract year, month, day.

```sql
SELECT EXTRACT(YEAR FROM CURRENT_DATE);
```

---

## DATE_PART()

Alternative extraction.

```sql
SELECT DATE_PART(
    'month',
    CURRENT_DATE
);
```

---

# CONDITIONAL FUNCTIONS

## COALESCE()

Returns first non-null value.

```sql
SELECT COALESCE(NULL,NULL,'SQL');
```

Output:

```text
SQL
```

---

## NULLIF()

Returns NULL if values match.

```sql
SELECT NULLIF(10,10);
```

Output:

```text
NULL
```

---

## CASE

SQL's IF-ELSE.

```sql
SELECT emp_name,
       salary,
       CASE
           WHEN salary > 70000
           THEN 'High'
           ELSE 'Normal'
       END
FROM employees;
```

---

# Real World Example

Syncher Analytics

```sql
SELECT user_id,
       cycle_length,
       CASE
           WHEN cycle_length > 30
           THEN 'Long Cycle'
           ELSE 'Normal Cycle'
       END
FROM syncher_users;
```

---

# Skills Acquired

✅ Data Formatting

✅ Data Cleaning

✅ Conditional Logic

✅ Date Handling

✅ Professional Reporting

---

# Next Topic

Day 09 - Views, Indexes & Transactions
