-- ==========================================
-- HAFTA 9: Veri Tanımlama Dili (DDL) ve Veri Sözlüğü
-- ==========================================

-- Tablo Oluşturma
CREATE TABLE cd_collection (
    cd_number NUMBER(2), 
    title VARCHAR2(14), 
    artist VARCHAR2(13), 
    purchase_date DATE DEFAULT SYSDATE
);

-- Alt sorgu ile tablo kopyalama/oluşturma
CREATE TABLE dept80 AS 
SELECT employee_id, last_name 
FROM employees 
WHERE department_id = 80;

-- Tabloyu Değiştirme (ALTER TABLE)
ALTER TABLE copy_f_staffs ADD (hire_date DATE DEFAULT SYSDATE);
ALTER TABLE copy_f_staffs ADD (e_mail_address VARCHAR2(80));

ALTER TABLE mod_emp MODIFY (last_name VARCHAR2(30));

ALTER TABLE copy_f_staffs DROP COLUMN manager_target;

-- Büyük tablolarda silmek yerine "Kullanılmayan" olarak işaretleme
ALTER TABLE copy_f_staffs SET UNUSED (e_mail_address);

-- Tablo Silme, Kurtarma ve İsim Değiştirme
DROP TABLE copy_f_staffs;
FLASHBACK TABLE employees TO BEFORE DROP; -- Çöp kutusundan (Recycle Bin) kurtar
RENAME copy_f_staffs TO copy_fastfood_staffs;
TRUNCATE TABLE emp_copy; -- Verileri hızlıca temizler, yapıyı korur

-- Veri Sözlüğü Görünümlerine Erişim
SELECT * FROM USER_TABLES;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_SEQUENCES;
SELECT original_name, operation, droptime FROM user_recyclebin;

-- Tablolara Açıklama Eklemek (COMMENT)
COMMENT ON TABLE employees IS 'Western Region only';
COMMENT ON COLUMN employees.first_name IS 'Çalışanın gerçek adı';
SELECT table_name, comments FROM user_tab_comments;

-- Sorguyu Geri Alma (Flashback Query - Geçmiş Versiyonlar)
SELECT employee_id, first_name ||' '|| last_name AS "NAME",
       versions_operation AS "OPERATION",
       versions_starttime AS "START_DATE",
       versions_endtime AS "END_DATE", salary
FROM employees
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;
