CREATE TABLE students(
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments(
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT
);

INSERT INTO students VALUES
(1,'Rutvik'),
(2,'Kavya'),
(3,'Arjun');

INSERT INTO courses VALUES
(101,'SQL'),
(102,'Python');

INSERT INTO enrollments VALUES
(1,1,101),
(2,2,102);

SELECT s.name,
       c.course_name
FROM students s
INNER JOIN enrollments e
ON s.student_id=e.student_id
INNER JOIN courses c
ON e.course_id=c.course_id;

SELECT s.name,
       c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id=e.student_id
LEFT JOIN courses c
ON e.course_id=c.course_id;

SELECT *
FROM students s
FULL OUTER JOIN enrollments e
ON s.student_id=e.student_id;