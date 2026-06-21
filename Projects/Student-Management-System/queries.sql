-- ==========================================
-- BASIC QUERIES
-- ==========================================

SELECT * FROM students;

SELECT full_name,email FROM students;

SELECT * FROM students WHERE city='Bangalore';

SELECT * FROM students WHERE gender='Female';

SELECT * FROM students ORDER BY full_name;

SELECT * FROM students ORDER BY created_at DESC;

SELECT * FROM students LIMIT 5;

SELECT DISTINCT city FROM students;

SELECT * FROM students WHERE full_name LIKE 'R%';

SELECT * FROM students WHERE dob > '2001-01-01';

-- ==========================================
-- AGGREGATE QUERIES
-- ==========================================

SELECT COUNT(*) FROM students;

SELECT COUNT(*) FROM courses;

SELECT AVG(marks_obtained) FROM marks;

SELECT MAX(marks_obtained) FROM marks;

SELECT MIN(marks_obtained) FROM marks;

SELECT student_id,
AVG(marks_obtained)
FROM marks
GROUP BY student_id;

SELECT course_id,
COUNT(*)
FROM enrollments
GROUP BY course_id;

SELECT city,
COUNT(*)
FROM students
GROUP BY city;

SELECT student_id,
AVG(marks_obtained)
FROM marks
GROUP BY student_id
HAVING AVG(marks_obtained)>80;

SELECT COUNT(*) FROM exams;

-- ==========================================
-- JOIN QUERIES
-- ==========================================

SELECT
s.full_name,
c.course_name
FROM enrollments e
JOIN students s
ON e.student_id=s.student_id
JOIN courses c
ON e.course_id=c.course_id;

SELECT
s.full_name,
c.course_name,
i.instructor_name
FROM enrollments e
JOIN students s
ON e.student_id=s.student_id
JOIN courses c
ON e.course_id=c.course_id
JOIN instructors i
ON c.instructor_id=i.instructor_id;

SELECT
s.full_name,
m.marks_obtained
FROM students s
JOIN marks m
ON s.student_id=m.student_id;

SELECT
s.full_name,
a.status
FROM students s
JOIN attendance a
ON s.student_id=a.student_id;

SELECT
c.course_name,
COUNT(e.student_id)
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name;

-- ==========================================
-- SUBQUERIES
-- ==========================================

SELECT *
FROM marks
WHERE marks_obtained=
(
SELECT MAX(marks_obtained)
FROM marks
);

SELECT *
FROM marks
WHERE marks_obtained=
(
SELECT MIN(marks_obtained)
FROM marks
);

SELECT *
FROM students
WHERE student_id IN
(
SELECT student_id
FROM marks
GROUP BY student_id
HAVING AVG(marks_obtained)>
(
SELECT AVG(marks_obtained)
FROM marks
)
);

SELECT *
FROM students
WHERE student_id IN
(
SELECT student_id
FROM enrollments
);

-- ==========================================
-- FUNCTIONS
-- ==========================================

SELECT UPPER(full_name)
FROM students;

SELECT LOWER(full_name)
FROM students;

SELECT LENGTH(full_name)
FROM students;

SELECT CURRENT_DATE;

SELECT CURRENT_TIMESTAMP;

SELECT ROUND(AVG(marks_obtained),2)
FROM marks;

SELECT EXTRACT(YEAR FROM CURRENT_DATE);

SELECT CONCAT(full_name,' - ',city)
FROM students;

SELECT COALESCE(NULL,'N/A');

SELECT NULLIF(100,100);

-- ==========================================
-- CTE
-- ==========================================

WITH high_performers AS
(
SELECT
student_id,
AVG(marks_obtained) avg_marks
FROM marks
GROUP BY student_id
)
SELECT *
FROM high_performers
WHERE avg_marks > 80;

-- ==========================================
-- WINDOW FUNCTIONS
-- ==========================================

SELECT
student_id,
marks_obtained,
ROW_NUMBER()
OVER(
ORDER BY marks_obtained DESC
)
FROM marks;

SELECT
student_id,
marks_obtained,
RANK()
OVER(
ORDER BY marks_obtained DESC
)
FROM marks;

SELECT
student_id,
marks_obtained,
DENSE_RANK()
OVER(
ORDER BY marks_obtained DESC
)
FROM marks;

SELECT
student_id,
marks_obtained,
LAG(marks_obtained)
OVER(
ORDER BY exam_id
)
FROM marks;

SELECT
student_id,
marks_obtained,
LEAD(marks_obtained)
OVER(
ORDER BY exam_id
)
FROM marks;
