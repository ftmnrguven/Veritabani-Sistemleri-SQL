-- ==========================================
-- LAB 4: JOIN Türleri ve Hiyerarşik Sorgular
-- ==========================================

-- Tablo Birleştirme (JOIN) İşlemleri
SELECT e.first_name || ' ' || e.last_name AS "Employee_Name", j.job_title 
FROM employees e, jobs j 
WHERE e.job_id = j.job_id;

-- NATURAL JOIN: İki tablodaki aynı isimli sütunları otomatik eşleştirir
SELECT first_name, last_name, event_date, description 
FROM d_clients NATURAL JOIN d_events;

-- JOIN ... USING: Eşleşecek sütunu açıkça belirtme
SELECT employee_id, last_name, department_name
FROM employees JOIN departments USING (department_id);

-- CROSS JOIN: Kartezyen çarpım
SELECT name, event_date, loc_type, rental_fee 
FROM d_events CROSS JOIN d_venues;

-- Hiyerarşik Sorgular (CONNECT BY, PRIOR, LEVEL, LPAD)
-- Çalışanlar ve yöneticileri arasındaki organizasyon ağacını listeleme (Yukarıdan aşağıya)
SELECT employee_id, last_name, job_id, manager_id, LEVEL, 
       LPAD(last_name, LENGTH(last_name) + (LEVEL*2) - 2, '_') AS "Org_Chart"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

-- Hiyerarşiyi aşağıdan yukarıya listeleme (Çalışandan yöneticiye doğru)
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 103
CONNECT BY employee_id = PRIOR manager_id;
