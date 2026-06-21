-- =====================================================
-- DEPARTMENTS
-- =====================================================

INSERT INTO departments
(
department_name,
department_head
)
VALUES
('Cardiology','Dr. Rajesh Sharma'),
('Neurology','Dr. Priya Rao'),
('Orthopedics','Dr. Vikram Singh'),
('Pediatrics','Dr. Anjali Patel'),
('Dermatology','Dr. Kiran Verma');

-- =====================================================
-- DOCTORS
-- =====================================================

INSERT INTO doctors
(
full_name,
email,
phone,
specialization,
experience_years,
consultation_fee,
department_id
)
VALUES

('Dr. Rajesh Sharma',
'[rajesh@hospital.com](mailto:rajesh@hospital.com)',
'9000000001',
'Cardiologist',
15,
1500,
1),

('Dr. Priya Rao',
'[priya@hospital.com](mailto:priya@hospital.com)',
'9000000002',
'Neurologist',
12,
1800,
2),

('Dr. Vikram Singh',
'[vikram@hospital.com](mailto:vikram@hospital.com)',
'9000000003',
'Orthopedic Surgeon',
10,
1400,
3),

('Dr. Anjali Patel',
'[anjali@hospital.com](mailto:anjali@hospital.com)',
'9000000004',
'Pediatrician',
8,
1200,
4),

('Dr. Kiran Verma',
'[kiran@hospital.com](mailto:kiran@hospital.com)',
'9000000005',
'Dermatologist',
9,
1300,
5);

-- =====================================================
-- PATIENTS
-- =====================================================

INSERT INTO patients
(
full_name,
email,
phone,
gender,
date_of_birth,
blood_group,
city,
state,
emergency_contact
)
VALUES

('Rutvik Mathapati',
'[rutvik@gmail.com](mailto:rutvik@gmail.com)',
'9876543210',
'Male',
'2000-05-15',
'O+',
'Bangalore',
'Karnataka',
'9999999991'),

('Kavya Bhavikatti',
'[kavya@gmail.com](mailto:kavya@gmail.com)',
'9876543211',
'Female',
'2001-03-20',
'A+',
'Hubli',
'Karnataka',
'9999999992'),

('Arjun Kumar',
'[arjun@gmail.com](mailto:arjun@gmail.com)',
'9876543212',
'Male',
'1998-09-10',
'B+',
'Mysore',
'Karnataka',
'9999999993'),

('Sneha Rao',
'[sneha@gmail.com](mailto:sneha@gmail.com)',
'9876543213',
'Female',
'1999-07-12',
'AB+',
'Bangalore',
'Karnataka',
'9999999994'),

('Rahul Patil',
'[rahul@gmail.com](mailto:rahul@gmail.com)',
'9876543214',
'Male',
'1997-01-25',
'O-',
'Belgaum',
'Karnataka',
'9999999995'),

('Ananya Sharma',
'[ananya@gmail.com](mailto:ananya@gmail.com)',
'9876543215',
'Female',
'2002-08-15',
'A-',
'Delhi',
'Delhi',
'9999999996'),

('Vikram Joshi',
'[vikram@gmail.com](mailto:vikram@gmail.com)',
'9876543216',
'Male',
'1995-04-18',
'B-',
'Pune',
'Maharashtra',
'9999999997'),

('Neha Singh',
'[neha@gmail.com](mailto:neha@gmail.com)',
'9876543217',
'Female',
'1996-11-22',
'O+',
'Mumbai',
'Maharashtra',
'9999999998'),

('Kiran Desai',
'[kiran@gmail.com](mailto:kiran@gmail.com)',
'9876543218',
'Male',
'1994-02-14',
'A+',
'Hyderabad',
'Telangana',
'9999999999'),

('Pooja Reddy',
'[pooja@gmail.com](mailto:pooja@gmail.com)',
'9876543219',
'Female',
'2001-10-10',
'B+',
'Chennai',
'Tamil Nadu',
'9999999988');

-- =====================================================
-- APPOINTMENTS
-- =====================================================

INSERT INTO appointments
(
patient_id,
doctor_id,
appointment_date,
appointment_time,
status,
notes
)
VALUES

(1,1,'2025-01-10','10:00','Completed','Routine checkup'),
(2,2,'2025-01-11','11:00','Completed','Migraine consultation'),
(3,3,'2025-01-12','12:00','Completed','Knee pain'),
(4,4,'2025-01-13','09:30','Completed','Child vaccination'),
(5,5,'2025-01-14','15:00','Completed','Skin allergy'),

(6,1,'2025-01-15','10:30','Scheduled','Heart screening'),
(7,2,'2025-01-16','11:15','Scheduled','Neurology follow-up'),
(8,3,'2025-01-17','14:00','Cancelled','Patient unavailable'),
(9,4,'2025-01-18','16:00','Completed','Pediatric consultation'),
(10,5,'2025-01-19','17:00','Completed','Skin treatment');

-- =====================================================
-- MEDICAL RECORDS
-- =====================================================

INSERT INTO medical_records
(
patient_id,
doctor_id,
diagnosis,
treatment,
visit_date,
notes
)
VALUES

(1,1,'Hypertension','Medication','2025-01-10','Stable'),

(2,2,'Migraine','Pain Management','2025-01-11','Needs follow-up'),

(3,3,'Knee Injury','Physiotherapy','2025-01-12','Improving'),

(4,4,'Vaccination','Routine Immunization','2025-01-13','Completed'),

(5,5,'Skin Allergy','Topical Medication','2025-01-14','Under observation');

-- =====================================================
-- MEDICINES
-- =====================================================

INSERT INTO medicines
(
medicine_name,
manufacturer,
unit_price,
stock_quantity
)
VALUES

('Paracetamol','Sun Pharma',10,1000),
('Amoxicillin','Cipla',25,500),
('Ibuprofen','Dr Reddy',15,600),
('Cetirizine','Sun Pharma',12,400),
('Aspirin','Cipla',8,800);

-- =====================================================
-- PRESCRIPTIONS
-- =====================================================

INSERT INTO prescriptions
(
patient_id,
doctor_id,
medicine_id,
dosage,
duration_days,
prescription_date
)
VALUES

(1,1,1,'500mg Twice Daily',5,'2025-01-10'),

(2,2,3,'400mg Daily',7,'2025-01-11'),

(3,3,2,'250mg Twice Daily',10,'2025-01-12'),

(4,4,1,'250mg Daily',3,'2025-01-13'),

(5,5,4,'10mg Daily',15,'2025-01-14');

-- =====================================================
-- ROOMS
-- =====================================================

INSERT INTO rooms
(
room_number,
room_type,
daily_charge,
room_status
)
VALUES

('G101','General',1000,'Occupied'),
('G102','General',1000,'Available'),

('P201','Private',2500,'Occupied'),
('P202','Private',2500,'Available'),

('ICU01','ICU',5000,'Occupied'),

('D301','Deluxe',4000,'Available');

-- =====================================================
-- ADMISSIONS
-- =====================================================

INSERT INTO admissions
(
patient_id,
room_id,
admission_date,
discharge_date,
admission_reason
)
VALUES

(1,1,'2025-01-05','2025-01-08','Blood Pressure Monitoring'),

(3,3,'2025-01-06','2025-01-10','Orthopedic Observation'),

(5,5,'2025-01-09',NULL,'Critical Care'),

(7,1,'2025-01-12',NULL,'Cardiac Monitoring');

-- =====================================================
-- BILLING
-- =====================================================

INSERT INTO billing
(
patient_id,
appointment_id,
admission_id,
bill_date,
total_amount,
bill_status
)
VALUES

(1,1,1,'2025-01-08',12000,'Paid'),

(2,2,NULL,'2025-01-11',1800,'Paid'),

(3,3,2,'2025-01-10',15000,'Paid'),

(4,4,NULL,'2025-01-13',1200,'Paid'),

(5,5,3,'2025-01-14',25000,'Pending'),

(9,9,NULL,'2025-01-18',1200,'Paid'),

(10,10,NULL,'2025-01-19',1300,'Partially Paid');

-- =====================================================
-- PAYMENTS
-- =====================================================

INSERT INTO payments
(
bill_id,
amount_paid,
payment_method,
payment_date
)
VALUES

(1,12000,'UPI','2025-01-08'),

(2,1800,'Credit Card','2025-01-11'),

(3,15000,'UPI','2025-01-10'),

(4,1200,'Cash','2025-01-13'),

(6,1200,'Debit Card','2025-01-18'),

(7,500,'UPI','2025-01-19');

-- =====================================================
-- DATASET SUMMARY
-- =====================================================

-- Departments      : 5
-- Doctors          : 5
-- Patients         : 10
-- Appointments     : 10
-- Medical Records  : 5
-- Medicines        : 5
-- Prescriptions    : 5
-- Rooms            : 6
-- Admissions       : 4
-- Billing          : 7
-- Payments         : 6
-----------------------

## -- Total Records    : 68+

-- Supports:
-- Patient Analytics
-- Doctor Analytics
-- Appointment Reports
-- Prescription Tracking
-- Room Occupancy Reports
-- Billing Analytics
-- Revenue Analytics
-- Executive Dashboards
