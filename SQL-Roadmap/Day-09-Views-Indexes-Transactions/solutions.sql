CREATE VIEW it_employees AS
SELECT *
FROM employees
WHERE department='IT';

CREATE VIEW high_salary_employees AS
SELECT *
FROM employees
WHERE salary > 70000;

CREATE OR REPLACE VIEW
high_salary_employees AS
SELECT *
FROM employees
WHERE salary > 80000;

DROP VIEW high_salary_employees;

CREATE INDEX idx_email
ON employees(email);

CREATE INDEX idx_department
ON employees(department);

BEGIN;

UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 1;

ROLLBACK;

BEGIN;

UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 1;

COMMIT;

CREATE MATERIALIZED VIEW dept_salary_report AS
SELECT department,
       AVG(salary)
FROM employees
GROUP BY department;

REFRESH MATERIALIZED VIEW dept_salary_report;