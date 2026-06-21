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
SELECT id, first_name, last_name, birthdate 
FROM f_staffs 
WHERE birthdate > (SELECT birthdate FROM f_staffs WHERE last_name = 'Miller');

SELECT last_name, job_id, department_id 
FROM employees 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Marketing');

SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN (SELECT manager_id, department_id FROM employees WHERE employee_id IN (149, 174)) 
AND employee_id NOT IN (149, 174);

SELECT title, producer, year 
FROM d_cds 
WHERE year < ANY (SELECT year FROM d_cds WHERE producer = 'The Music Man');

SELECT department_id, AVG(salary) 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

SELECT * FROM employees t1 
WHERE EXISTS (SELECT 1 FROM employees t2 WHERE t1.employee_id = t2.manager_id);

CREATE TABLE copy_f_customers AS (SELECT * FROM f_customers);

INSERT INTO copy_f_customers (id, first_name, last_name, address, city, state, zip, phone_number) 
VALUES (145, 'Katie', 'Hernandez', '92 Chico Way', 'Los Angeles', 'CA', 98008, 8586667641);

INSERT INTO sales_reps (id, name, salary, commission_pct) 
SELECT employee_id, last_name, salary, commission_pct 
FROM employees 
WHERE job_id LIKE '%REP%';

UPDATE copy_f_customers 
SET phone_number = '4475582344', city = 'Chicago' 
WHERE id < 200;

DELETE FROM copy_f_customers WHERE id = 123;

MERGE INTO copy_emp c 
USING employees e 
ON (c.employee_id = e.employee_id) 
WHEN MATCHED THEN 
    UPDATE SET c.last_name = e.last_name, c.department_id = e.department_id 
WHEN NOT MATCHED THEN 
    INSERT VALUES (e.employee_id, e.last_name, e.department_id);

CREATE TABLE cd_collection (
    cd_number NUMBER(2), 
    title VARCHAR2(14), 
    artist VARCHAR2(13), 
    purchase_date DATE DEFAULT SYSDATE
);

CREATE TABLE dept80 AS 
SELECT employee_id, last_name 
FROM employees 
WHERE department_id = 80;

ALTER TABLE copy_f_staffs ADD (hire_date DATE DEFAULT SYSDATE);
ALTER TABLE copy_f_staffs DROP COLUMN manager_target;
ALTER TABLE copy_f_staffs SET UNUSED (e_mail_address);

DROP TABLE copy_f_staffs;
FLASHBACK TABLE employees TO BEFORE DROP;
RENAME copy_f_staffs TO copy_fastfood_staffs;
TRUNCATE TABLE emp_copy;

CREATE TABLE clients (
    client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY, 
    first_name VARCHAR2(14), 
    last_name VARCHAR2(13),
    department_id VARCHAR2(4),
    CONSTRAINT clients_dept_id_fk FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE d_track_listings (
    track_id NUMBER(5), 
    song_id NUMBER(5),
    cd_number NUMBER(3),
    CONSTRAINT d_track_list_song_id_fk FOREIGN KEY(song_id) REFERENCES d_songs(id) ON DELETE CASCADE
);

ALTER TABLE staffs ADD CONSTRAINT staff_salary_ck CHECK (salary > 0);
ALTER TABLE staffs DROP CONSTRAINT staff_salary_ck;
ALTER TABLE staffs ADD CONSTRAINT salary_uk UNIQUE(salary);
ALTER TABLE d_clients MODIFY (email CONSTRAINT d_clients_email_nn NOT NULL);
