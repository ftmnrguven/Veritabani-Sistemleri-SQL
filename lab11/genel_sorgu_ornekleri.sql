-- ==========================================
-- LAB 11: Genel Sorgu Uygulamaları ve Çözümler
-- ==========================================

-- Soru 1: Maaşı 8000'den büyük olanlar
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 8000;

-- Soru 2: Büyükten küçüğe sıralama
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;

-- Soru 3: Tabloya Veri Ekleme
INSERT INTO departments VALUES (300, 'SOFTWARE', 100, 1700);

-- Soru 5: Veri Güncelleme
UPDATE departments 
SET department_name = 'SOFTWARE ENGINEERING' 
WHERE department_id = 300;

-- Soru 6: Veri Silme
DELETE FROM departments WHERE department_id = 301;

-- Soru 7: Matematiksel işlem ile güncelleme
UPDATE employees SET salary = salary + 500 WHERE salary < 5000;

-- Soru 8: NULL sorgulama ve silme
DELETE FROM departments WHERE manager_id IS NULL;

-- Soru 9: GROUP BY ve COUNT kullanımı
SELECT department_id, COUNT(*) AS calisan_sayisi 
FROM employees 
GROUP BY department_id;

-- Soru 10: INNER JOIN sorgusu
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id;

-- Soru 11: NULL değere atama yapma
UPDATE employees SET commission_pct = 0.15 WHERE commission_pct IS NULL;

-- Soru 12: Alt sorgu kullanarak silme işlemi (Hiç çalışanı olmayan departmanları silme)
DELETE FROM departments 
WHERE department_id NOT IN (
    SELECT department_id FROM employees WHERE department_id IS NOT NULL
);

-- Soru 13: Belirli koşulla yeni tablo oluşturma
CREATE TABLE emp_copy AS 
SELECT employee_id, first_name, salary, department_id 
FROM employees 
WHERE department_id = 60;
