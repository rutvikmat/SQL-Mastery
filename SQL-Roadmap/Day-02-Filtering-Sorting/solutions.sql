SELECT *
FROM students
WHERE age > 22;

SELECT *
FROM students
WHERE city='Bangalore';

SELECT *
FROM students
WHERE age >= 25;

SELECT *
FROM students
WHERE city='Bangalore'
AND age > 22;

SELECT *
FROM students
WHERE city='Bangalore'
OR city='Mysore';

SELECT *
FROM students
WHERE NOT city='Bangalore';

SELECT DISTINCT city
FROM students;

SELECT *
FROM students
ORDER BY age ASC;

SELECT *
FROM students
ORDER BY age DESC;

SELECT *
FROM students
LIMIT 3;

SELECT *
FROM students
WHERE name LIKE 'R%';

SELECT *
FROM students
WHERE name LIKE '%a';

SELECT *
FROM students
WHERE name LIKE '%ut%';

SELECT *
FROM students
WHERE age BETWEEN 22 AND 25;

SELECT *
FROM students
WHERE city IN ('Bangalore','Mysore');

SELECT *
FROM students
ORDER BY age ASC
LIMIT 1;

SELECT *
FROM students
ORDER BY age DESC
LIMIT 1;

SELECT *
FROM students
ORDER BY age DESC
LIMIT 2;