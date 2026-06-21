-- ==========================================
-- HAFTA 10: Kısıtlamalar (Constraints)
-- ==========================================

-- Tablo Oluştururken Kısıt Tanımlama
CREATE TABLE clients (
    client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY, 
    first_name VARCHAR2(14), 
    last_name VARCHAR2(13),
    department_id VARCHAR2(4),
    CONSTRAINT clients_dept_id_fk FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Birleşik (Composite) Kısıtlamalar
CREATE TABLE customer (
    first_name VARCHAR2(30), 
    last_name VARCHAR2(30), 
    CONSTRAINT customer_name_uk UNIQUE(first_name, last_name)
);

-- ON DELETE CASCADE Özelliği (Ana kayır silinince alt kayıt da silinir)
CREATE TABLE d_track_listings (
    track_id NUMBER(5), 
    song_id NUMBER(5),
    cd_number NUMBER(3),
    CONSTRAINT d_track_list_song_id_fk FOREIGN KEY(song_id) REFERENCES d_songs(id) ON DELETE CASCADE
);

-- CHECK Kısıtlaması
CREATE TABLE staffs (
    staff_id NUMBER(5),
    salary NUMBER(8,2),
    staff_name VARCHAR2(30),
    CONSTRAINT f_staffs_min_salary CHECK (salary > 0)
);

-- ALTER TABLE ile Kısıtlama Yönetimi
ALTER TABLE staffs ADD CONSTRAINT staff_salary_ck CHECK (salary > 0);
ALTER TABLE staffs DROP CONSTRAINT staff_salary_ck;
ALTER TABLE staffs ADD CONSTRAINT salary_uk UNIQUE(salary);

-- Sütuna Sonradan NOT NULL Eklemek (MODIFY kullanılır)
ALTER TABLE d_clients MODIFY (email CONSTRAINT d_clients_email_nn NOT NULL);

-- İlişkili Yapıları Birlikte Silme (CASCADE)
ALTER TABLE departments DROP PRIMARY KEY CASCADE;
ALTER TABLE employees DROP COLUMN department_id CASCADE CONSTRAINTS;

-- Kısıtları Etkinleştirme / Devre Dışı Bırakma
ALTER TABLE d_clients DISABLE CONSTRAINT clients_client_num_pk;
ALTER TABLE d_clients ENABLE CONSTRAINT clients_client_num_pk;

-- Veri Sözlüğünden Kısıtları Görüntüleme
SELECT constraint_name, constraint_type 
FROM user_constraints 
WHERE table_name = 'EMPLOYEES';
