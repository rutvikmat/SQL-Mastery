-- ==========================================================
-- INTERMEDIATE SQL PRACTICE SET
-- SOLUTIONS
-- ==========================================================

-- ==========================================================
-- SECTION 1 : JOINS (Q1 - Q20)
-- ==========================================================

-- Q1
SELECT
e.full_name,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- Q2
SELECT
e.full_name,
d.location
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- Q3
SELECT
e.*
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'IT';

-- Q4
SELECT
e.full_name,
e.salary,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- Q5
SELECT
e.full_name AS employee,
m.full_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- Q6
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;

-- Q7
SELECT *
FROM employees
WHERE manager_id IS NULL;

-- Q8
SELECT
d.department_name,
COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Q9
SELECT
e.full_name,
p.project_name
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
JOIN projects p
ON ep.project_id = p.project_id;

-- Q10
SELECT
p.project_name,
e.full_name
FROM projects p
JOIN employee_projects ep
ON p.project_id = ep.project_id
JOIN employees e
ON ep.employee_id = e.employee_id;

-- Q11
SELECT
e.full_name,
d.department_name,
p.project_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
JOIN projects p
ON ep.project_id = p.project_id;

-- Q12
SELECT
e.*
FROM employees e
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;

-- Q13
SELECT
p.*
FROM projects p
LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;

-- Q14
SELECT
d.*
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- Q15
SELECT
e.full_name AS employee,
m.full_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- Q16
SELECT
e.full_name,
e.salary,
m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- Q17
SELECT
e.full_name,
m.full_name
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.department_id = m.department_id;

-- Q18
SELECT
e.full_name,
COUNT(ep.project_id) AS project_count
FROM employees e
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY e.full_name;

-- Q19
SELECT
d.department_name,
COUNT(ep.project_id) AS total_projects
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY d.department_name
ORDER BY total_projects DESC;

-- Q20
SELECT
e.full_name,
d.department_name,
p.project_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
LEFT JOIN projects p
ON ep.project_id = p.project_id;

-- ==========================================================
-- SECTION 2 : AGGREGATE FUNCTIONS (Q21 - Q35)
-- ==========================================================

-- Q21
SELECT COUNT(*)
FROM employees;

-- Q22
SELECT COUNT(*)
FROM departments;

-- Q23
SELECT COUNT(*)
FROM projects;

-- Q24
SELECT SUM(salary)
FROM employees;

-- Q25
SELECT AVG(salary)
FROM employees;

-- Q26
SELECT MAX(salary)
FROM employees;

-- Q27
SELECT MIN(salary)
FROM employees;

-- Q28
SELECT
department_id,
COUNT(*)
FROM employees
GROUP BY department_id;

-- Q29
SELECT
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;

-- Q30
SELECT
department_id,
MAX(salary)
FROM employees
GROUP BY department_id;

-- Q31
SELECT
department_id,
MIN(salary)
FROM employees
GROUP BY department_id;

-- Q32
SELECT
city,
COUNT(*)
FROM employees
GROUP BY city;

-- Q33
SELECT
department_id,
COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;

-- Q34
SELECT
city,
COUNT(*)
FROM employees
GROUP BY city
HAVING COUNT(*) > 10;

-- Q35
SELECT
department_id,
AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

-- ==========================================================
-- SECTION 3 : SUBQUERIES (Q36 - Q50)
-- ==========================================================

-- Q36
-- Find employees earning above average salary

SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);

-- ----------------------------------------------------------

-- Q37
-- Find employees earning below average salary

SELECT *
FROM employees
WHERE salary <
(
    SELECT AVG(salary)
    FROM employees
);

-- ----------------------------------------------------------

-- Q38
-- Find highest paid employee

SELECT *
FROM employees
WHERE salary =
(
    SELECT MAX(salary)
    FROM employees
);

-- ----------------------------------------------------------

-- Q39
-- Find second highest salary

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
);

-- ----------------------------------------------------------

-- Q40
-- Find third highest salary

SELECT MAX(salary) AS third_highest_salary
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
    WHERE salary <
    (
        SELECT MAX(salary)
        FROM employees
    )
);

-- ----------------------------------------------------------

-- Q41
-- Find employees in department with highest average salary

SELECT *
FROM employees
WHERE department_id =
(
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- ----------------------------------------------------------

-- Q42
-- Find employees working in largest department

SELECT *
FROM employees
WHERE department_id =
(
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- ----------------------------------------------------------

-- Q43
-- Find departments with above average employee count

SELECT department_id,
       COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) >
(
    SELECT AVG(employee_count)
    FROM
    (
        SELECT COUNT(*) AS employee_count
        FROM employees
        GROUP BY department_id
    ) dept_counts
);

-- ----------------------------------------------------------

-- Q44
-- Find projects with above average budget

SELECT *
FROM projects
WHERE budget >
(
    SELECT AVG(budget)
    FROM projects
);

-- ----------------------------------------------------------

-- Q45
-- Find employees assigned to most expensive project

SELECT DISTINCT
e.employee_id,
e.full_name
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id =
(
    SELECT project_id
    FROM projects
    ORDER BY budget DESC
    LIMIT 1
);

-- ----------------------------------------------------------

-- Q46
-- Find employees not assigned to projects

SELECT *
FROM employees
WHERE employee_id NOT IN
(
    SELECT employee_id
    FROM employee_projects
);

-- ----------------------------------------------------------

-- Q47
-- Find departments with no projects

SELECT *
FROM departments
WHERE department_id NOT IN
(
    SELECT DISTINCT e.department_id
    FROM employees e
    JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
);

-- ----------------------------------------------------------

-- Q48
-- Find employees hired after department average joining date

SELECT *
FROM employees e1
WHERE joining_date >
(
    SELECT AVG(joining_date)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ----------------------------------------------------------

-- Q49
-- Find employees earning more than department average

SELECT *
FROM employees e1
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ----------------------------------------------------------

-- Q50
-- Find departments whose average salary exceeds company average

SELECT
department_id,
AVG(salary) AS department_avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) >
(
    SELECT AVG(salary)
    FROM employees
);

-- ==========================================================
-- END OF SECTION 3 : SUBQUERIES
-- ==========================================================

-- ==========================================================
-- SECTION 4 : STRING FUNCTIONS (Q51 - Q58)
-- ==========================================================

-- Q51
-- Convert employee names to uppercase

SELECT
employee_id,
UPPER(full_name) AS employee_name_upper
FROM employees;

-- ----------------------------------------------------------

-- Q52
-- Convert employee names to lowercase

SELECT
employee_id,
LOWER(full_name) AS employee_name_lower
FROM employees;

-- ----------------------------------------------------------

-- Q53
-- Find length of employee names

SELECT
employee_id,
full_name,
LENGTH(full_name) AS name_length
FROM employees;

-- ----------------------------------------------------------

-- Q54
-- Display first 3 characters of employee names

SELECT
employee_id,
full_name,
SUBSTRING(full_name,1,3) AS first_three_chars
FROM employees;

-- ----------------------------------------------------------

-- Q55
-- Concatenate employee name and city

SELECT
employee_id,
CONCAT(full_name,' - ',city) AS employee_city
FROM employees;

-- ----------------------------------------------------------

-- Q56
-- Find employees whose names start with 'A'

SELECT *
FROM employees
WHERE full_name LIKE 'A%';

-- ----------------------------------------------------------

-- Q57
-- Find employees whose names end with 'N'

SELECT *
FROM employees
WHERE UPPER(full_name) LIKE '%N';

-- ----------------------------------------------------------

-- Q58
-- Replace city Bangalore with Bengaluru

SELECT
employee_id,
full_name,
REPLACE(city,'Bangalore','Bengaluru') AS updated_city
FROM employees;

-- ==========================================================
-- END OF SECTION 4 : STRING FUNCTIONS
-- ==========================================================
-- ==========================================================
-- SECTION 6 : CASE STATEMENTS (Q66 - Q75)
-- ==========================================================

-- Q66
-- Categorize salaries into High, Medium, Low

SELECT
employee_id,
full_name,
salary,

CASE
    WHEN salary >= 100000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
END AS salary_category

FROM employees;

-- ----------------------------------------------------------

-- Q67
-- Categorize employees by experience

SELECT
employee_id,
full_name,
joining_date,

CASE
    WHEN AGE(CURRENT_DATE, joining_date) >= INTERVAL '10 years'
        THEN 'Senior'

    WHEN AGE(CURRENT_DATE, joining_date) >= INTERVAL '5 years'
        THEN 'Mid-Level'

    ELSE 'Junior'
END AS experience_level

FROM employees;

-- ----------------------------------------------------------

-- Q68
-- Classify departments by employee count

SELECT
department_id,
COUNT(*) AS employee_count,

CASE
    WHEN COUNT(*) >= 50 THEN 'Large'
    WHEN COUNT(*) >= 20 THEN 'Medium'
    ELSE 'Small'
END AS department_size

FROM employees
GROUP BY department_id;

-- ----------------------------------------------------------

-- Q69
-- Display bonus percentage based on salary

SELECT
employee_id,
full_name,
salary,

CASE
    WHEN salary >= 150000 THEN '20%'
    WHEN salary >= 100000 THEN '15%'
    WHEN salary >= 50000 THEN '10%'
    ELSE '5%'
END AS bonus_percentage

FROM employees;

-- ----------------------------------------------------------

-- Q70
-- Categorize projects by budget

SELECT
project_id,
project_name,
budget,

CASE
    WHEN budget >= 1000000 THEN 'Enterprise'
    WHEN budget >= 500000 THEN 'Large'
    WHEN budget >= 100000 THEN 'Medium'
    ELSE 'Small'
END AS project_category

FROM projects;

-- ----------------------------------------------------------

-- Q71
-- Generate employee performance category

SELECT
employee_id,
full_name,
salary,

CASE
    WHEN salary >= 150000 THEN 'Excellent'
    WHEN salary >= 100000 THEN 'Good'
    WHEN salary >= 50000 THEN 'Average'
    ELSE 'Needs Improvement'
END AS performance_category

FROM employees;

-- ----------------------------------------------------------

-- Q72
-- Assign salary grades

SELECT
employee_id,
full_name,
salary,

CASE
    WHEN salary >= 200000 THEN 'Grade A'
    WHEN salary >= 150000 THEN 'Grade B'
    WHEN salary >= 100000 THEN 'Grade C'
    WHEN salary >= 50000 THEN 'Grade D'
    ELSE 'Grade E'
END AS salary_grade

FROM employees;

-- ----------------------------------------------------------

-- Q73
-- Determine retirement eligibility

SELECT
employee_id,
full_name,
joining_date,

CASE
    WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date)) >= 35
         THEN 'Eligible'

    ELSE 'Not Eligible'
END AS retirement_status

FROM employees;

-- ----------------------------------------------------------

-- Q74
-- Classify employees by city

SELECT
employee_id,
full_name,
city,

CASE
    WHEN city = 'Bangalore' THEN 'South'
    WHEN city = 'Chennai' THEN 'South'
    WHEN city = 'Hyderabad' THEN 'South'
    WHEN city = 'Delhi' THEN 'North'
    WHEN city = 'Mumbai' THEN 'West'
    ELSE 'Other'
END AS region

FROM employees;

-- ----------------------------------------------------------

-- Q75
-- Generate custom salary band report

SELECT
employee_id,
full_name,
salary,

CASE
    WHEN salary < 50000 THEN 'Band-1'
    WHEN salary BETWEEN 50000 AND 99999 THEN 'Band-2'
    WHEN salary BETWEEN 100000 AND 149999 THEN 'Band-3'
    WHEN salary BETWEEN 150000 AND 199999 THEN 'Band-4'
    ELSE 'Band-5'
END AS salary_band

FROM employees;

-- ==========================================================
-- END OF SECTION 6
-- ==========================================================
-- ==========================================================
-- SECTION 7 : VIEWS (Q76 - Q80)
-- ==========================================================

-- Q76
-- Create employee summary view

CREATE VIEW employee_summary_view AS

SELECT
employee_id,
full_name,
salary,
city
FROM employees;

-- ----------------------------------------------------------

-- Q77
-- Create department analytics view

CREATE VIEW department_analytics_view AS

SELECT
department_id,
COUNT(*) AS employee_count,
AVG(salary) AS avg_salary,
SUM(salary) AS total_salary

FROM employees

GROUP BY department_id;

-- ----------------------------------------------------------

-- Q78
-- Create project assignment view

CREATE VIEW project_assignment_view AS

SELECT
e.employee_id,
e.full_name,
p.project_id,
p.project_name

FROM employees e

JOIN employee_projects ep
ON e.employee_id = ep.employee_id

JOIN projects p
ON ep.project_id = p.project_id;

-- ----------------------------------------------------------

-- Q79
-- Create salary report view

CREATE VIEW salary_report_view AS

SELECT
employee_id,
full_name,
department_id,
salary

FROM employees;

-- ----------------------------------------------------------

-- Q80
-- Query data from created views

SELECT *
FROM employee_summary_view;

SELECT *
FROM department_analytics_view;

SELECT *
FROM project_assignment_view;

SELECT *
FROM salary_report_view;

-- ==========================================================
-- END OF SECTION 7
-- ==========================================================
-- ==========================================================
-- SECTION 8 : INDEXES (Q81 - Q85)
-- ==========================================================

-- Q81
-- Create index on employee name

CREATE INDEX idx_employee_name
ON employees(full_name);

-- ----------------------------------------------------------

-- Q82
-- Create index on department_id

CREATE INDEX idx_department
ON employees(department_id);

-- ----------------------------------------------------------

-- Q83
-- Create index on salary

CREATE INDEX idx_salary
ON employees(salary);

-- ----------------------------------------------------------

-- Q84
-- Create composite index

CREATE INDEX idx_department_salary
ON employees(department_id, salary);

-- ----------------------------------------------------------

-- Q85
-- View existing indexes (PostgreSQL)

SELECT
indexname,
indexdef
FROM pg_indexes
WHERE tablename = 'employees';

-- ==========================================================
-- END OF SECTION 8
-- ==========================================================

-- ==========================================================
-- SECTION 9 : BUSINESS ANALYTICS (Q86 - Q100)
-- ==========================================================

-- Q86
-- Top 5 highest paid employees

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- ----------------------------------------------------------

-- Q87
-- Top 5 departments by salary expense

SELECT
department_id,
SUM(salary) AS total_salary

FROM employees

GROUP BY department_id

ORDER BY total_salary DESC

LIMIT 5;

-- ----------------------------------------------------------

-- Q88
-- Department salary distribution

SELECT
department_id,
COUNT(*) AS employees,
MIN(salary) AS min_salary,
MAX(salary) AS max_salary,
AVG(salary) AS avg_salary

FROM employees

GROUP BY department_id;

-- ----------------------------------------------------------

-- Q89
-- Employee growth by year

SELECT
EXTRACT(YEAR FROM joining_date) AS joining_year,
COUNT(*) AS employee_count

FROM employees

GROUP BY joining_year

ORDER BY joining_year;

-- ----------------------------------------------------------

-- Q90
-- Project assignment statistics

SELECT
p.project_name,
COUNT(ep.employee_id) AS assigned_employees

FROM projects p

LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id

GROUP BY p.project_name

ORDER BY assigned_employees DESC;

-- ----------------------------------------------------------

-- Q91
-- Department performance dashboard

SELECT
department_id,
COUNT(*) AS employees,
AVG(salary) AS avg_salary,
SUM(salary) AS total_salary

FROM employees

GROUP BY department_id;

-- ----------------------------------------------------------

-- Q92
-- Employee salary ranking

SELECT
employee_id,
full_name,
salary,

RANK()
OVER(
ORDER BY salary DESC
) AS salary_rank

FROM employees;

-- ----------------------------------------------------------

-- Q93
-- Department budget utilization report

SELECT
d.department_name,
SUM(p.budget) AS total_project_budget

FROM departments d

JOIN employees e
ON d.department_id = e.department_id

JOIN employee_projects ep
ON e.employee_id = ep.employee_id

JOIN projects p
ON ep.project_id = p.project_id

GROUP BY d.department_name;

-- ----------------------------------------------------------

-- Q94
-- City-wise employee analytics

SELECT
city,
COUNT(*) AS employee_count,
AVG(salary) AS avg_salary,
SUM(salary) AS total_salary

FROM employees

GROUP BY city

ORDER BY employee_count DESC;

-- ----------------------------------------------------------

-- Q95
-- Monthly hiring trends

SELECT
EXTRACT(YEAR FROM joining_date) AS year,
EXTRACT(MONTH FROM joining_date) AS month,
COUNT(*) AS hires

FROM employees

GROUP BY year, month

ORDER BY year, month;

-- ----------------------------------------------------------

-- Q96
-- Employee retention analysis

SELECT
department_id,

ROUND(
AVG(
EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date))
),
2
) AS avg_tenure_years

FROM employees

GROUP BY department_id;

-- ----------------------------------------------------------

-- Q97
-- Average tenure by department

SELECT
department_id,

ROUND(
AVG(
EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date))
),
2
) AS avg_experience

FROM employees

GROUP BY department_id;

-- ----------------------------------------------------------

-- Q98
-- Top performing departments

SELECT
department_id,
AVG(salary) AS avg_salary

FROM employees

GROUP BY department_id

ORDER BY avg_salary DESC;

-- ----------------------------------------------------------

-- Q99
-- Executive workforce summary report

SELECT

COUNT(*) AS total_employees,

COUNT(DISTINCT department_id)
AS total_departments,

AVG(salary)
AS average_salary,

MAX(salary)
AS highest_salary,

MIN(salary)
AS lowest_salary

FROM employees;

-- ----------------------------------------------------------

-- Q100
-- Complete HR Analytics Dashboard

SELECT

(SELECT COUNT(*) FROM employees)
AS total_employees,

(SELECT COUNT(DISTINCT department_id)
 FROM employees)
AS total_departments,

(SELECT AVG(salary)
 FROM employees)
AS avg_salary,

(SELECT MAX(salary)
 FROM employees)
AS highest_salary,

(SELECT MIN(salary)
 FROM employees)
AS lowest_salary,

(SELECT COUNT(*)
 FROM projects)
AS total_projects;

-- ==========================================================
-- END OF SECTION 9
-- END OF INTERMEDIATE SQL SOLUTIONS
-- ==========================================================
