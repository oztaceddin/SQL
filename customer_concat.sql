

-- concat


create table customer (
musteri_no int,
ad VARCHAR(22),
soyad VARCHAR(25),
sehir varchar(45),
cinsiyet varchar(15),
puan int
);
INSERT INTO customer VALUES(111,'ebru', 'akar','denizli','kadin',78);
INSERT INTO customer VALUES(222,'ayse', 'kara','ankara','kadin',90);
INSERT INTO customer VALUES(333,'ali','gel','istanbul','erkek',66);
INSERT INTO customer VALUES(444, 'mehmet','okur','mus','erkek',98);

select concat('isim soyisim:',ad,'',soyad) isim_soyisim from customer;

SELECT 
    CONCAT(musteri_no, '.', ad, '', soyad) ad_soyad,
    sehir,
    cinsiyet,
    puan
FROM
    customer
ORDER BY musteri_no;
