SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary <
(
    SELECT AVG(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary =
(
    SELECT MAX(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary =
(
    SELECT MIN(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE department IN
(
    SELECT department
    FROM employees
    WHERE salary > 60000
);

SELECT *
FROM departments d
WHERE EXISTS
(
    SELECT 1
    FROM employees e
    WHERE e.department = d.department_name
);

SELECT *
FROM employees e1
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department=e2.department
);