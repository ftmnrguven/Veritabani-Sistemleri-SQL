-- ==========================================
-- GENEL ÇALIŞMA SORULARI VE ÇÖZÜMLERİ
-- ==========================================

-- Soru 1: Her departmanda kaç çalışan olduğunu listeleyiniz.
SELECT department_id, COUNT(*) AS calisan_sayisi 
FROM employees 
GROUP BY department_id;

-- Soru 2: Ortalama maaşı 7000’den fazla olan departmanları listeleyiniz.
SELECT department_id, AVG(salary) AS ortalama_maas 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) > 7000;

-- Soru 3: En yüksek maaş alan çalışanın adını, soyadını ve maaşını listeleyiniz.
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Soru 4: Kendi departmanındaki ortalama maaştan daha fazla maaş alan çalışanları listeleyiniz.
SELECT e.first_name, e.last_name, e.salary, e.department_id 
FROM employees e 
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employees d 
    WHERE d.department_id = e.department_id
);

-- Soru 5: Her iş unvanı için çalışan sayısını ve ortalama maaşı listeleyiniz.
SELECT job_id, COUNT(*) AS calisan_sayisi, AVG(salary) AS ortalama_maas 
FROM employees 
GROUP BY job_id;

-- Soru 6: Departman adı, şehir adı ve ülke adını birlikte listeleyiniz.
SELECT d.department_name, l.city, c.country_name 
FROM departments d 
JOIN locations l ON d.location_id = l.location_id 
JOIN countries c ON l.country_id = c.country_id;

-- Soru 7: Çalışanı olmayan departmanları listeleyiniz.
SELECT department_id, department_name 
FROM departments 
WHERE department_id NOT IN (
    SELECT department_id 
    FROM employees 
    WHERE department_id IS NOT NULL
);

-- Soru 8: Maaşı kendi işinin minimum maaşından yüksek, maksimum maaşından düşük olan çalışanları listeleyiniz.
SELECT e.first_name, e.last_name, e.salary, j.job_title 
FROM employees e 
JOIN jobs j ON e.job_id = j.job_id 
WHERE e.salary > j.min_salary AND e.salary < j.max_salary;

-- Soru 9: Her departmandaki en yüksek maaşı listeleyiniz.
SELECT department_id, MAX(salary) AS en_yuksek_maas 
FROM employees 
GROUP BY department_id;

-- Soru 10: 2005 yılından sonra işe başlayan çalışanları listeleyiniz.
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) > 2005;

-- Soru 11: Departmanlara göre toplam maaş giderini listeleyiniz. Toplam maaşı büyükten küçüğe sıralayınız.
SELECT department_id, SUM(salary) AS toplam_maas 
FROM employees 
GROUP BY department_id 
ORDER BY toplam_maas DESC;

-- Soru 12: Aynı işi yapan çalışanları iş koduna göre gruplayıp çalışan sayısı 3’ten fazla olanları listeleyiniz.
SELECT job_id, COUNT(*) AS calisan_sayisi 
FROM employees 
GROUP BY job_id 
HAVING COUNT(*) > 3;

-- Soru 13: Maaşı 5000 ile 12000 arasında olan ve departman bilgisi bulunan çalışanları listeleyiniz.
SELECT first_name, last_name, salary, department_id 
FROM employees 
WHERE salary BETWEEN 5000 AND 12000 
AND department_id IS NOT NULL;

-- Soru 14: Her yöneticinin kaç çalışan yönettiğini listeleyiniz.
SELECT manager_id, COUNT(*) AS yonetilen_calisan_sayisi 
FROM employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id;

-- Soru 15: Yönetici adı ve yönettiği çalışan sayısını listeleyiniz.
SELECT m.first_name || ' ' || m.last_name AS yonetici_adi, COUNT(e.employee_id) AS calisan_sayisi 
FROM employees e 
JOIN employees m ON e.manager_id = m.employee_id 
GROUP BY m.first_name, m.last_name;

-- Soru 16: Yeni bir departman ekleyiniz.
INSERT INTO departments (department_id, department_name, manager_id, location_id) 
VALUES (300, 'NEW DEPARTMENT', NULL, 1700);

-- Soru 17: Maaşı 6000’den az olan çalışanların maaşına %10 zam yapınız.
UPDATE employees 
SET salary = salary * 1.10 
WHERE salary < 6000;

-- Soru 18: Çalışanı olmayan ve ID’si 300 olan departmanı siliniz.
DELETE FROM departments 
WHERE department_id = 300 
AND department_id NOT IN (
    SELECT department_id FROM employees WHERE department_id IS NOT NULL
);

-- Soru 19: Her departmanda en yüksek maaş alan çalışanları listeleyiniz.
SELECT e.department_id, e.first_name, e.last_name, e.salary 
FROM employees e 
WHERE (e.department_id, e.salary) IN (
    SELECT department_id, MAX(salary) 
    FROM employees 
    GROUP BY department_id
);

-- Soru 20: Maaşı şirket ortalamasından yüksek olan çalışanları departman adıyla birlikte listeleyiniz.
SELECT e.first_name, e.last_name, e.salary, d.department_name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id 
WHERE e.salary > (SELECT AVG(salary) FROM employees);

-- Soru 21: Ortalama maaşı şirket ortalamasından yüksek olan departmanları listeleyiniz.
SELECT department_id, AVG(salary) AS ortalama_maas 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

-- Soru 22: Her ülkeye göre çalışan sayısını listeleyiniz.
SELECT c.country_name, COUNT(e.employee_id) AS calisan_sayisi 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id 
JOIN countries c ON l.country_id = c.country_id 
GROUP BY c.country_name;

-- Soru 23: Kendi yöneticisinden daha fazla maaş alan çalışanları listeleyiniz.
SELECT e.first_name AS calisan_adi, e.salary AS calisan_maasi, 
       m.first_name AS yonetici_adi, m.salary AS yonetici_maasi 
FROM employees e 
JOIN employees m ON e.manager_id = m.employee_id 
WHERE e.salary > m.salary;

-- Soru 24: Her yöneticinin yönettiği çalışanların ortalama maaşını listeleyiniz.
SELECT manager_id, AVG(salary) AS ortalama_maas 
FROM employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id;

-- Soru 25: Yönettiği çalışanların ortalama maaşı 8000’den fazla olan yöneticileri listeleyiniz.
SELECT manager_id, AVG(salary) AS ortalama_maas 
FROM employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
HAVING AVG(salary) > 8000;

-- Soru 26: Hiç yöneticilik yapmayan çalışanları listeleyiniz.
SELECT employee_id, first_name, last_name 
FROM employees 
WHERE employee_id NOT IN (
    SELECT manager_id FROM employees WHERE manager_id IS NOT NULL
);

-- Soru 27: En az 5 çalışanı olan departmanların adını, çalışan sayısını ve toplam maaşını listeleyiniz.
SELECT d.department_name, COUNT(e.employee_id) AS calisan_sayisi, SUM(e.salary) AS toplam_maas 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name 
HAVING COUNT(e.employee_id) >= 5;

-- Soru 28: Her iş unvanında en düşük maaşı alan çalışanları listeleyiniz.
SELECT e.job_id, e.first_name, e.last_name, e.salary 
FROM employees e 
WHERE (e.job_id, e.salary) IN (
    SELECT job_id, MIN(salary) 
    FROM employees 
    GROUP BY job_id
);

-- Soru 29: Maaşı kendi iş unvanının ortalama maaşından yüksek olan çalışanları listeleyiniz.
SELECT e.first_name, e.last_name, e.job_id, e.salary 
FROM employees e 
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employees j 
    WHERE j.job_id = e.job_id
);

-- Soru 30: Departmanında tek çalışan olan kişileri listeleyiniz.
SELECT first_name, last_name, department_id 
FROM employees 
WHERE department_id IN (
    SELECT department_id 
    FROM employees 
    GROUP BY department_id 
    HAVING COUNT(*) = 1
);

-- Soru 31: Her çalışanın şirkette kaç yıldır çalıştığını listeleyiniz.
SELECT first_name, last_name, hire_date, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS calistigi_yil 
FROM employees;

-- Soru 32: 10 yıldan fazla süredir çalışanların departman adını ve iş unvanını listeleyiniz.
SELECT e.first_name, e.last_name, d.department_name, j.job_title 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id 
JOIN jobs j ON e.job_id = j.job_id 
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) > 10;

-- Soru 33: Ortalama maaşı en yüksek olan departmanı listeleyiniz.
SELECT department_id, AVG(salary) AS ortalama_maas 
FROM employees 
GROUP BY department_id 
HAVING AVG(salary) = (
    SELECT MAX(AVG(salary)) 
    FROM employees 
    GROUP BY department_id
);

-- Soru 34: Yeni bir tablo oluşturunuz: HIGH_SALARY_EMPLOYEES. Maaşı 10000’den fazla olan çalışanların employee_id, first_name, last_name, salary ve department_id bilgilerini bu tabloya ekleyiniz.
CREATE TABLE HIGH_SALARY_EMPLOYEES AS 
SELECT employee_id, first_name, last_name, salary, department_id 
FROM employees 
WHERE salary > 10000;

-- Soru 35: Her departman için maaş durumu üretiniz. Ortalama maaş 10000’den büyükse “Yüksek”, 5000–10000 arasındaysa “Orta”, 5000’den küçükse “Düşük” yazdırınız.
SELECT department_id, 
       AVG(salary) AS ortalama_maas, 
       CASE 
           WHEN AVG(salary) > 10000 THEN 'Yüksek' 
           WHEN AVG(salary) BETWEEN 5000 AND 10000 THEN 'Orta' 
           ELSE 'Düşük' 
       END AS maas_durumu 
FROM employees 
GROUP BY department_id;
