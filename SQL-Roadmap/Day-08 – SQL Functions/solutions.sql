SELECT UPPER(emp_name)
FROM employees;

SELECT LOWER(emp_name)
FROM employees;

SELECT LENGTH(emp_name)
FROM employees;

SELECT CONCAT(first_name,' ',last_name)
FROM employees;

SELECT SUBSTRING(emp_name,1,3)
FROM employees;

SELECT REPLACE(city,
               'Bangalore',
               'Bengaluru')
FROM employees;

SELECT ROUND(salary,2)
FROM employees;

SELECT ABS(-500);

SELECT MOD(10,3);

SELECT FLOOR(15.8);

SELECT CEILING(15.1);

SELECT CURRENT_DATE;

SELECT CURRENT_TIME;

SELECT CURRENT_TIMESTAMP;

SELECT EXTRACT(
       YEAR
       FROM CURRENT_DATE
);

SELECT EXTRACT(
       MONTH
       FROM CURRENT_DATE
);

SELECT emp_name,
       salary,
       CASE
           WHEN salary > 70000
           THEN 'High Salary'
           ELSE 'Normal Salary'
       END
FROM employees;

SELECT COALESCE(
       NULL,
       NULL,
       'SQL'
);

SELECT NULLIF(10,10);