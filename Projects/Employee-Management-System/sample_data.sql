-- =========================================
-- DEPARTMENTS
-- =========================================

INSERT INTO departments
(department_name,location)
VALUES
('Engineering','Bangalore'),
('Human Resources','Mumbai'),
('Finance','Pune'),
('Sales','Hyderabad'),
('Marketing','Delhi');

-- =========================================
-- POSITIONS
-- =========================================

INSERT INTO positions
(position_name,salary_grade)
VALUES
('Software Engineer','G5'),
('Senior Software Engineer','G6'),
('Team Lead','G7'),
('Manager','G8'),
('Director','G9');

-- =========================================
-- EMPLOYEES
-- =========================================

INSERT INTO employees
(
full_name,
email,
phone,
gender,
hire_date,
salary,
department_id,
position_id,
manager_id
)
VALUES

('Arjun Kumar',
'[arjun@gmail.com](mailto:arjun@gmail.com)',
'9876543201',
'Male',
'2020-01-10',
180000,
1,
4,
NULL),

('Rutvik Mathapati',
'[rutvik@gmail.com](mailto:rutvik@gmail.com)',
'9876543202',
'Male',
'2023-01-15',
120000,
1,
1,
1),

('Kavya Bhavikatti',
'[kavya@gmail.com](mailto:kavya@gmail.com)',
'9876543203',
'Female',
'2022-06-10',
135000,
1,
2,
1),

('Sneha Rao',
'[sneha@gmail.com](mailto:sneha@gmail.com)',
'9876543204',
'Female',
'2021-08-12',
95000,
2,
1,
1),

('Rahul Patil',
'[rahul@gmail.com](mailto:rahul@gmail.com)',
'9876543205',
'Male',
'2022-04-15',
105000,
3,
2,
1),

('Ananya Sharma',
'[ananya@gmail.com](mailto:ananya@gmail.com)',
'9876543206',
'Female',
'2021-03-10',
145000,
4,
3,
1),

('Kiran Verma',
'[kiran@gmail.com](mailto:kiran@gmail.com)',
'9876543207',
'Male',
'2020-09-01',
155000,
5,
3,
1),

('Neha Singh',
'[neha@gmail.com](mailto:neha@gmail.com)',
'9876543208',
'Female',
'2024-01-20',
85000,
2,
1,
4),

('Vikram Joshi',
'[vikram@gmail.com](mailto:vikram@gmail.com)',
'9876543209',
'Male',
'2023-07-15',
115000,
3,
2,
5),

('Pooja Reddy',
'[pooja@gmail.com](mailto:pooja@gmail.com)',
'9876543210',
'Female',
'2022-10-01',
125000,
4,
2,
6);

-- =========================================
-- ATTENDANCE
-- =========================================

INSERT INTO attendance
(employee_id,attendance_date,status)
VALUES
(2,'2025-01-01','Present'),
(2,'2025-01-02','Present'),
(3,'2025-01-01','Late'),
(4,'2025-01-01','Absent'),
(5,'2025-01-01','Present'),
(6,'2025-01-01','Present'),
(7,'2025-01-01','Leave');

-- =========================================
-- PAYROLL
-- =========================================

INSERT INTO payroll
(
employee_id,
basic_salary,
bonus,
deductions,
payment_date
)
VALUES
(2,120000,10000,2000,'2025-01-31'),
(3,135000,12000,3000,'2025-01-31'),
(4,95000,5000,1500,'2025-01-31'),
(5,105000,8000,2500,'2025-01-31'),
(6,145000,15000,4000,'2025-01-31');

-- =========================================
-- PERFORMANCE REVIEWS
-- =========================================

INSERT INTO performance_reviews
(
employee_id,
review_date,
performance_score,
remarks
)
VALUES
(2,'2025-01-15',9,'Excellent Performance'),
(3,'2025-01-15',8,'Strong Contributor'),
(4,'2025-01-15',7,'Good Performance'),
(5,'2025-01-15',6,'Needs Improvement'),
(6,'2025-01-15',10,'Outstanding');

-- =========================================
-- PROMOTIONS
-- =========================================

INSERT INTO promotions
(
employee_id,
old_position,
new_position,
promotion_date
)
VALUES
(
3,
'Software Engineer',
'Senior Software Engineer',
'2024-07-01'
),
(
6,
'Senior Software Engineer',
'Team Lead',
'2024-09-01'
);
