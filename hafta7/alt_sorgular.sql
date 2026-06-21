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
