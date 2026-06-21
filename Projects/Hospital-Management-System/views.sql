-- =====================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- views.sql
-- Business Reporting Views
-- =====================================================

-- =====================================================
-- VIEW 1 : PATIENT DASHBOARD
-- =====================================================

CREATE VIEW patient_dashboard_view AS
SELECT

```
patient_id,
full_name,
gender,
blood_group,
city,
state,
created_at
```

FROM patients;

-- =====================================================
-- VIEW 2 : DOCTOR DASHBOARD
-- =====================================================

CREATE VIEW doctor_dashboard_view AS
SELECT

```
d.doctor_id,
d.full_name,
d.specialization,
d.consultation_fee,
dep.department_name
```

FROM doctors d

JOIN departments dep
ON d.department_id = dep.department_id;

-- =====================================================
-- VIEW 3 : APPOINTMENT DASHBOARD
-- =====================================================

CREATE VIEW appointment_dashboard_view AS
SELECT

```
a.appointment_id,

p.full_name
AS patient_name,

d.full_name
AS doctor_name,

a.appointment_date,

a.appointment_time,

a.status
```

FROM appointments a

JOIN patients p
ON a.patient_id = p.patient_id

JOIN doctors d
ON a.doctor_id = d.doctor_id;

-- =====================================================
-- VIEW 4 : MEDICAL RECORDS VIEW
-- =====================================================

CREATE VIEW medical_records_view AS
SELECT

```
mr.record_id,

p.full_name
AS patient_name,

d.full_name
AS doctor_name,

mr.diagnosis,

mr.treatment,

mr.visit_date
```

FROM medical_records mr

JOIN patients p
ON mr.patient_id = p.patient_id

JOIN doctors d
ON mr.doctor_id = d.doctor_id;

-- =====================================================
-- VIEW 5 : PRESCRIPTION DASHBOARD
-- =====================================================

CREATE VIEW prescription_dashboard_view AS
SELECT

```
pr.prescription_id,

p.full_name
AS patient_name,

d.full_name
AS doctor_name,

m.medicine_name,

pr.dosage,

pr.duration_days
```

FROM prescriptions pr

JOIN patients p
ON pr.patient_id = p.patient_id

JOIN doctors d
ON pr.doctor_id = d.doctor_id

JOIN medicines m
ON pr.medicine_id = m.medicine_id;

-- =====================================================
-- VIEW 6 : MEDICINE INVENTORY VIEW
-- =====================================================

CREATE VIEW medicine_inventory_view AS
SELECT

```
medicine_id,

medicine_name,

manufacturer,

unit_price,

stock_quantity,

CASE
    WHEN stock_quantity < 100
    THEN 'LOW STOCK'
    ELSE 'AVAILABLE'
END AS stock_status
```

FROM medicines;

-- =====================================================
-- VIEW 7 : ROOM OCCUPANCY VIEW
-- =====================================================

CREATE VIEW room_occupancy_view AS
SELECT

```
room_id,

room_number,

room_type,

daily_charge,

room_status
```

FROM rooms;

-- =====================================================
-- VIEW 8 : ADMISSION DASHBOARD
-- =====================================================

CREATE VIEW admission_dashboard_view AS
SELECT

```
a.admission_id,

p.full_name
AS patient_name,

r.room_number,

r.room_type,

a.admission_date,

a.discharge_date
```

FROM admissions a

JOIN patients p
ON a.patient_id = p.patient_id

JOIN rooms r
ON a.room_id = r.room_id;

-- =====================================================
-- VIEW 9 : BILLING DASHBOARD
-- =====================================================

CREATE VIEW billing_dashboard_view AS
SELECT

```
b.bill_id,

p.full_name,

b.total_amount,

b.bill_status,

b.bill_date
```

FROM billing b

JOIN patients p
ON b.patient_id = p.patient_id;

-- =====================================================
-- VIEW 10 : PAYMENT DASHBOARD
-- =====================================================

CREATE VIEW payment_dashboard_view AS
SELECT

```
pay.payment_id,

b.bill_id,

p.full_name,

pay.amount_paid,

pay.payment_method,

pay.payment_date
```

FROM payments pay

JOIN billing b
ON pay.bill_id = b.bill_id

JOIN patients p
ON b.patient_id = p.patient_id;

-- =====================================================
-- VIEW 11 : DEPARTMENT PERFORMANCE
-- =====================================================

CREATE VIEW department_performance_view AS
SELECT

```
dep.department_name,

COUNT(d.doctor_id)
AS total_doctors
```

FROM departments dep

LEFT JOIN doctors d
ON dep.department_id = d.department_id

GROUP BY dep.department_name;

-- =====================================================
-- VIEW 12 : DOCTOR WORKLOAD
-- =====================================================

CREATE VIEW doctor_workload_view AS
SELECT

```
d.doctor_id,

d.full_name,

COUNT(a.appointment_id)
AS total_appointments
```

FROM doctors d

LEFT JOIN appointments a
ON d.doctor_id = a.doctor_id

GROUP BY
d.doctor_id,
d.full_name;

-- =====================================================
-- VIEW 13 : PATIENT BILL SUMMARY
-- =====================================================

CREATE VIEW patient_bill_summary_view AS
SELECT

```
p.patient_id,

p.full_name,

SUM(b.total_amount)
AS total_billed
```

FROM patients p

LEFT JOIN billing b
ON p.patient_id = b.patient_id

GROUP BY
p.patient_id,
p.full_name;

-- =====================================================
-- VIEW 14 : REVENUE DASHBOARD
-- =====================================================

CREATE VIEW revenue_dashboard_view AS
SELECT

```
COUNT(*)
AS total_bills,

SUM(total_amount)
AS total_revenue,

ROUND(
    AVG(total_amount),
    2
) AS average_bill
```

FROM billing;

-- =====================================================
-- VIEW 15 : EXECUTIVE DASHBOARD
-- =====================================================

CREATE VIEW executive_dashboard_view AS
SELECT

```
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

(SELECT COUNT(*)
 FROM medicines)
AS total_medicines;
```

-- =====================================================
-- VIEW 16 : ACTIVE ADMISSIONS
-- =====================================================

CREATE VIEW active_admissions_view AS
SELECT

```
a.admission_id,

p.full_name,

r.room_number,

a.admission_date
```

FROM admissions a

JOIN patients p
ON a.patient_id = p.patient_id

JOIN rooms r
ON a.room_id = r.room_id

WHERE a.discharge_date IS NULL;

-- =====================================================
-- VIEW 17 : OUTSTANDING BILLS
-- =====================================================

CREATE VIEW outstanding_bills_view AS
SELECT

```
b.bill_id,

p.full_name,

b.total_amount,

b.bill_status
```

FROM billing b

JOIN patients p
ON b.patient_id = p.patient_id

WHERE b.bill_status <> 'Paid';

-- =====================================================
-- VIEW 18 : MOST PRESCRIBED MEDICINES
-- =====================================================

CREATE VIEW most_prescribed_medicines_view AS
SELECT

```
m.medicine_name,

COUNT(pr.prescription_id)
AS prescription_count
```

FROM medicines m

LEFT JOIN prescriptions pr
ON m.medicine_id = pr.medicine_id

GROUP BY m.medicine_name;
