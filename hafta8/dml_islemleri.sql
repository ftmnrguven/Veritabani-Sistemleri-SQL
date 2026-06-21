-- ==========================================
-- HAFTA 8: Veri İşleme Dili (DML) Komutları
-- ==========================================

-- Tablo Kopyalama
CREATE TABLE copy_f_customers AS (SELECT * FROM f_customers);

-- Veri Ekleme (INSERT)
INSERT INTO copy_f_customers 
(id, first_name, last_name, address, city, state, zip, phone_number) 
VALUES 
(145, 'Katie', 'Hernandez', '92 Chico Way', 'Los Angeles', 'CA', 98008, 8586667641);

INSERT INTO copy_employees (employee_id, last_name, email, hire_date, job_id) 
VALUES (1001, USER, 'Test', SYSDATE, 'IT_PROG');

-- Alt Sorgu ile Veri Ekleme
INSERT INTO sales_reps (id, name, salary, commission_pct) 
SELECT employee_id, last_name, salary, commission_pct 
FROM employees 
WHERE job_id LIKE '%REP%';

-- Veri Güncelleme (UPDATE)
UPDATE copy_f_customers 
SET phone_number = '4475582344', city = 'Chicago' 
WHERE id < 200;

-- İlişkili Alt Sorgu ile Güncelleme
UPDATE copy_employees e 
SET e.department_name = (
    SELECT d.department_name FROM departments d WHERE e.department_id = d.department_id
);

-- Veri Silme (DELETE)
DELETE FROM copy_f_customers WHERE id = 123;

DELETE FROM copy_employees 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Shipping');

-- Birleştirme (MERGE) - Ekleme ve Güncellemenin Tek Komutta Yapılması
MERGE INTO copy_emp c 
USING employees e 
ON (c.employee_id = e.employee_id) 
WHEN MATCHED THEN 
    UPDATE SET c.last_name = e.last_name, c.department_id = e.department_id 
WHEN NOT MATCHED THEN 
    INSERT VALUES (e.employee_id, e.last_name, e.department_id);

-- Çoklu Tablo Ekleme (Şartsız)
INSERT ALL 
INTO emp_all_info VALUES (employee_id, first_name, last_name, salary) 
INTO emp_dept_info VALUES (employee_id, last_name, department_id) 
SELECT employee_id, first_name, last_name, salary, department_id 
FROM employees 
WHERE department_id IS NOT NULL;

-- Çoklu Tablo Ekleme (Şartlı - FIRST)
INSERT FIRST 
WHEN salary < 4000 THEN 
    INTO emp_low_salary VALUES (employee_id, last_name, salary) 
WHEN salary < 8000 THEN 
    INTO emp_mid_salary VALUES (employee_id, last_name, salary) 
ELSE 
    INTO emp_high_salary VALUES (employee_id, last_name, salary) 
SELECT employee_id, last_name, salary 
FROM employees;
