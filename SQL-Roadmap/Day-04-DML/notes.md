# Day 04 Quick Revision Notes

## DML

Data Manipulation Language

Commands:

```sql
INSERT
UPDATE
DELETE
```

---

## INSERT

Adds records.

```sql
INSERT INTO students
VALUES(1,'Rutvik',25,'Bangalore');
```

---

## UPDATE

Modifies records.

```sql
UPDATE students
SET city='Mumbai'
WHERE id=1;
```

---

## DELETE

Removes records.

```sql
DELETE FROM students
WHERE id=1;
```

---

## CRUD

Create → INSERT

Read → SELECT

Update → UPDATE

Delete → DELETE

---

## Safety Rule

Always use WHERE with UPDATE and DELETE.

Bad:

```sql
UPDATE students
SET city='Delhi';
```

Bad:

```sql
DELETE FROM students;
```

These affect every row.
