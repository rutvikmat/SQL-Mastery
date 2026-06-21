CREATE VIEW student_performance AS
SELECT
s.student_id,
s.full_name,
ROUND(
AVG(m.marks_obtained),
2
) average_marks
FROM students s
JOIN marks m
ON s.student_id=m.student_id
GROUP BY
s.student_id,
s.full_name;

CREATE VIEW course_enrollment_summary AS
SELECT
c.course_name,
COUNT(e.student_id)
AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name;

CREATE VIEW attendance_dashboard AS
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
) attendance_percentage
FROM attendance
GROUP BY student_id;

CREATE VIEW instructor_dashboard AS
SELECT
i.instructor_name,
COUNT(c.course_id)
AS courses_assigned
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id=c.instructor_id
GROUP BY i.instructor_name;
