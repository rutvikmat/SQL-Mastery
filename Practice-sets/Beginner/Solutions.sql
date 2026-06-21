-- =====================================================
-- BEGINNER SQL PRACTICE SET
-- SOLUTIONS
-- =====================================================

-- Q1
SELECT * FROM employees;

-- Q2
SELECT full_name FROM employees;

-- Q3
SELECT full_name,salary
FROM employees;

-- Q4
SELECT DISTINCT city
FROM employees;

-- Q5
SELECT DISTINCT department
FROM employees;

-- Q6
SELECT *
FROM employees
LIMIT 5;

-- Q7
SELECT *
FROM employees
LIMIT 10;

-- Q8
SELECT salary
FROM employees;

-- Q9
SELECT joining_date
FROM employees;

-- Q10
SELECT employee_id
FROM employees;

-- Q11
SELECT *
FROM employees
WHERE city='Bangalore';

-- Q12
SELECT *
FROM employees
WHERE city='Mysore';

-- Q13
SELECT *
FROM employees
WHERE salary > 50000;

-- Q14
SELECT *
FROM employees
WHERE salary < 30000;

-- Q15
SELECT *
FROM employees
WHERE salary >= 70000;

-- Q16
SELECT *
FROM employees
WHERE department='IT';

-- Q17
SELECT *
FROM employees
WHERE department='HR';

-- Q18
SELECT *
FROM employees
WHERE city='Delhi';

-- Q19
SELECT *
FROM employees
WHERE joining_date > '2023-01-01';

-- Q20
SELECT *
FROM employees
WHERE joining_date < '2022-01-01';

-- Q21
SELECT *
FROM employees
ORDER BY salary ASC;

-- Q22
SELECT *
FROM employees
ORDER BY salary DESC;

-- Q23
SELECT *
FROM employees
ORDER BY full_name;

-- Q24
SELECT *
FROM employees
ORDER BY joining_date;

-- Q25
SELECT *
FROM employees
ORDER BY department,salary DESC;

-- Q26
SELECT COUNT(*)
FROM employees;

-- Q27
SELECT MAX(salary)
FROM employees;

-- Q28
SELECT MIN(salary)
FROM employees;

-- Q29
SELECT AVG(salary)
FROM employees;

-- Q30
SELECT SUM(salary)
FROM employees;

-- Q31
SELECT COUNT(*)
FROM employees
WHERE city='Bangalore';

-- Q32
SELECT COUNT(*)
FROM employees
WHERE department='IT';

-- Q33
SELECT AVG(salary)
FROM employees
WHERE department='IT';

-- Q34
SELECT MAX(salary)
FROM employees
WHERE department='HR';

-- Q35
SELECT MIN(salary)
FROM employees
WHERE department='Marketing';

-- Q36
SELECT department,
COUNT(*)
FROM employees
GROUP BY department;

-- Q37
SELECT city,
COUNT(*)
FROM employees
GROUP BY city;

-- Q38
SELECT department,
AVG(salary)
FROM employees
GROUP BY department;

-- Q39
SELECT department,
MAX(salary)
FROM employees
GROUP BY department;

-- Q40
SELECT department,
MIN(salary)
FROM employees
GROUP BY department;

-- Q41
SELECT department,
SUM(salary)
FROM employees
GROUP BY department;

-- Q42
SELECT department,
COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Q43
SELECT city,
COUNT(*)
FROM employees
GROUP BY city
HAVING COUNT(*) > 3;

-- Q44
SELECT city,
AVG(salary)
FROM employees
GROUP BY city;

-- Q45
SELECT department,
AVG(salary)
FROM employees
GROUP BY department
ORDER BY AVG(salary) DESC
LIMIT 1;

-- Q46
INSERT INTO employees
(
full_name,
department,
salary,
city,
joining_date
)
VALUES
(
'Rutvik Mathapati',
'IT',
85000,
'Bangalore',
CURRENT_DATE
);

-- Q47
UPDATE employees
SET salary=90000
WHERE employee_id=1;

-- Q48
UPDATE employees
SET department='Finance'
WHERE employee_id=5;

-- Q49
DELETE FROM employees
WHERE employee_id=10;

-- Q50
UPDATE employees
SET salary=salary*1.10;
