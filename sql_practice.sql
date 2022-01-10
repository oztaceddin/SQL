use sys;

CREATE TABLE people 
(
    ssn CHAR (9),
    name VARCHAR(50),
    address VARCHAR(80)
);

INSERT INTO PEOPLE VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO PEOPLE VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO PEOPLE VALUES (345678901, 'Marry Tien', 'New Jersey');
INSERT INTO PEOPLE (ssn, address) VALUES (456789012, 'Michigan');
INSERT INTO PEOPLE (ssn, address) VALUES (567890123, 'California');
INSERT INTO PEOPLE (ssn, name) VALUES (567890123, 'California');
SELECT * FROM PEOPLE ;



-- Boş adları "ad daha sonra eklenecek" olarak değiştirin

update people
set name='isimler daha sonra eklenecek'
where name is null;





-- Boş adresleri 'Adres daha sonra eklenecek' olarak değiştirin

update people
set address='adres daha sonra eklenecek'
where address is null;



-- people tablosunda 'Daha sonra eklenecek' tüm boş değerleri değiştirin

update people

set name=coalesce(name,'daha sonra eklenecek');




-- Create işçi tablosu alanları worker_id,work_name,work_salary şeklindedir.
-- worker_id, worker_id_pk adında primary key sahip olacak
-- İşçiler tablosuna 4 kayıt ekleyin
-- Konsoldaki tabloya bakın




CREATE TABLE worker 
(
    worker_id char(3),
    worker_name VARCHAR(50),
    worker_salary int not null,
     CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)
);

INSERT INTO WORKER VALUES ('100','Ali can', 1200);
INSERT INTO WORKER VALUES ('102','Veli Han', 2000);
INSERT INTO WORKER VALUES ('103','Ayse Kan', 7000);
INSERT INTO WORKER VALUES ('104', 'Angie Ocean', 8500);
SELECT * FROM WORKER ;


-- enyüksek maaşın yüzde 20 oranında azaltarak velihanın maaşı olarak update edin
UPDATE WORKER 
SET 
    worker_salary = (SELECT 
            MAX(worker_salary)
        FROM
            (SELECT 
                *
            FROM
                WORKER) AS W) - ((SELECT 
            MAX(worker_salary)
        FROM
            (SELECT 
                *
            FROM
                WORKER) AS V) * 0.20)
WHERE
    worker_name = 'Veli Han';





UPDATE worker 
SET 
    worker_salary = (SELECT 
            MAX(worker_salary)
        FROM
            (SELECT 
                worker_salary
            FROM
                worker) wr) * 0.8
WHERE
    worker_name = 'veli han';
    

-- endüşük maaşı yüzde 30 arttırın ve alı can mevcut maaşıyla update edin 



UPDATE WORKER 
SET 
    worker_salary = (SELECT 
            MIN(worker_salary) * 1.30
        FROM
            (SELECT 
                *
            FROM
                worker) AS m)
WHERE
    worker_name = 'ali can'; 



-- Maaş ortalama maaştan düşükse maaşları 1000 artırın

UPDATE worker 
SET 
    worker_salary = (worker_salary + 1000)
WHERE
    worker_salary < (SELECT 
            AVG(worker_salary)
        FROM
            (SELECT 
                *
            FROM
                worker) AS a);



-- Maaşın ortalama maaştan az olması durumunda maaşları ortalama maaşa eşit

UPDATE worker 
SET 
    worker_salary = (SELECT 
            AVG(worker_salary)
        FROM
            (SELECT 
                *
            FROM
                worker) AS B)
WHERE
    worker_salary < (SELECT 
            AVG(worker_salary)
        FROM
            (SELECT 
                *
            FROM
                worker) AS a);
                
                
                
                -- ==================================================================
                
                



