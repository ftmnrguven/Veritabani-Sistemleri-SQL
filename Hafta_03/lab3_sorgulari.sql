-- Mantık Operatörleri ve Filtreleme
SELECT * FROM employees;

SELECT last_name, department_id, salary FROM employees 
WHERE department_id > 50 AND salary > 12000;

SELECT last_name, hire_date, job_id FROM employees 
WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%';

SELECT department_name, manager_id, location_id FROM departments 
WHERE location_id = 2500 OR manager_id=124;

SELECT department_name, location_id FROM departments 
WHERE location_id NOT IN (1700,1800);

SELECT first_name, manager_id FROM employees 
WHERE manager_id IS NOT NULL;

SELECT first_name, last_name, department_id, last_name||' '||salary*1.05 AS "Employee Raise" 
FROM employees 
WHERE department_id IN(50,80) OR first_name LIKE 'C%' AND last_name LIKE '%s%';

-- Sayı ve Tarih Dönüşüm Fonksiyonları (TO_CHAR, TO_DATE)
SELECT TO_CHAR(123, '9999') FROM dual;
SELECT TO_CHAR(123, '0000') FROM dual;
SELECT TO_CHAR(1234, '$9999') FROM dual;
SELECT TO_CHAR(1234, 'L9999') FROM dual;
SELECT TO_CHAR(1234.56, '9999.99') FROM dual;
SELECT TO_CHAR(1234567, '9,999,999') FROM dual;
SELECT TO_CHAR(-123, '999MI') FROM dual;
SELECT TO_CHAR(-123, '999PR') FROM dual;
SELECT TO_CHAR(123456, '9.99EEEE') FROM dual;

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY') 
FROM employees 
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-RR');

-- NULL Fonksiyonları
SELECT salary + commission FROM employees;
SELECT NVL(commission_pct, 0) FROM employees;
SELECT NULLIF(5,5) FROM dual;
SELECT NULLIF(5,3) FROM dual;
SELECT COALESCE(NULL, NULL, 5) FROM dual;

-- Koşullu İfadeler (CASE ve DECODE)
SELECT id, loc_type, rental_fee, 
    CASE loc_type 
        WHEN 'Private Home' THEN 'No Increase' 
        WHEN 'Hotel' THEN 'Increase 5%' 
        ELSE rental_fee 
    END AS "REVISED_FEES" 
FROM d_venues;

SELECT last_name, salary, 
    CASE 
        WHEN salary > 10000 THEN 'Yüksek Maaş' 
        ELSE 'Normal Maaş' 
    END AS salary_level 
FROM employees;

SELECT id, loc_type, rental_fee, 
DECODE(loc_type, 'Private Home','No Increase', 'Hotel','Increase 5%', rental_fee) AS REVISED_FEES 
FROM d_venues;
