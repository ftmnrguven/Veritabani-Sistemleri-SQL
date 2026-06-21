-- ==========================================
-- HAFTA 5 (LAB 5) - JOIN İŞLEMLERİ VE KISITLAMALAR
-- ==========================================

-- CROSS JOIN: Her kaydı diğer tablodaki tüm kayıtlarla eşleştirir (Kartezyen çarpım)
SELECT name, event_date, loc_type, rental_fee 
FROM d_events CROSS JOIN d_venues;

-- NATURAL JOIN: İki tablodaki aynı isimli sütunları otomatik bulur ve eşleştirir
SELECT first_name, last_name, event_date, description 
FROM d_clients NATURAL JOIN d_events;

-- JOIN ... USING: Hangi sütun üzerinden birleştirme yapılacağını açıkça belirtiriz
SELECT employee_id, last_name, department_name
FROM employees JOIN departments USING (department_id);

-- JOIN ... ON: Sütun isimleri farklıysa veya özel koşullar gerekiyorsa kullanılır
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e JOIN departments d ON e.department_id = d.department_id;

-- TABLO OLUŞTURMA VE KISITLAMALAR (CONSTRAINTS)

-- PRIMARY KEY ve NOT NULL Kısıtlamaları
CREATE TABLE ogrenciler (
    ogrenci_id NUMBER PRIMARY KEY, 
    ad VARCHAR2(30) NOT NULL
);

CREATE TABLE dersler (
    ders_id NUMBER PRIMARY KEY,
    ders_adi VARCHAR2(50)
);

-- FOREIGN KEY, UNIQUE, DEFAULT ve CHECK Kısıtlamaları
CREATE TABLE notlar (
    not_id NUMBER PRIMARY KEY, 
    ogrenci_id NUMBER REFERENCES ogrenciler(ogrenci_id), -- Başka tabloya bağlantı (FK)
    ders_id NUMBER REFERENCES dersler(ders_id),          -- Başka tabloya bağlantı (FK)
    not_degeri NUMBER DEFAULT 0 CHECK(not_degeri BETWEEN 0 AND 100), -- 0-100 arası şartı
    CONSTRAINT ogr_ders_uk UNIQUE (ogrenci_id, ders_id)  -- Aynı öğrenci aynı derse 1 kez not alabilir
);


-- ==========================================
-- HAFTA 6 (LAB 6) - GROUP BY, HAVING VE KÜME OPERATÖRLERİ
-- ==========================================

-- GROUP BY: Verileri belirli alanlara göre gruplamak için kullanılır
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

-- HAVING: WHERE satırları filtrelerken, HAVING gruplar üzerinde filtreleme yapar
SELECT department_id, AVG(salary) 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) > 8000;

-- KÜME OPERATÖRLERİ (UNION, vb.)
-- Sütun sayısı ve veri tipleri aynı olmalıdır.
-- Eksik sütunlar için veri tipine uygun NULL (TO_CHAR(NULL), TO_DATE(NULL) vb.) atanır.

SELECT location_id, department_name, TO_CHAR(NULL) AS warehouse_name 
FROM departments
UNION
SELECT location_id, TO_CHAR(NULL) AS department_name, warehouse_name 
FROM warehouses;

-- İş geçmişi ve mevcut çalışanları birleştirme örneği
SELECT employee_id, job_id, TO_DATE(NULL) AS start_date, TO_DATE(NULL) AS end_date 
FROM employees
UNION
SELECT employee_id, job_id, start_date, end_date 
FROM job_history;
