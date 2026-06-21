# Student Management System Documentation

## Project Overview

The Student Management System is a PostgreSQL-based database project designed to manage students, courses, enrollments, attendance, examinations, and academic performance.

The project demonstrates database design, normalization, SQL querying, reporting, and analytics capabilities.

---

## Database Modules

### Students

Stores student profile information.

### Instructors

Stores faculty information.

### Courses

Stores course details and ownership.

### Enrollments

Manages student-course mapping.

### Attendance

Tracks daily attendance records.

### Exams

Stores examination details.

### Marks

Stores examination results.

---

## Entity Relationships

Students → Enrollments ← Courses

Courses → Instructors

Students → Attendance

Students → Marks ← Exams

Exams → Courses

---

## SQL Concepts Used

### DDL

* CREATE TABLE
* ALTER TABLE
* DROP TABLE

### DML

* INSERT
* UPDATE
* DELETE

### Constraints

* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* NOT NULL
* CHECK

### Advanced SQL

* JOINs
* Aggregate Functions
* Subqueries
* Views
* CTEs
* Window Functions

---

## Analytics Implemented

### Student Analytics

* Top Students
* Bottom Students
* Student Ranking

### Attendance Analytics

* Attendance Percentage
* Low Attendance Identification

### Course Analytics

* Course Popularity
* Enrollment Distribution

### Instructor Analytics

* Instructor Workload
* Student Distribution

### Executive Dashboard

* Total Students
* Total Courses
* Total Faculty
* Total Enrollments
* Average Marks

---

## Future Enhancements

* Student Fee Management
* Department Management
* Semester Management
* AI-based Performance Prediction
* Student Risk Analysis
* Attendance Prediction
* Academic Recommendation System

---

## Learning Outcomes

This project demonstrates practical knowledge of:

* PostgreSQL
* Relational Database Design
* Query Optimization
* Data Analytics
* Business Intelligence Reporting
* Backend Database Development

---

## Author

Rutvik Mathapati

PhD Scholar (Computer Science & Engineering - AI/ML)
Alliance University
