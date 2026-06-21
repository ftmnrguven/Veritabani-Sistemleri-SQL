-- ==========================================
-- LAB 5 & 6: Kısıtlamalar (Constraints), GROUP BY, HAVING, Küme Operatörleri
-- ==========================================

-- Temel Tablo Oluşturma ve Kısıtlamalar
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

-- Grup Fonksiyonları (GROUP BY ve HAVING)
SELECT AVG(height) FROM students;

SELECT year_in_school, AVG(height) AS ortalama_boy 
FROM students 
GROUP BY year_in_school;

SELECT department_id, MAX(salary) AS maksimum_maas 
FROM employees 
WHERE last_name <> 'King' 
GROUP BY department_id;

SELECT city, AVG(graduation_rate) AS ortalama_mezuniyet 
FROM students 
WHERE graduation_date >= '01-JUN-2007' 
GROUP BY city;

SELECT department_id, job_id, COUNT(*) 
FROM employees 
WHERE department_id > 40 
GROUP BY department_id, job_id;

-- Küme Operatörleri ile Tablo Birleştirme (UNION, UNION ALL vb.)
-- İki farklı sorgunun sonuç kümesini veri tipi uyumu sağlayarak birleştirme
SELECT location_id, department_name, TO_CHAR(NULL) AS warehouse_name 
FROM departments
UNION
SELECT location_id, TO_CHAR(NULL) AS department_name, warehouse_name 
FROM warehouses;
