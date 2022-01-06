/* *************** ULUSAL HASTA KAYIT VERİTABANI *****************************************
Ulusal Hasta Kayıt Platformundaki Hastaların kayıtlarının güncellenmesi istenmektedir. Bu
bağlamda sırasıyla aşağıdaki işlemleri yapınız.
**************************************************************************************** */
/*  
SORU 1 : Tablo 1’de görüldüğü gibi hastaneler adında bir tablo oluşturunuz.
- id sütunu primary key yapılmalı.
*/
-- SORU 1
create table hastaneler (
ID varchar(10) PRIMARY KEY,
ISIM varchar(50),
SEHIR varchar(20),
OZEL char(1)
);
insert into hastaneler values ('H101', 'ACI MADEM HASTANESI', 'ISTANBUL', 'Y');
insert into hastaneler values ('H102', 'HASZEKI HASTANESI', 'ISTANBUL', 'N');
insert into hastaneler values ('H103', 'MEDIKOL HASTANESI', 'IZMIR', 'Y');
insert into hastaneler values ('H104', 'NEMORYIL HASTANESI', 'ANKARA', 'Y');
-- SORU 2
create table HASTALAR(
KIMLIK_NO VARCHAR(11) PRIMARY KEY,
ISIM varchar(50),
TESHIS varchar(20)
);
insert into HASTALAR values ('12345678901', 'Ali Can', 'Gizli Seker');
insert into HASTALAR values ('45678901121', 'Ayse Yilmaz', 'Hipertansiyon');
insert into HASTALAR values ('78901123451', 'Steve Job', 'Pankreatit');
insert into HASTALAR values ('12344321251', 'Tom Hanks', 'COVID 19');
-- SORU 3
create table BOLUMLER(
BOLUM_ID VARCHAR(4) PRIMARY KEY,
BOLUM_ADI varchar(20)
);
insert into BOLUMLER values ('DHL', 'Dahiliye');
insert into BOLUMLER values ('KBB', 'Kulak-Burun-Bogaz');
insert into BOLUMLER values ('NRJ', 'Noroloji');
insert into BOLUMLER values ('GAST', 'Gosatroloji');
insert into BOLUMLER values ('KARD', 'Kardiyoloji');
insert into BOLUMLER values ('PSK', 'Psikoloji');
insert into BOLUMLER values ('GOZ', 'Goz Hastaliklari');
-- SORU 4
create table hasta_kayitlar (
KIMLIK_NO varchar(11) primary key,
HAST_ISIM VARCHAR(50),
HASTANE_ADI VARCHAR(50),
BOLUM_ADI VARCHAR(30),
TESHIS VARCHAR(30)
);
INSERT INTO hasta_kayitlar VALUES ('1111', 'NONAME', NULL, NULL, NULL);
INSERT INTO hasta_kayitlar VALUES ('2222', 'NONAME', NULL, NULL, NULL);
INSERT INTO hasta_kayitlar VALUES ('3333', 'NONAME', NULL, NULL, NULL);
select*FROM HASTANELER;
select*FROM HASTALAR;
select*FROM hasta_kayitlar;
/* SORU 5 --> hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
            hasta_isim : ‘Salvadore Dali’ ismi ile
            hastane_adi: ‘John Hopins’
            bolum_adi: ‘Noroloji’
            teshis: ‘Parkinson’
            kimlik_no: ‘99991111222’
*/
Update hasta_kayitlar
set HAST_ISIM='Salvadore Dali', 
    HASTANE_ADI='John Hopins', 
    BOLUM_ADI='Noroloji', 
    TESHIS='Parkinson', 
    KIMLIK_NO='99991111222' 
WHERE KIMLIK_NO='3333';
select*FROM hasta_kayitlar;
/* SORU 6 -->  hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
            hasta_isim : hastalar tablosundaki ‘Ali Can’ ismi ile
            hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
            bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
            teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
            kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/
update hasta_kayitlar
set HAST_ISIM=( select ISIM from hastalar where ISIM= 'Ali Can'), 
    HASTANE_ADI=( select ISIM from hastaneler where ID= 'H104'), 
    BOLUM_ADI=( select BOLUM_ADI from bolumler where BOLUM_ID= 'DHL'), 
    TESHIS=( select TESHIS from hastalar where ISIM= 'Ali Can'),
    KIMLIK_NO=( select KIMLIK_NO from hastalar where ISIM= 'Ali Can') 
where KIMLIK_NO='1111';
select*FROM hasta_kayitlar;
/* SORU 7 --> hasta_kayıtlar tablosundaki ‘2222’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
        hasta_isim : hastalar tablosundaki ‘Ayşe Yılmaz’ ismi ile
        hastane_adi: hastaneler tablosundaki 'H103' bolum_id kodlu hastanenin ismi ile
        bolum_adi: bolumler tablosundaki ‘KBB’ bolum_id kodlu bolum_adi ile
        teshis: hastalar tablosundaki ‘Tom Hanks' isimli hastanın teshis bilgisi ile
        kimlik_no: hastalar tablosundaki 'Stevev Job' isimli hastanın kimlik_no kodu ile
*/
update hasta_kayitlar
set HAST_ISIM=( select ISIM from hastalar where ISIM= 'Ayse Yilmaz'), 
    HASTANE_ADI=( select ISIM from hastaneler where ID= 'H103'), 
    BOLUM_ADI=( select BOLUM_ADI from bolumler where BOLUM_ID= 'KBB'), 
    TESHIS=( select TESHIS from hastalar where ISIM= 'Tom Hanks'),
    KIMLIK_NO=( select KIMLIK_NO from hastalar where ISIM= 'Steve Job')
where KIMLIK_NO='2222';
select*FROM hasta_kayitlar;