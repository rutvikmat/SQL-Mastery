-- =========================================
-- EMPLOYEE MANAGEMENT SYSTEM SCHEMA
-- =========================================

-- DEPARTMENTS

CREATE TABLE departments(
department_id SERIAL PRIMARY KEY,
department_name VARCHAR(100) UNIQUE NOT NULL,
location VARCHAR(100)
);

-- POSITIONS

CREATE TABLE positions(
position_id SERIAL PRIMARY KEY,
position_name VARCHAR(100) NOT NULL,
salary_grade VARCHAR(20)
);

-- EMPLOYEES

CREATE TABLE employees(
employee_id SERIAL PRIMARY KEY,

```
full_name VARCHAR(100) NOT NULL,

email VARCHAR(100)
UNIQUE NOT NULL,

phone VARCHAR(15),

gender VARCHAR(10),

hire_date DATE,

salary DECIMAL(12,2)
CHECK(salary > 0),

department_id INT,

position_id INT,

manager_id INT,

FOREIGN KEY(department_id)
REFERENCES departments(department_id),

FOREIGN KEY(position_id)
REFERENCES positions(position_id),

FOREIGN KEY(manager_id)
REFERENCES employees(employee_id)
```

);

-- ATTENDANCE

CREATE TABLE attendance(
attendance_id SERIAL PRIMARY KEY,

```
employee_id INT,

attendance_date DATE,

status VARCHAR(20)
CHECK(status IN
('Present','Absent','Late','Leave')),

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
```

);

-- PAYROLL

CREATE TABLE payroll(
payroll_id SERIAL PRIMARY KEY,

```
employee_id INT,

basic_salary DECIMAL(12,2),

bonus DECIMAL(12,2),

deductions DECIMAL(12,2),

payment_date DATE,

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
```

);

-- PERFORMANCE REVIEWS

CREATE TABLE performance_reviews(
review_id SERIAL PRIMARY KEY,

```
employee_id INT,

review_date DATE,

performance_score INT
CHECK(performance_score BETWEEN 1 AND 10),

remarks TEXT,

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
```

);

-- PROMOTIONS

CREATE TABLE promotions(
promotion_id SERIAL PRIMARY KEY,

```
employee_id INT,

old_position VARCHAR(100),

new_position VARCHAR(100),

promotion_date DATE,

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
```

);
