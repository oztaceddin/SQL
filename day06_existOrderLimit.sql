use sys;

/*=========================== EXISTS, NOT EXIST ================================
   EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanımına benzer olarak,
    EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde 
   bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar. 
   
   EXISTS operatorü bir Boolean operatördür ve true - false değer döndürür. 
    EXISTS operatorü sıklıkla Subquery'lerde satırların doğruluğunu test etmek 
    için kullanılır.
    
    Eğer bir subquery (altsorgu) bir satırı döndürürse EXISTS operatörü de TRUE 
    değer döndürür. Aksi takdirde, FALSE değer döndürecektir.
    
    Özellikle altsorgularda hızlı kontrol işlemi gerçekleştirmek için kullanılır
==============================================================================*/
   
    CREATE TABLE mart
    (
        urun_id int,
        musteri_isim varchar(50), 
        urun_isim varchar(50)
    );
    
    CREATE TABLE nisan 
    (
        urun_id int ,
        musteri_isim varchar(50), 
        urun_isim varchar(50)
    );
    
  
    INSERT INTO mart VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart VALUES (20, 'John', 'Toyota');
    INSERT INTO mart VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart VALUES (10, 'Adam', 'Honda');
    INSERT INTO mart VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');
   
    INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');
    
    
    /* -----------------------------------------------------------------------------
  ORNEK1: MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID'lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/ 
 -- 1.yol
 
 select urun_id,musteri_isim from mart
 where urun_id in(select urun_id from nisan where mart.urun_id=nisan.urun_id);
 
 -- 2.yol ve daha hızlı çözüm
 
 select urun_id,musteri_isim from mart
 where exists(select urun_id from nisan where mart.urun_id=nisan.urun_id);
 
 /* -----------------------------------------------------------------------------
  ORNEK2: Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/
 
 
 select urun_isim, musteri_isim from nisan as n
    where exists (select urun_isim from mart m
                    where n.urun_isim=m.urun_isim);
 
 
 /* -----------------------------------------------------------------------------
  ORNEK3: Her iki ayda birden satılmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
  
  olumsuzzz   not exists
 -----------------------------------------------------------------------------*/
 
 
 select urun_isim, musteri_isim from nisan as n
    where not exists (select urun_isim from mart m
                    where n.urun_isim=m.urun_isim);
                    
                    
	/*===================== IS NULL, IS NOT NULL, COALESCE ========================
    
    IS NULL, ve IS NOT NULL, BOOLEAN operatörleridir. Bir ifadenin NULL olup 
    olmadığını kontrol ederler.  
    
    COALESCE ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan
    ilk ifadeyi döndürür. Eğer aldığı tüm ifadeler NULL ise NULL döndürürür.
    
    sutun_adi = COALESCE(ifade1, ifade2, .....ifadeN)
    
==============================================================================*/

    CREATE TABLE insanlar 
    (
        ssn CHAR(9), -- Social Security Number
        isim VARCHAR(50), 
        adres VARCHAR(50) 
    );

    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (ssn) VALUES('999111222');
 
 
 -- örnek 1= isim i null olanları sorgulayınız?
 
 select * from insanlar 
 where isim is null;
 
  -- örnek 2= isim i null olmayanları sorgulayınız?
 
 select * from insanlar 
 where isim is not null;
 
 
 /* ----------------------------------------------------------------------------
  ORNEK3: isim 'i NULL olan kişilerin isim'ine NO NAME atayınız. kisa soruda eski yolla olur
--------------------------------------------------------------------------*/
 
 
   UPDATE insanlar
   SET isim ='NO NAME'
   WHERE isim IS NULL;
   
   select * from insanlar;
   
  -- ----------------------------------------------------------------------------- 
   -- örnek 4= tabloyu eski haline geri getir no name yazanları geri null yazdır
 -- -----------------------------------------------------------------------------  
   update insanlar set isim=null where isim='no name';
 
 
 /* ----------------------------------------------------------------------------
  ORNEK4:   isim 'i NULL olanlara 'Henuz isim girilmedi'
            adres 'i NULL olanlara 'Henuz adres girilmedi'
            ssn 'i NULL olanlara ' no ssn' atayalım.
            çoklu değişimde ve  WHERE isim IS NULL or adres is null....; 
            gibi ifade yazmamak için. coalesce=birleşmek
-----------------------------------------------------------------------------*/

    update insanlar
set isim=coalesce(isim,'Henuz girilmedi'),
    adres=coalesce(adres,'Henuz adres girilmedi'),
    ssn=coalesce(ssn,'No SSN');
     select * from insanlar;



/*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN'a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
==============================================================================*/       
    CREATE TABLE kisiler 
    (   id int PRIMARY KEY,
        ssn CHAR(9) ,
        isim VARCHAR(50), 
        soyisim VARCHAR(50), 
        maas int,
        adres VARCHAR(50) 
    );
    
    INSERT INTO kisiler VALUES(1,123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(2,234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(3,345678901, 'Mine','Bulut',4200,'Adiyaman');
    INSERT INTO kisiler VALUES(4,256789012, 'Mahmut','Bulut',3150,'Adana');
    INSERT INTO kisiler VALUES (5,344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (6,345458901, 'Veli','Yilmaz',7000,'Istanbul');

    INSERT INTO kisiler VALUES(7,123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(8,234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(9,345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kisiler VALUES(10,256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kisiler VALUES (11,344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (12,345458901, 'Veli','Yilmaz',7000,'Istanbul');
    
    
    
/* ----------------------------------------------------------------------------
         ORNEK1: kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/

select * from kisiler
order by adres;

 
 
 /* ----------------------------------------------------------------------------
         ORNEK2: kisiler tablosunu maaşa'e göre ters sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/
 
 select * from kisiler
order by maas desc; --  büyükten küçüge sıralamaa


/* ----------------------------------------------------------------------------
  ORNEK4: ismi Mine olanları, maas'e göre AZALAN sırada sorgulayınız.
-----------------------------------------------------------------------------*/

select * from kisiler
where isim='mine'
order by maas desc;
    
/* ----------------------------------------------------------------------------
  ORNEK5: soyismi 'i Bulut olanları maas sıralı olarak sorgulayınız.
-----------------------------------------------------------------------------*/
 
 select * from kisiler
where soyisim='bulut'
order by maas desc;

-- 2.yol
 
 select * from kisiler
where soyisim='bulut'
order by 5 ; --   sütun belirterekte yazdıra bilirizzzzzzz


-- ****************************** LİMİT   ********************************
 
 -- örnek1= listeden ilk 10 veriyi getir
 
 select * from kisiler
 limit 10;
 
 -- örnek1= listeden 10. veriden sonraki 2 veriyi getir 
 
 select * from kisiler
 limit 10,2; -- ilk sayı dahil değil 10 dan sonra ki 2 tane
 
 -- 2.yol
 select * from kisiler
 where id>10;  -- sonraki rakam sayısını kısıtlamak istersekte limit X kısıtlama sayısı
 
 
/* ----------------------------------------------------------------------------
  ORNEK1: MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyen sorguyu yazınız.
-----------------------------------------------------------------------------*/    

select * from kisiler
order by maas desc limit 3; -- önce büyükten küçüğe sıralayıp sonra ilk 3 ü aldık


/*-- orakle ile çözüm
select * from kisiler
order by maas desc
fetch next 3 rows only;*/

/* ----------------------------------------------------------------------------
  ORNEK2: MAAŞ'a göre sıralamada 4. 5.  6. kişilerin bilgilerini listeleyen 
  sorguyu yazınız.
-----------------------------------------------------------------------------*/ 

select * from kisiler
order by maas  limit 3,3;




