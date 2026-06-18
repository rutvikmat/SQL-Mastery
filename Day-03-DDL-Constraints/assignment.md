# Day 03 Assignment

## Task 1

Create database:

college_db

---

## Task 2

Create Students Table

Columns:

- student_id PRIMARY KEY
- full_name NOT NULL
- email UNIQUE
- age CHECK(age >=18)
- city
- status DEFAULT ACTIVE

---

## Task 3

Create Courses Table

Columns:

- course_id PRIMARY KEY
- course_name NOT NULL
- duration_months

---

## Task 4

Create Enrollments Table

Columns:

- enrollment_id PRIMARY KEY
- student_id FOREIGN KEY
- course_id FOREIGN KEY
- enrollment_date

---

## Task 5

Insert

5 Students

5 Courses

10 Enrollments

---

## Task 6

Test Constraints

Try:

- Duplicate Email
- NULL Name
- Age < 18

Observe Errors

---

## Challenge Project

Design LMS Database

Tables:

users
courses
modules
lessons
enrollments

Apply:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints

This mirrors the LMS project you've worked on previously.

---

## Interview Questions

1. Difference between DELETE, DROP, and TRUNCATE?
2. What is a Primary Key?
3. What is a Foreign Key?
4. Difference between UNIQUE and PRIMARY KEY?
5. Why use CHECK constraints?
6. What is Data Integrity?