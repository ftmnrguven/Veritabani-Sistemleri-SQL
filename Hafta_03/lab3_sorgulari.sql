-- LAB 3

-- Mantık Operatörleri

SELECT * FROM employees;
-- EMPLOYEE_ID: Çalışanın benzersiz numarasıdır. Her çalışan için farklıdır
-- HIRE_DATE: Çalışanın işe giriş tarihi
-- JOB_ID: Çalışanın görev kodu
-- COMMISSION_PCT: Satış çalışanları için prim oranı
-- MANAGER_ID: Çalışanın bağlı olduğu yöneticinin ID’si
-- DEPARTMENT_ID: Çalışanın bulunduğu departman
-- BONUS: Bazı çalışanlara verilen ek prim / bonus
SELECT last_name, department_id, salary FROM employees
WHERE department_id > 50 AND salary > 12000;

SELECT last_name, hire_date, job_id FROM employees
WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%'; 

SELECT * FROM departments;
-- DEPARTMENT_ID: Departmanın benzersiz numarasıdır. Her departman için farklıdır.
-- DEPARTMENT_NAME: Departmanın adı
-- MANAGER_ID: Departmanın yöneticisinin çalışan numarasıdır. Bu değer EMPLOYEES tablosundaki EMPLOYEE_ID ile ilişkilidir.
-- LOCATION_ID: Departmanın bulunduğu fiziksel lokasyon. Bu da başka bir tabloya bağlıdır: LOCATIONS
SELECT * FROM locations;

SELECT department_name, manager_id, location_id FROM departments
WHERE location_id = 2500 OR manager_id=124;

SELECT department_name, location_id FROM departments
WHERE location_id NOT IN (1700,1800);

-- Yöneticisi olan çalışanlar
SELECT first_name, manager_id FROM employees WHERE manager_id IS NOT NULL;

/* AND kullanıldığında iki koşulun da doğru olması gerekir.
    TRUE AND TRUE  → TRUE
    TRUE AND FALSE → FALSE
    FALSE AND TRUE → FALSE
    FALSE AND FALSE → FALSE
*/

/* OR kullanıldığında en az bir koşul doğruysa sonuç TRUE olur.
    TRUE OR TRUE  → TRUE
    TRUE OR FALSE → TRUE
    FALSE OR TRUE → TRUE
    FALSE OR FALSE → FALSE
*/


SELECT first_name, last_name, department_id, last_name||' '||salary*1.05 AS "Employee Raise" FROM employees
WHERE department_id IN(50,80) AND first_name LIKE 'C%'
  OR last_name LIKE '%s%';
-- Yukarıdaki sorguda operatör öncelliğine dikkat edelim. Önce AND çalışır, sonra OR çalışır.
-- 1. grup: Departmanı 50 veya 80 olan VE adı C ile başlayanlar
-- VEYA 2. grup: Soyadında “s” geçen herkes (departmanı ne olursa olsun)
-- Bu nedenle DEPARTMENT_ID kolonunda 110 görüyoruz. Aslında soyadında “s” geçen birini almış oluyoruz.

-- “Ben sadece 50 ve 80 departmanlarını istiyorum” dersek, parantez eklemeliyiz. Önceliği güncellememizi sağlar.
SELECT first_name, last_name, department_id, last_name || ' ' || salary*1.05 AS "Employee Raise" 
FROM employees
WHERE department_id IN (50,80)
  AND (first_name LIKE 'C%' OR last_name LIKE '%s%');
-- Böyle olunca: Departman mutlaka 50 veya 80 olacak, 
-- üstüne bir de "adı C ile başlasın VEYA soyadında s olsun" şartı uygulanacak

SELECT first_name, last_name, department_id, last_name||' '||salary*1.05 AS "Employee Raise"
FROM employees
WHERE department_id IN(50,80)
OR first_name LIKE 'C%'
AND last_name LIKE '%s%';
-- AND önce çalışır, OR sonra çalışır. Bu yüzden sorgu yazıldığı gibi değil, şu şekilde yorumlanır:
-- WHERE department_id IN (50,80) OR (first_name LIKE 'C%' AND last_name LIKE '%s%')
-- d_id = 50, d_i=80, first_name and last_name = C***** *****s*****
-- Bu sorgu departmanı 50 veya 80 olan tüm çalışanları getirir.
-- Ayrıca departmanı farklı olsa bile adı C ile başlayıp soyadında s bulunan çalışanları da sonuç kümesine ekler.


SELECT first_name, last_name, department_id, last_name||' '||salary*1.05 AS "Employee Raise"
FROM employees
WHERE (department_id IN(50,80) OR first_name LIKE 'C%')
AND last_name LIKE '%s%';
-- İşlem sırası:  Parantez ->  AND -> OR
-- Bu sorgu, soyadında s harfi bulunan çalışanlar arasından departmanı 50 veya 80 olanları ya da adı C ile başlayanları listeler.


-- ORDER BY
SELECT last_name, hire_date FROM employees ORDER BY hire_date;
SELECT last_name, hire_date FROM employees ORDER BY hire_date DESC;
SELECT last_name, hire_date AS "Date Started" FROM employees ORDER BY "Date Started";
-- çalışma sırası : from-where-select-order by
SELECT employee_id, first_name, last_name FROM employees 
WHERE employee_id < 105 ORDER BY last_name;

SELECT department_id, last_name FROM employees
WHERE department_id <= 50 ORDER BY department_id, last_name;

SELECT department_id, last_name FROM employees
WHERE department_id <= 50 ORDER BY department_id DESC, last_name;

-- En yüksek maaşı alan çalışan kimdir?
SELECT first_name, salary FROM employees ORDER BY salary DESC;
-- SELECT first_name, last_name, salary FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);
-- SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC FETCH FIRST 1 ROW ONLY;


-- Tarih -> Karakter Dönüşümü
SELECT hire_date FROM employees;
SELECT TO_CHAR(hire_date,'dd Month YYYY') FROM employees;
SELECT TO_CHAR(hire_date,'dd Mon YYYY') FROM employees;
SELECT TO_CHAR(hire_date,'Month dd YYYY') FROM employees;
SELECT TO_CHAR(hire_date,'fmMonth dd, YYYY') FROM employees;
/* FM (Fill Mode): FM bu boşlukları kaldırır.
TH (Ordinal): Sıralı sayı formatı üretir.
*/
SELECT TO_CHAR(hire_date,'fmMonth ddth, YYYY') AS tarih FROM employees;

SELECT TO_DATE('November 3, 2001', 'Month dd, yyyy') FROM dual; 
/* Oracle verdiğimiz format modeline göre okur.
Ay = November
Gün = 3
Yıl = 2001
ve DATE değeri olarak:  03-NOV-2001 üretir.
Varsayılan -> gün - ay - yıl
*/



-- Sayı → Karakter Dönüşümü Formatları
SELECT TO_CHAR(123, '9999') FROM dual; 
SELECT TO_CHAR(123, '0000') FROM dual;
SELECT TO_CHAR(1234, '$9999') FROM dual;
SELECT TO_CHAR(1234, 'L9999') FROM dual;
SELECT TO_CHAR(1234.56, '9999.99') FROM dual;
SELECT TO_CHAR(1234567, '9,999,999') FROM dual;
SELECT TO_CHAR(-123, '999MI') FROM dual;
SELECT TO_CHAR(-123, '999PR') FROM dual;
SELECT TO_CHAR(123456, '9.99EEEE') FROM dual;

-- FX Kullanımı
SELECT TO_DATE('3-11-2001','fxDD-MM-YYYY') FROM dual;
-- Bu sorgu hata verir. Çünkü: DD → iki basamak bekler
-- FX ile Doğru Kullanım
SELECT TO_DATE('03-11-2001','fxDD-MM-YYYY') FROM dual;

-- RR ve YY Tarih Formatı
SELECT last_name, hire_date FROM employees 
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY');

SELECT last_name, hire_date FROM employees 
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-RR');


-- NVL Fonksiyonu

SELECT * FROM D_PLAY_LIST_ITEMS;

SELECT comments, NVL(comments, 'no comment') FROM D_PLAY_LIST_ITEMS;

----------

SELECT * FROM D_PARTNERS;

SELECT first_name, last_name, auth_expense_amt, NVL(auth_expense_amt,0) FROM D_PARTNERS;

-- NVL2 Fonksiyonu

SELECT * FROM EMPLOYEES

SELECT last_name, commission_pct, 
       NVL2(commission_pct, 'Komisyon Var', 'Komisyon Yok')
FROM employees;

SELECT last_name, commission_pct, salary, NVL2(commission_pct, salary + (salary * commission_pct), salary) AS income FROM EMPLOYEES;
-- Mantık:
-- Eğer komisyon varsa → maaş + komisyon
-- Eğer komisyon yoksa → sadece maaş

-- NULLIF Fonksiyonu 
SELECT * FROM D_PARTNERS;

SELECT first_name, 
       LENGTH(first_name) "Length FN", 
       last_name, 
       LENGTH(last_name) "Length LN", 
       NULLIF(LENGTH(first_name), LENGTH(last_name)) AS "Compare Them" 
FROM D_PARTNERS;


-- COALESCE Fonksiyonu
SELECT last_name, commission_pct, salary, COALESCE(commission_pct, salary, 10) comm
FROM employees
ORDER BY commission_pct;


-- Koşullu İfadeler
-- CASE
SELECT last_name, commission_pct, 
       CASE
           WHEN commission_pct IS NULL THEN 'Bonus Yok'
           ELSE 'Bonus Var'
       END AS bonus
FROM employees;


SELECT * FROM d_venues;

SELECT id, loc_type,rental_fee,
    CASE loc_type
        WHEN 'Private Home' THEN 'No Increase'  -- kira artışı yok.
        WHEN 'Hotel' THEN 'Increase 5%' -- %5 kira artışı öneriliyor.
        ELSE rental_fee  -- mevcut kira ücreti
    END AS "REVISED_FEES"
FROM d_venues;
-- Bu sorgu mekan türüne (loc_type) göre kira ücretinde değişiklik olup olmadığını gösteren yeni bir sütun oluşturur. Yeni oluşturulan sütunun adı: REVISED_FEES
-- rental_fee → mevcut kira ücreti

-- Maaşı 10000’den büyük olanlara Yüksek Maaş, diğerlerine Normal Maaş yazdıran sorguyu yazınız.
SELECT last_name, salary,
    CASE
        WHEN salary > 10000 THEN 'Yüksek Maaş'
        ELSE 'Normal Maaş'
    END AS salary_level
FROM employees;

-- DECODE
SELECT * FROM d_venues;

-- Bu sorgu mekân türüne (loc_type) bakarak yeni ücret bilgisini (REVISED_FEES) hesaplar.
-- Private Home → fiyat değişmeyecek
-- Hotel → %5 artış olacak
-- Diğer mekanlar → mevcut fiyat gösterilecek

-- id → mekanın kimliği
-- loc_type → mekan türü
-- rental_fee → mevcut kiralama ücreti
SELECT id, loc_type, rental_fee,
DECODE(loc_type,
       'Private Home','No Increase',
       'Hotel','Increase 5%',
       rental_fee) AS REVISED_FEES
FROM d_venues;


-- Eğer Varsayılan Yazmazsak
SELECT department_id, DECODE(department_id,
              10, 'Accounting',
              80, 'Research')
FROM employees;
-- Varsayılan Değer Eklersek
SELECT department_id, DECODE(department_id,
              10, 'Accounting',
              20, 'Research',
              'Other')
FROM employees;
