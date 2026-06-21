CREATE TABLE students(
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK(age >=18)
);

ALTER TABLE students
ADD city VARCHAR(50);

ALTER TABLE students
ADD status VARCHAR(20)
DEFAULT 'ACTIVE';

CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments(
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY(student_id)
    REFERENCES students(student_id),
    FOREIGN KEY(course_id)
    REFERENCES courses(course_id)
);

INSERT INTO students
VALUES(
    1,
    'Rutvik',
    'rutvik@gmail.com',
    25,
    'Bangalore',
    'ACTIVE'
);

DROP TABLE test_table;