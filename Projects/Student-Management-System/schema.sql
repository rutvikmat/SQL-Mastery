-- STUDENTS

CREATE TABLE students(
student_id SERIAL PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15) UNIQUE,
gender VARCHAR(10),
dob DATE,
city VARCHAR(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INSTRUCTORS

CREATE TABLE instructors(
instructor_id SERIAL PRIMARY KEY,
instructor_name VARCHAR(100),
email VARCHAR(100) UNIQUE,
specialization VARCHAR(100)
);

-- COURSES

CREATE TABLE courses(
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100),
duration_months INT CHECK(duration_months > 0),
instructor_id INT,
FOREIGN KEY(instructor_id)
REFERENCES instructors(instructor_id)
);

-- ENROLLMENTS

CREATE TABLE enrollments(
enrollment_id SERIAL PRIMARY KEY,
student_id INT,
course_id INT,
enrollment_date DATE DEFAULT CURRENT_DATE,

```
FOREIGN KEY(student_id)
REFERENCES students(student_id),

FOREIGN KEY(course_id)
REFERENCES courses(course_id)
```

);

-- ATTENDANCE

CREATE TABLE attendance(
attendance_id SERIAL PRIMARY KEY,
student_id INT,
attendance_date DATE,
status VARCHAR(20),

```
FOREIGN KEY(student_id)
REFERENCES students(student_id)
```

);

-- EXAMS

CREATE TABLE exams(
exam_id SERIAL PRIMARY KEY,
exam_name VARCHAR(100),
course_id INT,

```
FOREIGN KEY(course_id)
REFERENCES courses(course_id)
```

);

-- MARKS

CREATE TABLE marks(
mark_id SERIAL PRIMARY KEY,
student_id INT,
exam_id INT,
marks_obtained DECIMAL(5,2),

```
FOREIGN KEY(student_id)
REFERENCES students(student_id),

FOREIGN KEY(exam_id)
REFERENCES exams(exam_id)
```

);
