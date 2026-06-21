WITH high_salary AS
(
    SELECT *
    FROM employees
    WHERE salary > 70000
)
SELECT *
FROM high_salary;

SELECT emp_name,
       salary,
       ROW_NUMBER()
       OVER(ORDER BY salary DESC)
FROM employees;

SELECT emp_name,
       salary,
       RANK()
       OVER(ORDER BY salary DESC)
FROM employees;

SELECT emp_name,
       salary,
       DENSE_RANK()
       OVER(ORDER BY salary DESC)
FROM employees;

WITH ranked AS
(
    SELECT *,
           DENSE_RANK()
           OVER(ORDER BY salary DESC) rnk
    FROM employees
)
SELECT *
FROM ranked
WHERE rnk = 2;

SELECT emp_name,
       salary,
       LEAD(salary)
       OVER(ORDER BY salary)
FROM employees;

SELECT emp_name,
       salary,
       LAG(salary)
       OVER(ORDER BY salary)
FROM employees;