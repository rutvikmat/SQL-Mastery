# Day 03 Quick Revision Notes

## DDL Commands

### CREATE

Creates database objects.

```sql
CREATE TABLE students();
```

---

### ALTER

Modifies existing tables.

```sql
ALTER TABLE students
ADD email VARCHAR(100);
```

---

### DROP

Deletes table.

```sql
DROP TABLE students;
```

---

### TRUNCATE

Deletes all rows.

```sql
TRUNCATE TABLE students;
```

---

## Constraints

### PRIMARY KEY

* Unique
* Not Null
* Identifies records

```sql
id INT PRIMARY KEY
```

---

### UNIQUE

No duplicates allowed.

```sql
email VARCHAR(100) UNIQUE
```

---

### NOT NULL

Mandatory value.

```sql
name VARCHAR(100) NOT NULL
```

---

### CHECK

Custom validation.

```sql
age INT CHECK(age >=18)
```

---

### DEFAULT

Default value.

```sql
status DEFAULT 'ACTIVE'
```

---

### FOREIGN KEY

Creates relationships.

```sql
FOREIGN KEY(student_id)
REFERENCES students(student_id)
```
