INSERT INTO students
VALUES(
    1,
    'Rutvik',
    25,
    'Bangalore'
);

INSERT INTO students
VALUES
(2,'Kavya',24,'Mysore'),
(3,'Arjun',22,'Hubli'),
(4,'Riya',21,'Belgaum'),
(5,'Rahul',26,'Mysore');

INSERT INTO students(
    id,
    name,
    city
)
VALUES(
    6,
    'Sneha',
    'Bangalore'
);

UPDATE students
SET city='Mumbai'
WHERE id=1;

UPDATE students
SET age=25
WHERE id=2;

UPDATE students
SET age=23,
    city='Bangalore'
WHERE id=3;

DELETE FROM students
WHERE id=5;

DELETE FROM students
WHERE city='Mysore';

INSERT INTO students
VALUES
(7,'Ananya',23,'Bangalore'),
(8,'Kiran',24,'Hubli'),
(9,'Neha',22,'Mysore');

UPDATE students
SET city='Bengaluru'
WHERE city='Bangalore';