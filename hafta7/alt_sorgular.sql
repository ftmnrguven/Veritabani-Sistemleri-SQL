-- ==========================================
-- HAFTA 7: Alt Sorgular (Subqueries)
-- ==========================================

-- Tek Satır Alt Sorguları
SELECT id, first_name, last_name, birthdate 
FROM f_staffs 
WHERE birthdate > (
    SELECT birthdate FROM f_staffs WHERE last_name = 'Miller'
);

SELECT last_name, job_id, department_id 
FROM employees 
WHERE department_id = (
    SELECT department_id FROM departments WHERE department_name = 'Marketing'
);

-- Çok Satır Alt Sorguları (IN, ANY, ALL)
SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN (
    SELECT manager_id, department_id FROM employees WHERE employee_id IN (149, 174)
) AND employee_id NOT IN (149, 174);

SELECT title, producer, year 
FROM d_cds 
WHERE year < ANY (
    SELECT year FROM d_cds WHERE producer = 'The Music Man'
);

SELECT department_id, MIN(salary) 
FROM employees 
GROUP BY department_id 
HAVING MIN(salary) > ALL (
    SELECT MIN(salary) FROM employees WHERE department_id < 50 GROUP BY department_id
);

-- HAVING İle Alt Sorgu
SELECT department_id, AVG(salary) 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) > (
    SELECT AVG(salary) FROM employees
);

-- EXISTS ve NOT EXISTS
SELECT * FROM employees t1 
WHERE EXISTS (
    SELECT 1 FROM employees t2 WHERE t1.employee_id = t2.manager_id
);

SELECT * FROM employees t1 
WHERE NOT EXISTS (
    SELECT 1 FROM employees t2 WHERE t1.employee_id = t2.manager_id
);
SELECT name, event_date, loc_type, rental_fee 
FROM d_events CROSS JOIN d_venues;

SELECT first_name, last_name, event_date, description 
FROM d_clients NATURAL JOIN d_events;

SELECT employee_id, last_name, department_name
FROM employees JOIN departments USING (department_id);

SELECT e.first_name, e.last_name, d.department_name 
FROM employees e JOIN departments d ON e.department_id = d.department_id;

CREATE TABLE ogrenciler (
    ogrenci_id NUMBER PRIMARY KEY, 
    ad VARCHAR2(30) NOT NULL
);

CREATE TABLE dersler (
    ders_id NUMBER PRIMARY KEY,
    ders_adi VARCHAR2(50)
);

CREATE TABLE notlar (
    not_id NUMBER PRIMARY KEY, 
    ogrenci_id NUMBER REFERENCES ogrenciler(ogrenci_id), 
    ders_id NUMBER REFERENCES dersler(ders_id), 
    not_degeri NUMBER DEFAULT 0 CHECK(not_degeri BETWEEN 0 AND 100),
    CONSTRAINT ogr_ders_uk UNIQUE (ogrenci_id, ders_id) 
);

SELECT year_in_school, AVG(height) AS ortalama_boy 
FROM students 
GROUP BY year_in_school;

SELECT department_id, MAX(salary) AS maksimum_maas 
FROM employees 
WHERE last_name <> 'King' 
GROUP BY department_id;

SELECT department_id, job_id, COUNT(*) 
FROM employees 
WHERE department_id > 40 
GROUP BY department_id, job_id;

SELECT department_id, AVG(salary) 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) > 8000;

SELECT location_id, department_name, TO_CHAR(NULL) AS warehouse_name 
FROM departments
UNION
SELECT location_id, TO_CHAR(NULL) AS department_name, warehouse_name 
FROM warehouses;

SELECT employee_id, job_id, TO_DATE(NULL) AS start_date, TO_DATE(NULL) AS end_date 
FROM employees
UNION
SELECT employee_id, job_id, start_date, end_date 
FROM job_history;
