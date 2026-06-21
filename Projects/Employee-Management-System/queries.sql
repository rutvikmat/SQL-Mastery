-- ==========================================
-- BASIC QUERIES (1-10)
-- ==========================================

SELECT * FROM employees;
SELECT full_name,email FROM employees;
SELECT * FROM employees WHERE salary > 100000;
SELECT * FROM employees WHERE gender='Female';
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY hire_date DESC;
SELECT DISTINCT gender FROM employees;
SELECT * FROM employees LIMIT 5;
SELECT * FROM employees WHERE full_name LIKE 'R%';
SELECT * FROM employees WHERE hire_date > '2023-01-01';

-- ==========================================
-- AGGREGATE QUERIES (11-20)
-- ==========================================

COUNT()
AVG()
SUM()
MAX()
MIN()
GROUP BY department
GROUP BY gender
HAVING salary conditions

-- ==========================================
-- JOIN QUERIES (21-35)
-- ==========================================

Employee + Department
Employee + Position
Employee + Manager
Employee + Payroll
Employee + Attendance
Employee + Performance
Department + Employee Count
Position + Employee Count
Promotion History
Full Employee Dashboard

-- ==========================================
-- SUBQUERIES (36-45)
-- ==========================================

Highest Salary
Lowest Salary
Second Highest Salary
Third Highest Salary
Above Average Salary
Below Average Salary
Employees in Highest Paying Department
Promotion Eligible Employees
Departments Above Average Salary

-- ==========================================
-- FUNCTIONS (46-52)
-- ==========================================

UPPER()
LOWER()
CONCAT()
LENGTH()
ROUND()
EXTRACT()
CURRENT_DATE

-- ==========================================
-- CTE QUERIES (53-57)
-- ==========================================

Department Salary Report
Promotion Candidates
Top Performers
Payroll Analysis
Attendance Analysis

-- ==========================================
-- WINDOW FUNCTIONS (58-65)
-- ==========================================

ROW_NUMBER()
RANK()
DENSE_RANK()
LEAD()
LAG()
PARTITION BY Department
Top Earner Per Department
Bottom Earner Per Department

-- ==========================================
-- RECURSIVE CTE (66-70)
-- ==========================================

Employee Hierarchy
Manager Reporting Tree
Organization Structure