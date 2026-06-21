-- ==========================================
-- EXECUTIVE KPIs
-- ==========================================

SELECT COUNT(*) total_employees
FROM employees;

SELECT COUNT(*) total_departments
FROM departments;

SELECT ROUND(AVG(salary),2)
AS average_salary
FROM employees;

SELECT MAX(salary)
AS highest_salary
FROM employees;

SELECT MIN(salary)
AS lowest_salary
FROM employees;

-- ==========================================
-- EMPLOYEE ANALYTICS
-- ==========================================

SELECT
full_name,
salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

SELECT
full_name,
salary
FROM employees
ORDER BY salary ASC
LIMIT 10;

SELECT
gender,
COUNT(*)
FROM employees
GROUP BY gender;

-- ==========================================
-- DEPARTMENT ANALYTICS
-- ==========================================

SELECT
d.department_name,
COUNT(e.employee_id)
AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.department_id=e.department_id
GROUP BY d.department_name;

SELECT
d.department_name,
ROUND(AVG(e.salary),2)
AS avg_salary
FROM departments d
JOIN employees e
ON d.department_id=e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- ==========================================
-- PAYROLL ANALYTICS
-- ==========================================

SELECT
SUM(
basic_salary +
bonus -
deductions
)
AS total_payroll
FROM payroll;

SELECT
AVG(
basic_salary +
bonus -
deductions
)
AS average_payroll
FROM payroll;

-- ==========================================
-- PERFORMANCE ANALYTICS
-- ==========================================

SELECT
e.full_name,
AVG(pr.performance_score)
AS avg_score
FROM employees e
JOIN performance_reviews pr
ON e.employee_id=pr.employee_id
GROUP BY e.full_name
ORDER BY avg_score DESC;

SELECT
e.full_name
FROM employees e
JOIN performance_reviews pr
ON e.employee_id=pr.employee_id
GROUP BY e.full_name
HAVING AVG(pr.performance_score)>=8;

-- ==========================================
-- ATTENDANCE ANALYTICS
-- ==========================================

SELECT
employee_id,
ROUND(
100.0 *
SUM(
CASE
WHEN status='Present'
THEN 1
ELSE 0
END
)
/
COUNT(*),
2
)
AS attendance_percentage
FROM attendance
GROUP BY employee_id;

-- ==========================================
-- SALARY RANKING
-- ==========================================

SELECT
full_name,
salary,
RANK()
OVER(
ORDER BY salary DESC
)
AS salary_rank
FROM employees;

-- ==========================================
-- TOP EARNER PER DEPARTMENT
-- ==========================================

WITH ranked_employees AS
(
SELECT
e.full_name,
d.department_name,
e.salary,

ROW_NUMBER()
OVER(
PARTITION BY d.department_name
ORDER BY e.salary DESC
) rn

FROM employees e
JOIN departments d
ON e.department_id=d.department_id
)

SELECT *
FROM ranked_employees
WHERE rn=1;
