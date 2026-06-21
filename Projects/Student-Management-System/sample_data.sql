-- STUDENTS

INSERT INTO students
(full_name,email,phone,gender,dob,city)
VALUES
('Rutvik Mathapati','[rutvik@gmail.com](mailto:rutvik@gmail.com)','9876543210','Male','2000-05-15','Bangalore'),
('Kavya Bhavikatti','[kavya@gmail.com](mailto:kavya@gmail.com)','9876543211','Female','2001-03-20','Hubli'),
('Arjun Kumar','[arjun@gmail.com](mailto:arjun@gmail.com)','9876543212','Male','2002-01-10','Mysore'),
('Sneha Rao','[sneha@gmail.com](mailto:sneha@gmail.com)','9876543213','Female','2001-07-12','Bangalore'),
('Rahul Patil','[rahul@gmail.com](mailto:rahul@gmail.com)','9876543214','Male','2000-09-18','Belgaum');

-- INSTRUCTORS

INSERT INTO instructors
(instructor_name,email,specialization)
VALUES
('Dr Sharma','[sharma@gmail.com](mailto:sharma@gmail.com)','Database Systems'),
('Dr Rao','[rao@gmail.com](mailto:rao@gmail.com)','Artificial Intelligence'),
('Dr Verma','[verma@gmail.com](mailto:verma@gmail.com)','Machine Learning');

-- COURSES

INSERT INTO courses
(course_name,duration_months,instructor_id)
VALUES
('SQL Mastery',3,1),
('Python Programming',4,1),
('Machine Learning',6,2),
('Deep Learning',6,3);

-- ENROLLMENTS

INSERT INTO enrollments
(student_id,course_id)
VALUES
(1,1),
(1,3),
(2,1),
(2,2),
(3,2),
(3,3),
(4,1),
(4,4),
(5,3);

-- EXAMS

INSERT INTO exams
(exam_name,course_id)
VALUES
('SQL Mid Exam',1),
('Python Assessment',2),
('ML Assessment',3),
('DL Assessment',4);

-- MARKS

INSERT INTO marks
(student_id,exam_id,marks_obtained)
VALUES
(1,1,92),
(2,1,85),
(3,2,78),
(4,4,88),
(5,3,82);

-- ATTENDANCE

INSERT INTO attendance
(student_id,attendance_date,status)
VALUES
(1,'2025-01-01','Present'),
(1,'2025-01-02','Present'),
(2,'2025-01-01','Absent'),
(3,'2025-01-01','Present'),
(4,'2025-01-01','Late');
