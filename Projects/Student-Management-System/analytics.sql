-- ==========================================
-- EXECUTIVE DASHBOARD
-- ==========================================

SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_courses
FROM courses;

SELECT COUNT(*) AS total_instructors
FROM instructors;

SELECT COUNT(*) AS total_enrollments
FROM enrollments;

SELECT ROUND(
AVG(marks_obtained),
2
) AS average_marks
FROM marks;

-- ==========================================
-- STUDENT ANALYTICS
-- ==========================================

SELECT
s.full_name,
ROUND(
AVG(m.marks_obtained),
2
) avg_marks
FROM students s
JOIN marks m
ON s.student_id=m.student_id
GROUP BY s.full_name
ORDER BY avg_marks DESC
LIMIT 10;

SELECT
s.full_name,
ROUND(
AVG(m.marks_obtained),
2
) avg_marks
FROM students s
JOIN marks m
ON s.student_id=m.student_id
GROUP BY s.full_name
ORDER BY avg_marks ASC
LIMIT 10;

-- ==========================================
-- ATTENDANCE ANALYTICS
-- ==========================================

SELECT
student_id,
ROUND(
100.0 *
SUM(
CASE
WHEN status='Present'
THEN 1
ELSE 0
END
)
/ COUNT(*),
2
)
AS attendance_percentage
FROM attendance
GROUP BY student_id;

-- ==========================================
-- COURSE ANALYTICS
-- ==========================================

SELECT
c.course_name,
COUNT(e.student_id)
AS enrolled_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name
ORDER BY enrolled_students DESC;

-- ==========================================
-- INSTRUCTOR ANALYTICS
-- ==========================================

SELECT
i.instructor_name,
COUNT(c.course_id)
AS courses_assigned
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id=c.instructor_id
GROUP BY i.instructor_name;

-- ==========================================
-- PERFORMANCE ANALYTICS
-- ==========================================

SELECT
s.full_name,
MAX(m.marks_obtained)
AS highest_marks
FROM students s
JOIN marks m
ON s.student_id=m.student_id
GROUP BY s.full_name
ORDER BY highest_marks DESC;

WITH ranked_students AS
(
SELECT
s.full_name,
AVG(m.marks_obtained) avg_marks,
ROW_NUMBER()
OVER(
ORDER BY AVG(m.marks_obtained) DESC
) rn
FROM students s
JOIN marks m
ON s.student_id=m.student_id
GROUP BY s.full_name
)
SELECT *
FROM ranked_students
WHERE rn <= 3;
