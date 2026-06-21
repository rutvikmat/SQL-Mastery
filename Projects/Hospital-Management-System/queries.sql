-- =====================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- queries.sql
-- 125 SQL QUERIES
-- =====================================================

-- =====================================================
-- SECTION 1 : BASIC QUERIES (1-15)
-- =====================================================

SELECT * FROM departments;

SELECT * FROM doctors;

SELECT * FROM patients;

SELECT * FROM appointments;

SELECT * FROM medical_records;

SELECT * FROM medicines;

SELECT * FROM prescriptions;

SELECT * FROM rooms;

SELECT * FROM admissions;

SELECT * FROM billing;

SELECT * FROM payments;

SELECT full_name,email
FROM patients;

SELECT full_name,specialization
FROM doctors;

SELECT room_number,room_type
FROM rooms;

SELECT medicine_name,unit_price
FROM medicines;

-- =====================================================
-- SECTION 2 : FILTERING QUERIES (16-25)
-- =====================================================

SELECT *
FROM patients
WHERE city='Bangalore';

SELECT *
FROM doctors
WHERE experience_years > 10;

SELECT *
FROM appointments
WHERE status='Completed';

SELECT *
FROM billing
WHERE bill_status='Pending';

SELECT *
FROM rooms
WHERE room_status='Available';

SELECT *
FROM medicines
WHERE stock_quantity < 500;

SELECT *
FROM patients
WHERE blood_group='O+';

SELECT *
FROM doctors
WHERE consultation_fee > 1500;

SELECT *
FROM admissions
WHERE discharge_date IS NULL;

SELECT *
FROM appointments
WHERE appointment_date='2025-01-15';

-- =====================================================
-- SECTION 3 : AGGREGATE QUERIES (26-40)
-- =====================================================

SELECT COUNT(*)
AS total_patients
FROM patients;

SELECT COUNT(*)
AS total_doctors
FROM doctors;

SELECT COUNT(*)
AS total_appointments
FROM appointments;

SELECT COUNT(*)
AS total_admissions
FROM admissions;

SELECT COUNT(*)
AS total_rooms
FROM rooms;

SELECT AVG(consultation_fee)
FROM doctors;

SELECT MAX(consultation_fee)
FROM doctors;

SELECT MIN(consultation_fee)
FROM doctors;

SELECT SUM(total_amount)
FROM billing;

SELECT AVG(total_amount)
FROM billing;

SELECT city,
COUNT(*)
FROM patients
GROUP BY city;

SELECT gender,
COUNT(*)
FROM patients
GROUP BY gender;

SELECT department_id,
COUNT(*)
FROM doctors
GROUP BY department_id;

SELECT bill_status,
COUNT(*)
FROM billing
GROUP BY bill_status;

SELECT room_type,
COUNT(*)
FROM rooms
GROUP BY room_type;

-- =====================================================
-- SECTION 4 : JOIN QUERIES (41-65)
-- =====================================================

SELECT
p.full_name,
a.appointment_date
FROM patients p
JOIN appointments a
ON p.patient_id=a.patient_id;

SELECT
d.full_name,
a.appointment_date
FROM doctors d
JOIN appointments a
ON d.doctor_id=a.doctor_id;

SELECT
p.full_name,
d.full_name doctor_name
FROM appointments a
JOIN patients p
ON a.patient_id=p.patient_id
JOIN doctors d
ON a.doctor_id=d.doctor_id;

SELECT
d.full_name,
dep.department_name
FROM doctors d
JOIN departments dep
ON d.department_id=dep.department_id;

SELECT
p.full_name,
mr.diagnosis
FROM patients p
JOIN medical_records mr
ON p.patient_id=mr.patient_id;

SELECT
p.full_name,
m.medicine_name
FROM prescriptions pr
JOIN patients p
ON pr.patient_id=p.patient_id
JOIN medicines m
ON pr.medicine_id=m.medicine_id;

SELECT
p.full_name,
r.room_number
FROM admissions a
JOIN patients p
ON a.patient_id=p.patient_id
JOIN rooms r
ON a.room_id=r.room_id;

SELECT
p.full_name,
b.total_amount
FROM billing b
JOIN patients p
ON b.patient_id=p.patient_id;

SELECT
b.bill_id,
pay.amount_paid
FROM billing b
JOIN payments pay
ON b.bill_id=pay.bill_id;

SELECT
dep.department_name,
COUNT(a.appointment_id)
FROM departments dep
JOIN doctors d
ON dep.department_id=d.department_id
JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY dep.department_name;

-- =====================================================
-- SECTION 5 : SUBQUERIES (66-80)
-- =====================================================

SELECT *
FROM doctors
WHERE consultation_fee=
(
SELECT MAX(consultation_fee)
FROM doctors
);

SELECT *
FROM doctors
WHERE consultation_fee=
(
SELECT MIN(consultation_fee)
FROM doctors
);

SELECT *
FROM billing
WHERE total_amount=
(
SELECT MAX(total_amount)
FROM billing
);

SELECT *
FROM patients
WHERE patient_id IN
(
SELECT patient_id
FROM admissions
);

SELECT *
FROM patients
WHERE patient_id NOT IN
(
SELECT patient_id
FROM admissions
);

SELECT *
FROM medicines
WHERE stock_quantity >
(
SELECT AVG(stock_quantity)
FROM medicines
);

SELECT *
FROM doctors
WHERE doctor_id IN
(
SELECT doctor_id
FROM appointments
);

SELECT *
FROM rooms
WHERE room_id IN
(
SELECT room_id
FROM admissions
);

SELECT *
FROM departments
WHERE department_id IN
(
SELECT department_id
FROM doctors
);

SELECT *
FROM billing
WHERE total_amount >
(
SELECT AVG(total_amount)
FROM billing
);

-- =====================================================
-- SECTION 6 : SQL FUNCTIONS (81-90)
-- =====================================================

SELECT UPPER(full_name)
FROM patients;

SELECT LOWER(full_name)
FROM doctors;

SELECT LENGTH(full_name)
FROM patients;

SELECT CONCAT(
full_name,
' - ',
city
)
FROM patients;

SELECT CURRENT_DATE;

SELECT CURRENT_TIMESTAMP;

SELECT ROUND(
AVG(total_amount),
2
)
FROM billing;

SELECT EXTRACT(
YEAR FROM CURRENT_DATE
);

SELECT COALESCE(
NULL,
'No Data'
);

SELECT NULLIF(
100,
100
);

-- =====================================================
-- SECTION 7 : CTE QUERIES (91-100)
-- =====================================================

WITH patient_bills AS
(
SELECT
patient_id,
SUM(total_amount)
AS total_bill
FROM billing
GROUP BY patient_id
)
SELECT *
FROM patient_bills;

WITH doctor_appointments AS
(
SELECT
doctor_id,
COUNT(*)
AS total_appointments
FROM appointments
GROUP BY doctor_id
)
SELECT *
FROM doctor_appointments;

WITH room_usage AS
(
SELECT
room_id,
COUNT(*)
AS occupancy
FROM admissions
GROUP BY room_id
)
SELECT *
FROM room_usage;

WITH revenue_report AS
(
SELECT
SUM(total_amount)
AS revenue
FROM billing
)
SELECT *
FROM revenue_report;

WITH medicine_inventory AS
(
SELECT
medicine_name,
stock_quantity
FROM medicines
)
SELECT *
FROM medicine_inventory;

-- =====================================================
-- SECTION 8 : WINDOW FUNCTIONS (101-110)
-- =====================================================

SELECT
full_name,
consultation_fee,

ROW_NUMBER()
OVER(
ORDER BY consultation_fee DESC
)
FROM doctors;

SELECT
full_name,
consultation_fee,

RANK()
OVER(
ORDER BY consultation_fee DESC
)
FROM doctors;

SELECT
full_name,
consultation_fee,

DENSE_RANK()
OVER(
ORDER BY consultation_fee DESC
)
FROM doctors;

SELECT
medicine_name,
stock_quantity,

LAG(stock_quantity)
OVER(
ORDER BY stock_quantity
)
FROM medicines;

SELECT
medicine_name,
stock_quantity,

LEAD(stock_quantity)
OVER(
ORDER BY stock_quantity
)
FROM medicines;

-- =====================================================
-- SECTION 9 : HEALTHCARE ANALYTICS (111-125)
-- =====================================================

-- Top Doctors

SELECT
d.full_name,
COUNT(a.appointment_id)
AS total_appointments
FROM doctors d
JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY d.full_name
ORDER BY total_appointments DESC;

-- Revenue By Department

SELECT
dep.department_name,
SUM(b.total_amount)
AS revenue
FROM departments dep
JOIN doctors d
ON dep.department_id=d.department_id
JOIN appointments a
ON d.doctor_id=a.doctor_id
JOIN billing b
ON a.appointment_id=b.appointment_id
GROUP BY dep.department_name;

-- Patient Count By City

SELECT
city,
COUNT(*)
AS total_patients
FROM patients
GROUP BY city;

-- Room Occupancy

SELECT
r.room_number,
COUNT(a.admission_id)
AS occupancy
FROM rooms r
LEFT JOIN admissions a
ON r.room_id=a.room_id
GROUP BY r.room_number;

-- Outstanding Bills

SELECT *
FROM billing
WHERE bill_status <> 'Paid';

-- Most Prescribed Medicine

SELECT
m.medicine_name,
COUNT(pr.prescription_id)
AS prescriptions
FROM medicines m
JOIN prescriptions pr
ON m.medicine_id=pr.medicine_id
GROUP BY m.medicine_name
ORDER BY prescriptions DESC;

-- Average Doctor Fee

SELECT
ROUND(
AVG(consultation_fee),
2
)
AS avg_fee
FROM doctors;

-- Total Revenue

SELECT
SUM(total_amount)
AS hospital_revenue
FROM billing;

-- Active Admissions

SELECT
COUNT(*)
AS active_patients
FROM admissions
WHERE discharge_date IS NULL;

-- Executive Dashboard

SELECT

(SELECT COUNT(*) FROM patients)
AS total_patients,

(SELECT COUNT(*) FROM doctors)
AS total_doctors,

(SELECT COUNT(*) FROM appointments)
AS total_appointments,

(SELECT SUM(total_amount)
FROM billing)
AS total_revenue;
