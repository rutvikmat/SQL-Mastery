-- =====================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- schema.sql
-- PostgreSQL Production-Level Schema
-- =====================================================

-- =====================================================
-- DEPARTMENTS
-- =====================================================

CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,

```
department_name VARCHAR(100)
UNIQUE NOT NULL,

department_head VARCHAR(100),

created_at TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
```

);

-- =====================================================
-- DOCTORS
-- =====================================================

CREATE TABLE doctors (
doctor_id SERIAL PRIMARY KEY,

```
full_name VARCHAR(100)
NOT NULL,

email VARCHAR(100)
UNIQUE NOT NULL,

phone VARCHAR(15)
UNIQUE,

specialization VARCHAR(100),

experience_years INT
CHECK(experience_years >= 0),

consultation_fee DECIMAL(10,2)
CHECK(consultation_fee > 0),

department_id INT,

created_at TIMESTAMP
DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (department_id)
REFERENCES departments(department_id)
```

);

-- =====================================================
-- PATIENTS
-- =====================================================

CREATE TABLE patients (
patient_id SERIAL PRIMARY KEY,

```
full_name VARCHAR(100)
NOT NULL,

email VARCHAR(100)
UNIQUE,

phone VARCHAR(15)
UNIQUE,

gender VARCHAR(10)
CHECK(gender IN ('Male','Female','Other')),

date_of_birth DATE,

blood_group VARCHAR(10),

city VARCHAR(50),

state VARCHAR(50),

emergency_contact VARCHAR(15),

created_at TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
```

);

-- =====================================================
-- APPOINTMENTS
-- =====================================================

CREATE TABLE appointments (
appointment_id SERIAL PRIMARY KEY,

```
patient_id INT NOT NULL,

doctor_id INT NOT NULL,

appointment_date DATE NOT NULL,

appointment_time TIME NOT NULL,

status VARCHAR(30)
CHECK(
    status IN
    (
        'Scheduled',
        'Completed',
        'Cancelled',
        'No Show'
    )
),

notes TEXT,

FOREIGN KEY(patient_id)
REFERENCES patients(patient_id),

FOREIGN KEY(doctor_id)
REFERENCES doctors(doctor_id)
```

);

-- =====================================================
-- MEDICAL RECORDS
-- =====================================================

CREATE TABLE medical_records (
record_id SERIAL PRIMARY KEY,

```
patient_id INT NOT NULL,

doctor_id INT NOT NULL,

diagnosis TEXT,

treatment TEXT,

visit_date DATE,

notes TEXT,

FOREIGN KEY(patient_id)
REFERENCES patients(patient_id),

FOREIGN KEY(doctor_id)
REFERENCES doctors(doctor_id)
```

);

-- =====================================================
-- MEDICINES
-- =====================================================

CREATE TABLE medicines (
medicine_id SERIAL PRIMARY KEY,

```
medicine_name VARCHAR(150)
NOT NULL,

manufacturer VARCHAR(100),

unit_price DECIMAL(10,2)
CHECK(unit_price > 0),

stock_quantity INT
DEFAULT 0
CHECK(stock_quantity >= 0)
```

);

-- =====================================================
-- PRESCRIPTIONS
-- =====================================================

CREATE TABLE prescriptions (
prescription_id SERIAL PRIMARY KEY,

```
patient_id INT NOT NULL,

doctor_id INT NOT NULL,

medicine_id INT NOT NULL,

dosage VARCHAR(100),

duration_days INT,

prescription_date DATE,

FOREIGN KEY(patient_id)
REFERENCES patients(patient_id),

FOREIGN KEY(doctor_id)
REFERENCES doctors(doctor_id),

FOREIGN KEY(medicine_id)
REFERENCES medicines(medicine_id)
```

);

-- =====================================================
-- ROOMS
-- =====================================================

CREATE TABLE rooms (
room_id SERIAL PRIMARY KEY,

```
room_number VARCHAR(20)
UNIQUE NOT NULL,

room_type VARCHAR(50)
CHECK(
    room_type IN
    (
        'General',
        'Private',
        'ICU',
        'Deluxe'
    )
),

daily_charge DECIMAL(10,2)
CHECK(daily_charge > 0),

room_status VARCHAR(30)
DEFAULT 'Available'
```

);

-- =====================================================
-- ADMISSIONS
-- =====================================================

CREATE TABLE admissions (
admission_id SERIAL PRIMARY KEY,

```
patient_id INT NOT NULL,

room_id INT NOT NULL,

admission_date DATE NOT NULL,

discharge_date DATE,

admission_reason TEXT,

FOREIGN KEY(patient_id)
REFERENCES patients(patient_id),

FOREIGN KEY(room_id)
REFERENCES rooms(room_id)
```

);

-- =====================================================
-- BILLING
-- =====================================================

CREATE TABLE billing (
bill_id SERIAL PRIMARY KEY,

```
patient_id INT NOT NULL,

appointment_id INT,

admission_id INT,

bill_date DATE,

total_amount DECIMAL(12,2)
CHECK(total_amount >= 0),

bill_status VARCHAR(30)
CHECK(
    bill_status IN
    (
        'Pending',
        'Paid',
        'Partially Paid'
    )
),

FOREIGN KEY(patient_id)
REFERENCES patients(patient_id),

FOREIGN KEY(appointment_id)
REFERENCES appointments(appointment_id),

FOREIGN KEY(admission_id)
REFERENCES admissions(admission_id)
```

);

-- =====================================================
-- PAYMENTS
-- =====================================================

CREATE TABLE payments (
payment_id SERIAL PRIMARY KEY,

```
bill_id INT NOT NULL,

amount_paid DECIMAL(12,2)
CHECK(amount_paid > 0),

payment_method VARCHAR(50),

payment_date DATE,

FOREIGN KEY(bill_id)
REFERENCES billing(bill_id)
```

);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX idx_patient_name
ON patients(full_name);

CREATE INDEX idx_doctor_name
ON doctors(full_name);

CREATE INDEX idx_appointment_date
ON appointments(appointment_date);

CREATE INDEX idx_medicine_name
ON medicines(medicine_name);

CREATE INDEX idx_bill_status
ON billing(bill_status);

-- =====================================================
-- SCHEMA SUMMARY
-- =====================================================

## -- Total Tables: 11

-- departments
-- doctors
-- patients
-- appointments
-- medical_records
-- medicines
-- prescriptions
-- rooms
-- admissions
-- billing
-- payments
-----------

## -- Features:

-- Patient Management
-- Doctor Management
-- Appointment Scheduling
-- Medical Records
-- Prescription Tracking
-- Room Allocation
-- Admission Management
-- Billing System
-- Payment Tracking
-- Healthcare Analytics
