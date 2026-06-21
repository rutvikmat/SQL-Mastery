# Employee Management System Documentation

## Project Description

The Employee Management System is a PostgreSQL database project designed to simulate a real-world Human Resource Management System (HRMS).

The system manages:

* Employees
* Departments
* Positions
* Payroll
* Attendance
* Performance Reviews
* Promotions

---

## Database Design

### Tables

1. departments
2. positions
3. employees
4. attendance
5. payroll
6. performance_reviews
7. promotions

---

## Relationships

Department → Employees

Position → Employees

Employee → Attendance

Employee → Payroll

Employee → Performance Reviews

Employee → Promotions

Employee → Manager (Self Join)

---

## SQL Concepts Covered

### DDL

* CREATE
* ALTER
* DROP

### DML

* INSERT
* UPDATE
* DELETE

### Constraints

* Primary Key
* Foreign Key
* Unique
* Check
* Not Null

### Advanced SQL

* JOINs
* Subqueries
* Views
* CTE
* Window Functions
* Recursive CTE

---

## Analytics Modules

### Employee Analytics

* Salary Analysis
* Employee Distribution

### Payroll Analytics

* Net Salary
* Payroll Cost

### Performance Analytics

* Employee Rankings
* Promotion Candidates

### Attendance Analytics

* Attendance Percentage
* Low Attendance Employees

### Executive Dashboard

* Total Employees
* Total Departments
* Average Salary
* Total Payroll

---

## Future Scope

### HR Features

* Leave Management
* Recruitment Tracking
* Shift Scheduling

### AI Features

* Attrition Prediction
* Promotion Prediction
* Salary Recommendation Engine
* Workforce Forecasting

---

## Learning Outcomes

This project demonstrates:

* Relational Database Design
* PostgreSQL Development
* Business Intelligence Reporting
* Advanced SQL Querying
* HR Analytics

---

## Author

Rutvik Mathapati

PhD Scholar (AI/ML)

Alliance University
