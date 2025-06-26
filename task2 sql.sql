-- Create a sample database and table for demonstration
CREATE DATABASE IF NOT EXISTS data_handling_demo;
USE data_handling_demo;

-- Create a sample table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    department_id INT,
    manager_id INT,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 1. INSERT statements with various NULL handling approaches

-- Basic INSERT with all values specified
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id, manager_id)
VALUES ('suraj', 'singh', 'suraj.singh@example.com', '2023-01-15', 75000.00, 1, NULL);

-- INSERT with DEFAULT values
INSERT INTO employees (first_name, last_name, email, hire_date, salary)
VALUES ('shivam', 'singh', 'shivam.singh@example.com', '2023-02-20', 68000.00);

-- INSERT with explicit NULL for optional fields
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id, manager_id)
VALUES ('himanshu ', 'kumar ', NULL, '2023-03-10', 82000.00, NULL, 1);

-- INSERT with DEFAULT for boolean field
INSERT INTO employees (first_name, last_name, email, hire_date, salary)
VALUES ('ayush ', 'kumar', 'ayush.kumar@example.com', '2023-04-05', 72000.00);

-- Bulk INSERT with multiple rows
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id)
VALUES 
    ('suraj', 'bhai', 'ss.raj@example.com', '2023-05-12', 65000.00, 2),
    ('gulshan', 'kumar', 'sarah.davis@example.com', '2023-06-18', 78000.00, NULL),
    ('priya ', 'kumari', 'priya.kumari@example.com', '2023-07-22', 90000.00, 1);

-- Insert data into departments table
INSERT INTO departments (department_name, location)
VALUES 
    ('Sales', 'New York'),
    ('Marketing', 'Chicago'),
    ('IT', NULL),
    ('HR', 'Boston');

-- 2. UPDATE statements with WHERE conditions

-- Update salary for a specific employee
UPDATE employees
SET salary = 80000.00
WHERE employee_id = 1;

-- Update department for all employees with NULL department
UPDATE employees
SET department_id = 3  -- IT department
WHERE department_id IS NULL;

-- Update manager for employees in Sales department
UPDATE employees
SET manager_id = 1
WHERE department_id = 1;

-- Update email for employees without email
UPDATE employees
SET email = CONCAT(LOWER(first_name), '.', LOWER(last_name), '@company.com')
WHERE email IS NULL;

-- Update location for departments with NULL location
UPDATE departments
SET location = 'Remote'
WHERE location IS NULL;

-- 3. DELETE statements with WHERE conditions

-- Delete a specific employee
DELETE FROM employees
WHERE employee_id = 5;

-- Delete all inactive employees (if we had any)
-- DELETE FROM employees WHERE is_active = FALSE;

-- Delete departments with no employees (demonstration only - would need foreign key handling)
-- First, let's see which departments have no employees
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- Then we could delete them (commented out for safety)
-- DELETE FROM departments 
-- WHERE department_id IN (
--     SELECT d.department_id
--     FROM departments d
--     LEFT JOIN employees e ON d.department_id = e.department_id
--     WHERE e.employee_id IS NULL
-- );

-- 4. Handling NULL values in queries

-- Select employees with NULL manager_id
SELECT * FROM employees WHERE manager_id IS NULL;

-- Select employees with non-NULL email
SELECT * FROM employees WHERE email IS NOT NULL;

-- Use COALESCE to handle NULL values in output
SELECT 
    employee_id,
    first_name,
    last_name,
    COALESCE(email, 'no-email@company.com') AS email,
    COALESCE(department_id, 0) AS department_id,
    COALESCE(manager_id, 0) AS manager_id
FROM employees;

-- Use IFNULL for simple NULL replacement
SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    IFNULL(department_id, 'Unassigned') AS department
FROM employees;

-- Verify all data
SELECT * FROM employees;
SELECT * FROM departments;