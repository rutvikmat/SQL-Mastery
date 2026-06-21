-- ==========================================
-- EMPLOYEE DASHBOARD VIEW
-- ==========================================

CREATE VIEW employee_dashboard AS
SELECT
e.employee_id,
e.full_name,
d.department_name,
p.position_name,
e.salary,
e.hire_date
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
JOIN positions p
ON e.position_id=p.position_id;

-- ==========================================
-- PAYROLL SUMMARY VIEW
-- ==========================================

CREATE VIEW payroll_summary AS
SELECT
p.payroll_id,
e.full_name,
p.basic_salary,
p.bonus,
p.deductions,
(
p.basic_salary +
p.bonus -
p.deductions
) AS net_salary
FROM payroll p
JOIN employees e
ON p.employee_id=e.employee_id;

-- ==========================================
-- PERFORMANCE VIEW
-- ==========================================

CREATE VIEW performance_dashboard AS
SELECT
e.employee_id,
e.full_name,
AVG(pr.performance_score) avg_score
FROM employees e
JOIN performance_reviews pr
ON e.employee_id=pr.employee_id
GROUP BY
e.employee_id,
e.full_name;

-- ==========================================
-- ATTENDANCE VIEW
-- ==========================================

CREATE VIEW attendance_dashboard AS
SELECT
employee_id,
ROUND(
100.0 *
SUM(
CASE
WHEN status='Present'
THEN 1
ELSE 0
END
)
/
COUNT(*),
2
) attendance_percentage
FROM attendance
GROUP BY employee_id;

-- ==========================================
-- DEPARTMENT SUMMARY VIEW
-- ==========================================

CREATE VIEW department_summary AS
SELECT
d.department_name,
COUNT(e.employee_id) total_employees,
ROUND(AVG(e.salary),2) avg_salary
FROM departments d
LEFT JOIN employees e
ON d.department_id=e.department_id
GROUP BY d.department_name;
