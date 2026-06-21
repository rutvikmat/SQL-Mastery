-- =====================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- analytics.sql
-- Advanced Healthcare Analytics
-- =====================================================

-- =====================================================
-- SECTION 1 : EXECUTIVE KPI DASHBOARD
-- =====================================================

-- KPI 1 : Total Patients

SELECT
COUNT(*) AS total_patients
FROM patients;

-- KPI 2 : Total Doctors

SELECT
COUNT(*) AS total_doctors
FROM doctors;

-- KPI 3 : Total Appointments

SELECT
COUNT(*) AS total_appointments
FROM appointments;

-- KPI 4 : Total Admissions

SELECT
COUNT(*) AS total_admissions
FROM admissions;

-- KPI 5 : Total Revenue

SELECT
SUM(total_amount) AS total_revenue
FROM billing;

-- KPI 6 : Average Bill Value

SELECT
ROUND(
AVG(total_amount),
2
) AS average_bill
FROM billing;

-- =====================================================
-- SECTION 2 : PATIENT ANALYTICS
-- =====================================================

-- Patients by Gender

SELECT
gender,
COUNT(*) AS total_patients
FROM patients
GROUP BY gender;

-- Patients by Blood Group

SELECT
blood_group,
COUNT(*) AS total_patients
FROM patients
GROUP BY blood_group
ORDER BY total_patients DESC;

-- Patients by City

SELECT
city,
COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;

-- Oldest Patient

SELECT
full_name,
date_of_birth
FROM patients
ORDER BY date_of_birth
LIMIT 1;

-- Youngest Patient

SELECT
full_name,
date_of_birth
FROM patients
ORDER BY date_of_birth DESC
LIMIT 1;

-- =====================================================
-- SECTION 3 : DOCTOR ANALYTICS
-- =====================================================

-- Doctor Appointment Count

SELECT
d.full_name,
COUNT(a.appointment_id) AS appointments
FROM doctors d
LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY d.full_name
ORDER BY appointments DESC;

-- Average Consultation Fee

SELECT
ROUND(
AVG(consultation_fee),
2
) AS avg_fee
FROM doctors;

-- Highest Paid Doctor

SELECT
full_name,
consultation_fee
FROM doctors
ORDER BY consultation_fee DESC
LIMIT 1;

-- Doctor Experience Analysis

SELECT
full_name,
experience_years
FROM doctors
ORDER BY experience_years DESC;

-- =====================================================
-- SECTION 4 : DEPARTMENT ANALYTICS
-- =====================================================

-- Doctors per Department

SELECT
dep.department_name,
COUNT(d.doctor_id) AS total_doctors
FROM departments dep
LEFT JOIN doctors d
ON dep.department_id=d.department_id
GROUP BY dep.department_name;

-- Appointments per Department

SELECT
dep.department_name,
COUNT(a.appointment_id) AS total_appointments
FROM departments dep
JOIN doctors d
ON dep.department_id=d.department_id
LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY dep.department_name
ORDER BY total_appointments DESC;

-- Most Active Department

SELECT
dep.department_name,
COUNT(a.appointment_id) AS appointments
FROM departments dep
JOIN doctors d
ON dep.department_id=d.department_id
JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY dep.department_name
ORDER BY appointments DESC
LIMIT 1;

-- =====================================================
-- SECTION 5 : APPOINTMENT ANALYTICS
-- =====================================================

-- Appointment Status Distribution

SELECT
status,
COUNT(*) AS total
FROM appointments
GROUP BY status;

-- Completed Appointments

SELECT
COUNT(*) AS completed_appointments
FROM appointments
WHERE status='Completed';

-- Cancelled Appointments

SELECT
COUNT(*) AS cancelled_appointments
FROM appointments
WHERE status='Cancelled';

-- Doctor Schedule Utilization

SELECT
doctor_id,
COUNT(*) AS appointments
FROM appointments
GROUP BY doctor_id
ORDER BY appointments DESC;

-- =====================================================
-- SECTION 6 : REVENUE ANALYTICS
-- =====================================================

-- Revenue by Bill Status

SELECT
bill_status,
SUM(total_amount) AS revenue
FROM billing
GROUP BY bill_status;

-- Top Revenue Patient

SELECT
p.full_name,
SUM(b.total_amount) AS total_billed
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
GROUP BY p.full_name
ORDER BY total_billed DESC
LIMIT 1;

-- Revenue by Patient

SELECT
p.full_name,
SUM(b.total_amount) AS total_billed
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
GROUP BY p.full_name
ORDER BY total_billed DESC;

-- Outstanding Revenue

SELECT
SUM(total_amount) AS pending_revenue
FROM billing
WHERE bill_status='Pending';

-- =====================================================
-- SECTION 7 : PAYMENT ANALYTICS
-- =====================================================

-- Payments by Method

SELECT
payment_method,
COUNT(*) AS transactions,
SUM(amount_paid) AS total_collected
FROM payments
GROUP BY payment_method;

-- Total Collections

SELECT
SUM(amount_paid) AS collections
FROM payments;

-- Unpaid Bills

SELECT
COUNT(*) AS unpaid_bills
FROM billing
WHERE bill_status <> 'Paid';

-- =====================================================
-- SECTION 8 : ROOM & ADMISSION ANALYTICS
-- =====================================================

-- Room Occupancy

SELECT
room_status,
COUNT(*) AS total_rooms
FROM rooms
GROUP BY room_status;

-- Occupied Rooms

SELECT
COUNT(*) AS occupied_rooms
FROM rooms
WHERE room_status='Occupied';

-- Available Rooms

SELECT
COUNT(*) AS available_rooms
FROM rooms
WHERE room_status='Available';

-- Average Stay Duration

SELECT
ROUND(
AVG(
discharge_date -
admission_date
),
2
) AS avg_stay_days
FROM admissions
WHERE discharge_date IS NOT NULL;

-- Active Admissions

SELECT
COUNT(*) AS active_admissions
FROM admissions
WHERE discharge_date IS NULL;

-- =====================================================
-- SECTION 9 : MEDICINE ANALYTICS
-- =====================================================

-- Medicine Inventory

SELECT
medicine_name,
stock_quantity
FROM medicines
ORDER BY stock_quantity DESC;

-- Low Stock Medicines

SELECT
medicine_name,
stock_quantity
FROM medicines
WHERE stock_quantity < 500;

-- Most Prescribed Medicines

SELECT
m.medicine_name,
COUNT(pr.prescription_id) AS prescriptions
FROM medicines m
LEFT JOIN prescriptions pr
ON m.medicine_id=pr.medicine_id
GROUP BY m.medicine_name
ORDER BY prescriptions DESC;

-- Inventory Value

SELECT
SUM(
unit_price * stock_quantity
) AS inventory_value
FROM medicines;

-- =====================================================
-- SECTION 10 : CTE ANALYTICS
-- =====================================================

WITH patient_revenue AS
(
SELECT
patient_id,
SUM(total_amount) AS revenue
FROM billing
GROUP BY patient_id
)

SELECT *
FROM patient_revenue
ORDER BY revenue DESC;

WITH doctor_workload AS
(
SELECT
doctor_id,
COUNT(*) AS appointments
FROM appointments
GROUP BY doctor_id
)

SELECT *
FROM doctor_workload
ORDER BY appointments DESC;

WITH room_utilization AS
(
SELECT
room_id,
COUNT(*) AS admissions
FROM admissions
GROUP BY room_id
)

SELECT *
FROM room_utilization
ORDER BY admissions DESC;

-- =====================================================
-- SECTION 11 : WINDOW FUNCTIONS
-- =====================================================

-- Doctor Ranking

SELECT

full_name,

consultation_fee,

RANK()
OVER(
ORDER BY consultation_fee DESC
) AS doctor_rank

FROM doctors;

-- Doctor Dense Ranking

SELECT

full_name,

consultation_fee,

DENSE_RANK()
OVER(
ORDER BY consultation_fee DESC
) AS doctor_rank

FROM doctors;

-- Patient Revenue Ranking

SELECT

p.full_name,

SUM(b.total_amount) AS revenue,

RANK()
OVER(
ORDER BY SUM(b.total_amount) DESC
) AS revenue_rank

FROM patients p

JOIN billing b
ON p.patient_id=b.patient_id

GROUP BY p.full_name;

-- =====================================================
-- SECTION 12 : EXECUTIVE HEALTHCARE DASHBOARD
-- =====================================================

SELECT

(SELECT COUNT(*) FROM patients)
AS total_patients,

(SELECT COUNT(*) FROM doctors)
AS total_doctors,

(SELECT COUNT(*) FROM appointments)
AS total_appointments,

(SELECT COUNT(*) FROM admissions)
AS total_admissions,

(SELECT SUM(total_amount)
FROM billing)
AS total_revenue,

(SELECT SUM(amount_paid)
FROM payments)
AS total_collections,

(SELECT COUNT(*)
FROM medicines)
AS total_medicines,

(SELECT COUNT(*)
FROM rooms)
AS total_rooms;

-- =====================================================
-- SECTION 13 : HOSPITAL PERFORMANCE REPORT
-- =====================================================

SELECT

CURRENT_DATE AS report_date,

(SELECT COUNT(*) FROM patients)
AS patients,

(SELECT COUNT(*) FROM doctors)
AS doctors,

(SELECT SUM(total_amount)
FROM billing)
AS billed_revenue,

(SELECT SUM(amount_paid)
FROM payments)
AS collected_revenue,

(SELECT COUNT(*)
FROM admissions
WHERE discharge_date IS NULL)
AS active_inpatients;
