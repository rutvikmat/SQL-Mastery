SELECT COUNT(*)
FROM employees;

SELECT SUM(salary)
FROM employees;

SELECT AVG(salary)
FROM employees;

SELECT MIN(salary)
FROM employees;

SELECT MAX(salary)
FROM employees;

SELECT department,
       COUNT(*)
FROM employees
GROUP BY department;

SELECT department,
       SUM(salary)
FROM employees
GROUP BY department;

SELECT department,
       AVG(salary)
FROM employees
GROUP BY department;

SELECT department,
       MAX(salary)
FROM employees
GROUP BY department;

SELECT department,
       MIN(salary)
FROM employees
GROUP BY department;

SELECT department,
       COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;

SELECT department,
       AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;