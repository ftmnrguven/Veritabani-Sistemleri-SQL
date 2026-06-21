-- ==========================================
-- LAB 3: Mantıksal Operatörler, ORDER BY, NULL Fonksiyonları ve Koşullu İfadeler
-- ==========================================

-- Mantıksal Karşılaştırmalar (AND, OR, NOT)
SELECT last_name, department_id, salary FROM employees
WHERE department_id > 50 AND salary > 12000;

SELECT last_name, hire_date, job_id FROM employees
WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%'; 

SELECT department_name, manager_id, location_id FROM departments
WHERE location_id = 2500 OR manager_id = 124;

SELECT department_name, location_id FROM departments
WHERE location_id NOT IN (1700, 1800);

SELECT first_name, manager_id FROM employees 
WHERE manager_id IS NOT NULL;

SELECT first_name, last_name, department_id, last_name||' '||salary*1.05 AS "Employee Raise" 
FROM employees 
WHERE department_id IN(50,80) OR first_name LIKE 'C%' AND last_name LIKE '%s%';

-- NULL Fonksiyonları
SELECT salary + commission FROM employees;
SELECT NVL(commission_pct, 0) FROM employees;

SELECT NULLIF(5,5) FROM dual; -- Sonuç: NULL
SELECT NULLIF(5,3) FROM dual; -- Sonuç: 5

-- COALESCE: İlk NULL olmayan değeri döndürür
SELECT COALESCE(NULL, NULL, 5) FROM dual;

-- Koşullu İfadeler: CASE 
SELECT id, loc_type, rental_fee,
    CASE loc_type
        WHEN 'Private Home' THEN 'No Increase'  -- kira artışı yok.
        WHEN 'Hotel' THEN 'Increase 5%'         -- %5 kira artışı öneriliyor.
        ELSE rental_fee                         -- mevcut kira ücreti
    END AS "REVISED_FEES"
FROM d_venues;

SELECT last_name, salary,
    CASE
        WHEN salary > 10000 THEN 'Yüksek Maaş'
        ELSE 'Normal Maaş'
    END AS salary_level
FROM employees;

-- Koşullu İfadeler: DECODE (Oracle'a özel IF-THEN-ELSE mantığı)
SELECT id, loc_type, rental_fee,
    DECODE(loc_type,
       'Private Home','No Increase',
       'Hotel','Increase 5%',
       rental_fee) AS REVISED_FEES
FROM d_venues;
