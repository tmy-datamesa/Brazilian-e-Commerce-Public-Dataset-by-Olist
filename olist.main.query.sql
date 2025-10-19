/** OLIST SORGUSU **/
-- VERİ KÜMESİNDE NULL VE YİNELENEN (DUPLICATE) DEĞERLERİ BULMA
-- 1) Olist veri setindeki her tabloda NULL ve duplicate değer kontrolü
-- Ai) CUSTOMERS TABLOSUNDA NULL DEĞERLER 
SELECT 'customer_id' AS column_name, COUNT(*) AS number_of_nulls
FROM olist.olist_customers_dataset
WHERE   customer_id IS NULL
UNION ALL
SELECT 'customer_unique_id', COUNT(*)
FROM olist.olist_customers_dataset
where   customer_unique_id IS NULL
UNION ALL
SELECT 'customer_zip_code_prefix', COUNT(*)
FROM olist.olist_customers_dataset
WHERE   customer_zip_code_prefix IS NULL
UNION ALL
SELECT 'customer_city', COUNT(*)
FROM olist.olist_customers_dataset
WHERE   customer_city IS NULL
UNION ALL
SELECT 'customer_state', COUNT(*)
FROM olist.olist_customers_dataset
WHERE   customer_state IS NULL;

-- Aii) CUSTOMERS TABLOSUNDA DUPLICATE (YİNELENEN) DEĞERLER
SELECT  customer_id, customer_unique_id, customer_zip_code_prefix,
        customer_city,
        customer_state,
        COUNT(*) AS number_of_duplicates
FROM olist.olist_customers_dataset
GROUP BY    customer_id, customer_unique_id, customer_zip_code_prefix,
            customer_city, customer_state
HAVING COUNT(*) > 1;
/** customers tablosunda duplicate ve null yok **/
-------------------------------------------------------------------------------------

-- Bi) GEOLOCATION TABLOSUNDA NULL DEĞERLER

SELECT 'geolocation_zip_code_prefix' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
where geolocation_zip_code_prefix is null

UNION ALL

SELECT 'geolocation_lat' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
where geolocation_lat is null

UNION ALL

SELECT 'geolocation_lng' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
where geolocation_lng is null

UNION ALL

SELECT 'geolocation_city' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
where geolocation_city is null

UNION ALL

SELECT 'geolocation_state' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
where geolocation_state is null;


-- Bii) GEOLOCATION TABLOSUNDA DUPLICATE DEĞERLER

SELECT geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state, COUNT(*) AS number_of_dublicates
from `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
group by geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state
having count(*)>1;


-- Çok sayıda duplicate olduğundan, şunları kaldırabiliriz 


-- biii) geolocation duplicate’larını kaldırma ve bunu bir "CTE" (new_geolocation) olarak saklama

WITH new_geolocation AS 
(
SELECT  DISTINCT geolocation_zip_code_prefix, geolocation_lat,
        geolocation_lng, geolocation_city,
        geolocation_state
FROM `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
ORDER BY geolocation_zip_code_prefix
)

SELECT *
FROM new_geolocation;


-- Ei) SELLERS TABLOSUNDA NULL DEĞERLER

select 'seller_id' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_sellers_dataset`
where seller_id is null

union all

select 'seller_zip_code_prefix' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_sellers_dataset`
where seller_zip_code_prefix is null

union all

select 'seller_city' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_sellers_dataset`
where seller_city is null

union all

select 'seller_state' as column_name, count(*) as number_of_nulls
from `pacific-legend-474020-b4.olist.olist_sellers_dataset`
where seller_city is null;

-- Eii) SELLERS TABLOSUNDA DUPLICATE DEĞERLER

SELECT  seller_id, seller_zip_code_prefix, seller_city, seller_state,
        COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.olist_sellers_dataset`
GROUP BY seller_id, seller_zip_code_prefix, seller_city, seller_state
HAVING COUNT(*) > 1;

/** SELLERS TABLOSUNDA null veya duplicate yok **/
----------------------------------------------------------------------------------


-- Fi) PRODUCTS TABLOSUNDA NULL DEĞERLER

SELECT 'product_id' AS column_name, COUNT(*) AS number_of_nulls
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_id IS NULL 

UNION ALL

SELECT 'product_category_name', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_category_name IS NULL

UNION ALL

SELECT 'product_name_lenght', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_name_lenght IS NULL

UNION ALL

SELECT 'product_description_lenght', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_description_lenght IS NULL

UNION ALL

SELECT 'product_photos_qty', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_photos_qty IS NULL

UNION ALL

SELECT 'product_weight_g', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_weight_g IS NULL

UNION ALL

SELECT 'product_length_cm', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_length_cm IS NULL

UNION ALL

SELECT 'product_height_cm', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_height_cm IS NULL

UNION ALL

SELECT 'product_width_cm', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
WHERE product_width_cm IS NULL

ORDER BY number_of_nulls DESC;

/** 32951 ürünün 610’unda kategori yok.*/

-- Fii) PRODUCTS TABLOSUNDA DUPLICATE DEĞERLER

SELECT  product_id, product_category_name, product_name_lenght,
        product_description_lenght, product_photos_qty,
        product_weight_g, product_length_cm, product_height_cm,
        product_width_cm, COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.olist_products_dataset`
GROUP BY product_id, product_category_name, product_name_lenght,
        product_description_lenght, product_photos_qty,
        product_weight_g, product_length_cm, product_height_cm,
        product_width_cm
HAVING COUNT(*) > 1;

/** Tüm ürünler benzersiz; duplicate ürün yok. **/
--------------------------------------------------------------------------

-- Gi) ORDERS TABLOSUNDA NULL DEĞERLER


SELECT 'order_id' AS column_name, COUNT(*) AS number_of_nulls
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_id IS NULL 

UNION ALL

SELECT 'customer_id', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE customer_id IS NULL

UNION ALL

SELECT 'order_status', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_status IS NULL

UNION ALL

SELECT 'order_purchase_timestamp', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_purchase_timestamp IS NULL

UNION ALL

SELECT 'order_approved_at', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_approved_at IS NULL

UNION ALL

SELECT 'order_delivered_carrier_date', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_delivered_carrier_date IS NULL

UNION ALL

SELECT 'order_delivered_customer_date', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_delivered_customer_date IS NULL

UNION ALL

SELECT 'order_estimated_delivery_date', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_estimated_delivery_date IS NULL

ORDER BY number_of_nulls DESC;

/** 3 sütunda anlamlı miktarda NULL var (order_delivered_customer_date, order_delivered_carrier_date, order_approved_at) **/

-- Gii) ORDERS TABLOSUNDA DUPLICATE DEĞERLER

SELECT  order_id, customer_id, order_status,
        order_purchase_timestamp, order_approved_at,
        order_delivered_carrier_date, order_delivered_customer_date,
        order_estimated_delivery_date,
        COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
GROUP BY order_id, customer_id, order_status,
        order_purchase_timestamp, order_approved_at,
        order_delivered_carrier_date, order_delivered_customer_date,
        order_estimated_delivery_date
HAVING COUNT(*) > 1;

/** Bu tabloda duplicate ORDER yok **/
-------------------------------------------

-- Hi) ORDER_ITEMS TABLOSUNDA NULL DEĞERLER

SELECT 'order_id' AS column_name, COUNT(*) AS number_of_nulls
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE order_id IS NULL 

UNION ALL

SELECT 'order_item_id', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE order_item_id IS NULL

UNION ALL

SELECT 'product_id', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE product_id IS NULL

UNION ALL

SELECT 'seller_id', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE seller_id IS NULL

UNION ALL

SELECT 'shipping_limit_date', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE shipping_limit_date IS NULL

UNION ALL

SELECT 'price', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE price IS NULL

UNION ALL

SELECT 'freight_value', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
WHERE freight_value IS NULL
ORDER BY number_of_nulls;

/** order_items tablosunda NULL yok **/

-- Hii) ORDER_ITEMS DUPLICATE’LAR

SELECT  order_id, order_item_id, product_id, seller_id,
        shipping_limit_date, price, freight_value,
        COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`
GROUP BY    order_id, order_item_id, product_id, seller_id,
            shipping_limit_date, price, freight_value
HAVING COUNT(*) > 1
ORDER BY number_of_duplicates;

/** order_items tablosunda duplicate yok **/
---------------------------------------------------------------

-- Ii) ORDER_PAYMENTS TABLOSUNDA NULL DEĞERLER

SELECT 'order_id' AS column_name, COUNT(*) AS number_of_nulls
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
WHERE order_id IS NULL 

UNION ALL

SELECT 'payment_sequential', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
WHERE payment_sequential IS NULL

UNION ALL

SELECT 'payment_type', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
WHERE payment_type IS NULL

UNION ALL

SELECT 'payment_installments', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
WHERE payment_installments IS NULL

UNION ALL

SELECT 'payment_value', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
WHERE payment_value IS NULL
ORDER BY number_of_nulls;

-- Iii) ORDER_PAYMENTS DUPLICATE’LAR

SELECT  order_id, payment_sequential, payment_type,
        payment_installments, payment_value,
        COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
GROUP BY    order_id, payment_sequential, payment_type,
            payment_installments, payment_value
HAVING COUNT(*) > 1
ORDER BY number_of_duplicates;

/** Bu tabloda null veya duplicate yok **/
-------------------------------------------------------------


-- Ji) ORDER REVIEWS TABLOSUNDA NULL DEĞERLER

SELECT 'review_id' AS column_name, COUNT(*) AS number_of_nulls
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE review_id IS NULL

UNION ALL

SELECT 'order_id', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE order_id IS NULL

UNION ALL

SELECT 'review_score', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE review_score IS NULL

UNION ALL

SELECT 'review_comment_title', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE review_comment_title IS NULL

UNION ALL

SELECT 'review_comment_message', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE review_comment_message IS NULL

UNION ALL

SELECT 'review_creation_date', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE review_creation_date IS NULL

UNION ALL

SELECT 'review_answer_timestamp', COUNT(*)
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
WHERE review_answer_timestamp IS NULL
ORDER BY number_of_nulls DESC;

/** Tüm order_id’lerde review_score var; bu ürün doğrulaması için iyi. **/

-- Jii) ORDER REVIEWS TABLOSUNDA DUPLICATE’LAR

SELECT  review_id, order_id, review_score, 
        review_comment_title, review_comment_message,
        review_creation_date, review_answer_timestamp,
        COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.olist_order_reviews_dataset`
GROUP BY    review_id, order_id, review_score,
            review_comment_title, review_comment_message,
            review_creation_date, review_answer_timestamp
HAVING COUNT(*) > 1
ORDER BY number_of_duplicates;

/** Duplicate review yok; tüm review’lar benzersiz. **/

-- Ki) PRODUCT CATEGORY NAME TRANSLATION TABLOSUNDA NULL DEĞERLER

SELECT 'product_category_name' AS column_name, COUNT(*) AS number_of_nulls
FROM `pacific-legend-474020-b4.olist.product_category_name_translation`
WHERE string_field_0 IS NULL

UNION ALL

SELECT 'product_category_name_english', COUNT(*)
FROM `pacific-legend-474020-b4.olist.product_category_name_translation`
WHERE string_field_1 IS NULL
ORDER BY number_of_nulls DESC;

-- Kii) PRODUCT CATEGORY NAME TRANSLATION TABLOSUNDA DUPLICATE’LAR

SELECT  string_field_0,
        string_field_1,
        COUNT(*) AS number_of_duplicates
FROM `pacific-legend-474020-b4.olist.product_category_name_translation`
GROUP BY    string_field_0,
        string_field_1
HAVING COUNT(*) > 1
ORDER BY number_of_duplicates;

/** Bu tabloda null veya duplicate yok. **/
-----------------------------------------------------------------

/**VERİ KÜMESİNİ TEMİZLEME**/

/** 2) GEOLOCATION TABLOSUNDAKİ ÖZEL KARAKTERLERİ TEMİZLEME (CITY SÜTUNU)

Ai) GEOLOCATION_CITY SÜTUNUNDA TESPİT EDİLEN ÖZEL KARAKTERLERİ KALDIRMA 

Brezilya geolocation_city sütununda kullanılan bazı özel alfabe karakterlerini tespit ettim: á, é, í, ó, ú, â, ê, ô, ã, õ, à ve ç

Bunlar, müşteri ve satıcı şehir sütunlarında tutarlılık için değiştirilmelidir.

--- Özel alfabe karakterlerini değiştirmek için

geolocation_city sütununu düzenlemek üzere geçici bir tablo oluşturdum. **/


WITH new_geolocation_one AS (
SELECT  DISTINCT geolocation_zip_code_prefix, geolocation_lat,
        geolocation_lng, geolocation_city,
        geolocation_state
FROM `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
)
SELECT *
FROM new_geolocation_one 
ORDER BY geolocation_zip_code_prefix;  /** NOT - TÜM DUPLICATE’LARI KALDIRMAK İÇİN **/



CREATE OR REPLACE TABLE  `pacific-legend-474020-b4.olist.real_geolocation_cleaned` AS
WITH unique_geolocation AS (
  SELECT DISTINCT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
  FROM `pacific-legend-474020-b4.olist.olist_geolocation_dataset`
),
real_geolocation_cleaned AS (
  SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    -- aksanları kaldır + küçük harfe çevir + ' ` - temizle + çoklu boşlukları tek boşluk yap
    REGEXP_REPLACE(
      REGEXP_REPLACE(
        TRANSLATE(LOWER(geolocation_city), 'áéíóúâêôãõàç', 'aeiouaeoaoac'),
        '[\'`-]',                      -- tek tırnak/apostrof, backtick, tire
        ' '
      ),
      '\\s+',
      ' '
    ) AS geolocation_city,
    geolocation_state
  FROM unique_geolocation
)
SELECT *
FROM real_geolocation_cleaned
ORDER BY geolocation_city;


/** Aii) GEOLOCATION TABLOSUNDAKİ ÖNCEKİ GEÇİCİ TABLODAN SONRA HÂLÂ BAŞKA ÖZEL KARAKTERLER VAR MI GÖRMEK İÇİN **/

SELECT *
FROM `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
WHERE REGEXP_CONTAINS(lower(geolocation_city), r'[^a-z\s]');


/** Aiv) real_geolocation_cleaned TABLOSUNDA, BAZI EYALET KISALTMALARININ GEOLOCATION_CITY SÜTUNUNDA YER ALDIĞINI (BAZI ŞEHİRLERİN İLGİLİ EYALETLERİYLE AYNI ADI TAŞIDIĞINI) DA GÖRDÜM **/


SELECT * FROM
`pacific-legend-474020-b4.olist.real_geolocation_cleaned`
WHERE   geolocation_city LIKE '%pr' OR 
        geolocation_city LIKE '%sp' OR
        geolocation_city LIKE '%mg' OR
        geolocation_city LIKE '%mt' OR
        geolocation_city LIKE '%ms' OR
        geolocation_city LIKE '%pr' OR
        geolocation_city LIKE '%sc' OR 
        LENGTH(geolocation_city) < 3
ORDER BY geolocation_city;


UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'sao paulo'
WHERE geolocation_city = 'sp';

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'rio de janeiro'
WHERE geolocation_city = 'rj';

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'belo horizonte'
WHERE geolocation_city = 'bh';

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'franca'
WHERE geolocation_zip_code_prefix = 14407;

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'guarulhos'
WHERE geolocation_zip_code_prefix = 7174;

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'lavras'
WHERE geolocation_zip_code_prefix = 37200;

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'limeira do oeste'
WHERE geolocation_zip_code_prefix = 38295;

UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = 'arraial dajuda'
WHERE 	geolocation_state = 'BA' AND
        geolocation_city LIKE '%arraial d%';


UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = TRIM(
  REPLACE(
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(geolocation_city, 'd oeste', 'doeste'),
            'd  oeste', 'doeste'),
          'd  arco', 'darco'),
        'd agua', 'dagua'),
      'd alianca', 'dalianca'),
    'd alho', 'dalho'),
  'sao joao do pau d%26apos%3balho', 'sao joao do pau dalho')
)
WHERE geolocation_city LIKE '%d oeste%'
   OR geolocation_city LIKE '%d  oeste%'
   OR geolocation_city LIKE '%d  arco%'
   OR geolocation_city LIKE '%d agua%'
   OR geolocation_city LIKE '%d alianca%'
   OR geolocation_city LIKE '%d alho%'
   OR geolocation_city LIKE '%sao joao do pau d%26apos%3balho%';


UPDATE `pacific-legend-474020-b4.olist.real_geolocation_cleaned`
SET geolocation_city = TRIM(geolocation_city)
WHERE geolocation_city != TRIM(geolocation_city);

SELECT COUNT(DISTINCT(geolocation_state)) AS total_states
FROM `pacific-legend-474020-b4.olist.real_geolocation_cleaned`;
-- TOPLAM EYALET - 27

SELECT COUNT(DISTINCT(geolocation_city)) AS total_cities
FROM `pacific-legend-474020-b4.olist.real_geolocation_cleaned`;

--TOPLAM ŞEHİR 5907


--	SELLERS TABLOSUNDA ÖZEL KARAKTERLERİ TEMİZLEME (CITY SÜTUNU)



-- A-Z ve boşluk dışında karakter kaldı mı?
SELECT *
FROM `pacific-legend-474020-b4.olist.olist_sellers_dataset`
WHERE REGEXP_CONTAINS(seller_city, r'[^a-z\s]');


-- StandardSQL
-- 1) Temiz tabloyu üret
CREATE OR REPLACE TABLE `pacific-legend-474020-b4.olist.sellers_clean` AS
SELECT
  seller_id,
  seller_zip_code_prefix,
  -- şehir temizleme: küçük harf + aksan kaldır + ' ` - temizle + çoklu boşlukları tekle + kırp
  TRIM(
    REGEXP_REPLACE(
      REGEXP_REPLACE(
        TRANSLATE(LOWER(seller_city), 'áéíóúâêôãõàç', 'aeiouaeoaoac'),
        '[\'`-]', ' '          -- tek tırnak, backtick, tire → boşluk
      ),
      r'\s+', ' '              -- çoklu boşluk → tek boşluk
    )
  ) AS seller_city,
  seller_state
FROM `pacific-legend-474020-b4.olist.olist_sellers_dataset`;


UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = 'sao paulo'
WHERE   seller_state = 'SP' AND 
        seller_city IN ('sao paulo sp', 'sp');


SELECT *
FROM `pacific-legend-474020-b4.olist.sellers_clean`
WHERE REGEXP_CONTAINS(seller_city, r'[^a-z\s]');



UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = 'rio de janeiro'
WHERE seller_city = '04482255'; 


-- 'sp', 'sao paulo sp', 'saopaulo' gibi varyasyonları düzelt
UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = 'sao paulo'
WHERE seller_state = 'SP'
  AND seller_city IN ('sp','sao paulo sp','saopaulo');

-- d + kelime düzeltmeleri (ör: "d oeste" → "doeste")
UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = REGEXP_REPLACE(seller_city, r'\bd\s+oeste\b', 'doeste')
WHERE REGEXP_CONTAINS(seller_city, r'\bd\s+oeste\b');

UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = REGEXP_REPLACE(seller_city, r'\bd\s+arco\b', 'darco')
WHERE REGEXP_CONTAINS(seller_city, r'\bd\s+arco\b');

UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = REGEXP_REPLACE(seller_city, r'\bd\s+agua\b', 'dagua')
WHERE REGEXP_CONTAINS(seller_city, r'\bd\s+agua\b');

UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = REGEXP_REPLACE(seller_city, r'\bd\s+alianca\b', 'dalianca')
WHERE REGEXP_CONTAINS(seller_city, r'\bd\s+alianca\b');

UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = REGEXP_REPLACE(seller_city, r'\bd\s+alho\b', 'dalho')
WHERE REGEXP_CONTAINS(seller_city, r'\bd\s+alho\b');

-- son temizlik: kalan çift boşlukları tekle + kırp
UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = TRIM(REGEXP_REPLACE(seller_city, r'\s+', ' '))
WHERE seller_city != TRIM(REGEXP_REPLACE(seller_city, r'\s+', ' '));

UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = TRIM(REGEXP_REPLACE(seller_city, r'\s*[/\\,]\s*.*$', ''))
WHERE REGEXP_CONTAINS(seller_city, r'[/\\,]');

-- sbc → sao bernardo do campo (senin önceki tercihine göre 'sbcampo')
UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = 'sbcampo'
WHERE LOWER(seller_city) IN ('sbc', 'sbc/sp', 'sbc sp');

-- Eğer mail yakalarsan (örnek: vendas@creditparts.com.br), PR eyaleti ise maringa yap
UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = 'maringa'
WHERE seller_city LIKE '%@%' AND seller_state = 'PR';


UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = TRIM(
  REGEXP_REPLACE(
    REGEXP_REPLACE(
      TRANSLATE(LOWER(seller_city), 'áéíóúâêôãõàç', 'aeiouaeoaoac'),
      r'[\'`.\-]', ' '
    ),
    r'\s+', ' '
  )
)
WHERE TRUE;

SELECT seller_city, seller_state
FROM `pacific-legend-474020-b4.olist.sellers_clean`
WHERE REGEXP_CONTAINS(seller_city, r'[^a-z\s]');



-- StandardSQL
UPDATE `pacific-legend-474020-b4.olist.sellers_clean`
SET seller_city = TRIM(
  REGEXP_REPLACE(                                  -- çoklu boşluk → tek
    TRANSLATE(                                     -- aksanları sil
      REGEXP_REPLACE(                              -- 3) d + ayraç + (oeste|ajuda) düzelt
        REGEXP_REPLACE(                            -- 2) parantez içini kaldır
          LOWER(seller_city),                      -- 1) küçük harf
          '\\s*\\([^)]*\\)\\s*', ''               -- (...) → (boş)
        ),
        '\\bd\\W*\\s*oeste\\b', 'doeste'          -- d’/d`/d' / d  + oeste → doeste
      ),
      'áéíóúâêôãõàç', 'aeiouaeoaoac'              -- aksanlar
    ),
    '\\s+', ' '                                    -- çoklu boşluk → tek
  )
)
WHERE
  REGEXP_CONTAINS(seller_city, '\\([^)]*\\)')              -- parantez varsa
  OR REGEXP_CONTAINS(LOWER(seller_city), '\\bd\\W*\\s*oeste\\b')
  OR REGEXP_CONTAINS(LOWER(seller_city), '\\bd\\W*\\s*ajuda\\b')
  OR REGEXP_CONTAINS(seller_city, '[áéíóúâêôãõàç]');      -- aksanlı harf varsa


/** Biii) SELLERS TABLOSUNDA DA BAZI EYALET KISALTMALARININ SELLER_CITY SÜTUNUNDA YER ALDIĞINI (BAZI ŞEHİRLERİN İLGİLİ EYALETLERLE AYNI ADI TAŞIDIĞINI) FARK ETTİM **/

select count(distinct (seller_state)) as total_states
from `pacific-legend-474020-b4.olist.sellers_clean`;
-- TOPLAM SATICI EYALETİ - 23

SELECT COUNT(DISTINCT(seller_city)) AS total_cities
FROM `pacific-legend-474020-b4.olist.sellers_clean`;
-- TOPLAM SATICI ŞEHRİ -589

--CUSTOMERS TABLOSUNDA ÖZEL KARAKTERLERİ TEMİZLEME (CITY SÜTUNU)


-- a–z ve boşluk dışında karakter kaldı mı?
SELECT customer_city, customer_state
FROM `pacific-legend-474020-b4.olist.olist_customers_dataset`
WHERE REGEXP_CONTAINS(customer_city, r'[^a-z\s]');

-- StandardSQL
CREATE OR REPLACE TABLE `pacific-legend-474020-b4.olist.customers_clean` AS
SELECT
  customer_id,
  customer_unique_id,
  customer_zip_code_prefix,
  TRIM(
    REGEXP_REPLACE(                         -- çoklu boşluk → tek
      REGEXP_REPLACE(                       -- ' ` . , - / → boşluk
        TRANSLATE(LOWER(customer_city),     -- küçük harf + aksanları sil
                  'áéíóúâêôãõàç',
                  'aeiouaeoaoac'),
        r'[\'`.,/\-]', ' '
      ),
      r'\s+', ' '
    )
  ) AS customer_city,
  customer_state
FROM `pacific-legend-474020-b4.olist.olist_customers_dataset`;

SELECT customer_city, customer_state
FROM `pacific-legend-474020-b4.olist.customers_clean`
WHERE REGEXP_CONTAINS(customer_city, r'[^a-z\s]');


UPDATE `pacific-legend-474020-b4.olist.customers_clean`
SET customer_city = 'mutum'
WHERE customer_city = 'quilometro 14 do mutum' AND customer_state = 'ES';


select count(distinct customer_city) as total_cities
from `pacific-legend-474020-b4.olist.customers_clean`;

select count(distinct (customer_state)) as total_states
from `pacific-legend-474020-b4.olist.customers_clean`;



--EN ÇOK SİPARİŞE SAHİP İLK 5 MÜŞTERİ EYALETİ
SELECT c.customer_state, count(*) AS number_of_orders
FROM `pacific-legend-474020-b4.olist.customers_clean` as c 
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o ON
o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY number_of_orders DESC
limit 5;
-- CEVAP - SP(41746), RJ(12852), MG(11635), RS(5466), PR(5045)


--EN AZ SİPARİŞE SAHİP İLK 5 MÜŞTERİ EYALETİ
SELECT c.customer_state, count(*) AS number_of_orders
FROM `pacific-legend-474020-b4.olist.customers_clean` as c 
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o ON
o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY number_of_orders asc
limit 5;
-- CEVAP - RR(46), AP(68), AC(81), AM(148), RO(253)

--EN ÇOK SİPARİŞE SAHİP İLK 10 MÜŞTERİ ŞEHRİ
select
c.customer_city,
count(*) as number_of_orders
FROM `pacific-legend-474020-b4.olist.customers_clean` as c 
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o ON
o.customer_id = c.customer_id
group by c.customer_city
order by number_of_orders desc
limit 10;

--EN AZ SİPARİŞE SAHİP MÜŞTERİ ŞEHİRLERİ
select
c.customer_city,
count(*) as number_of_orders
FROM `pacific-legend-474020-b4.olist.customers_clean` as c 
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o ON
o.customer_id = c.customer_id
group by c.customer_city
having number_of_orders<500;
--4412 şehrin 4090'nunda müşteri sipariş sayısı 500'ün altında


--SİPARİŞ RAPORU

--Toplam benzersiz sipariş sayısı 99441
SELECT
count(*) as number_of_orders
from `pacific-legend-474020-b4.olist.olist_orders_dataset`;


-- Başarıyla teslim edilen (delivered) benzersiz sipariş sayısı 96478
SELECT COUNT(DISTINCT order_id) AS delivered_unique_orders
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_status = 'delivered';

-- Teslim EDİLMEYEN siparişlerin durum kırılımı
SELECT
  order_status,
  COUNT(*) AS process_count
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
WHERE order_status != 'delivered'
GROUP BY order_status
ORDER BY process_count DESC;


--GÜNLÜK SİPARİŞ

-- Günlük sipariş adedi (en çok sipariş alınan günler en üstte)
SELECT
  DATE(order_purchase_timestamp) AS time_ordered,
  COUNT(*) AS no_of_orders_daily
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
GROUP BY time_ordered
ORDER BY no_of_orders_daily DESC;

/** CEVAP - 2017 Kasım’da büyük bir sipariş sıçraması vardı; bunun nedeni insanların Noel için bir ay önceden hazırlık yapması olabilir. En yüksek sipariş 24 Kasım’da (1176). **/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # ANALİZ VE İŞ İÇGÖRÜLERİ
-- Olist'in e-ticaret platformu için içgörü üretmek ve büyüme fırsatlarını optimize etmek amacıyla şu soruları yanıtlıyoruz:
-- 1) Toplam gelir nedir? Zaman içindeki değişimi nasıldır?
-- 2) Toplam sipariş sayısı nedir? Aylık/mevsimsel değişim nasıldır?
-- 3) En popüler ürün kategorileri hangileridir? Satış hacimleri nasıl karşılaştırılır?
-- 4) Ortalama sipariş değeri (AOV) nedir? Kategori/ödeme tipine göre nasıl değişir?
-- 5) Kaç aktif satıcı vardır? Zaman içindeki değişimi nasıldır?
-- 6) Satıcı puanlarının dağılımı nedir? Satış performansına etkisi nedir?
-- 7) Tekrar alım yapan müşteri sayısı ve gelir payı nedir?
-- 8) Ürünlerin ortalama müşteri puanı (rating) nedir? Satışa etkisi nedir?
-- 9) Ortalama sipariş iptal oranı nedir? Performansa etkisi nedir?
-- 10) En çok satan ürünler nelerdir? Trendleri zaman içinde nasıl değişir?
-- 11) En sık kullanılan ödeme yöntemleri nelerdir? Kategori/konuma göre nasıl farklılaşır?
-- 13) Hangi kategoriler en yüksek kâr marjına sahiptir? Kârlılık nasıl artırılabilir?
-- 15) Yüksek müşteri yoğunluklu konumlar nelerdir? Bu konumlarda retention nasıl?

-- ## 1) Toplam gelir ve zaman içindeki değişim

-- Toplam gelir (yalnızca teslim edilen siparişler) → 15419773.749999616
SELECT
  SUM(oi.price + oi.freight_value) AS total_revenue
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset` o
JOIN `pacific-legend-474020-b4.olist.olist_order_items_dataset` oi USING(order_id)
WHERE o.order_status = 'delivered';

-- Toplam gelir (ödenen tutarların toplamı) → 15862973.819999663
SELECT
  SUM(op.payment_value) AS total_revenue_payments
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset` op
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` o
  USING (order_id)
WHERE o.order_approved_at IS NOT NULL           -- Ödeme onayı var
  AND o.order_status <> 'canceled';             -- İptaller hariç

-- Aylık ciro (ödemeye göre)
SELECT
  DATE_TRUNC(DATE(o.order_purchase_timestamp), MONTH) AS year_month,
  round(SUM(op.payment_value),2) AS total_revenue
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset` as op
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o
  USING (order_id)
WHERE o.order_approved_at IS NOT NULL
  AND o.order_status <> 'canceled'
GROUP BY year_month
ORDER BY year_month;

-- Çeyreklik ciro (ödemeye göre)
SELECT
  DATE_TRUNC(DATE(o.order_purchase_timestamp), QUARTER) AS year_quarter,
  round(SUM(op.payment_value),2) AS total_revenue
FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset` op
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` o
  USING (order_id)
WHERE o.order_approved_at IS NOT NULL
  AND o.order_status <> 'canceled'
GROUP BY year_quarter
ORDER BY year_quarter;

-- ## 2) Toplam sipariş sayısı ve dönemsel değişim

select count(distinct order_id) as total_orders
from`pacific-legend-474020-b4.olist.olist_orders_dataset`;

-- Aylık zaman serisi (trend)
select 
date_trunc(date(order_purchase_timestamp),MONTH) AS month,
count(order_id) as nb_of_orders
from `pacific-legend-474020-b4.olist.olist_orders_dataset`
group by month
order by month;

-- Ay bazında mevsimsellik (yıllardan bağımsız)
SELECT
  EXTRACT(MONTH FROM DATE(order_purchase_timestamp)) AS month_no,
  FORMAT_DATE('%B', DATE_TRUNC(DATE(order_purchase_timestamp), MONTH)) AS month_name,
  COUNT(*) AS orders
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
GROUP BY month_no, month_name
ORDER BY month_no;

-- Çeyrek (Q1–Q4) kırılımında sipariş trendi
SELECT
  DATE_TRUNC(DATE(order_purchase_timestamp), QUARTER) AS quarter_start,
  EXTRACT(YEAR   FROM DATE(order_purchase_timestamp)) AS yr,
  EXTRACT(QUARTER FROM DATE(order_purchase_timestamp)) AS qtr,
  COUNT(*) AS orders
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
GROUP BY quarter_start, yr, qtr
ORDER BY quarter_start;

-- Haftalık sipariş trendi (ISO haftası)
SELECT
  EXTRACT(YEAR FROM DATE(order_purchase_timestamp)) AS yr,
  EXTRACT(ISOWEEK FROM DATE(order_purchase_timestamp)) AS iso_week,
  DATE_TRUNC(DATE(order_purchase_timestamp), ISOYEAR) AS iso_year_start,
  COUNT(*) AS orders
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`
GROUP BY yr, iso_week, iso_year_start
ORDER BY yr, iso_week;

-- ## 3) Popüler kategoriler ve satış hacimleri

-- Kategori bazında sipariş sayısı + (payments) toplam ciro
SELECT
  COALESCE(pc.string_field_1, 'unknown_category') AS category, 
  COUNT( o.order_id) AS num_of_orders,
  SUM(pa.payment_value) AS total_revenue
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset` as o
JOIN `pacific-legend-474020-b4.olist.olist_order_items_dataset`  as  oi USING (order_id)
JOIN `pacific-legend-474020-b4.olist.olist_products_dataset` as  p  USING (product_id)
LEFT JOIN `pacific-legend-474020-b4.olist.product_category_name_translation` pc
       ON LOWER(p.product_category_name) = LOWER(pc.string_field_0)  
JOIN `pacific-legend-474020-b4.olist.olist_order_payments_dataset`  as  pa USING (order_id)
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY num_of_orders DESC;

-- ## 4) Ortalama sipariş değeri (AOV) – kategori/ödeme tipine göre

-- Ürün kategorisine göre AOV
SELECT
  COALESCE(pc.string_field_1, 'unknown_category') AS category,
  (SUM(pa.payment_value) / COUNT(o.order_id))     AS avg_order_val
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset` as o
JOIN `pacific-legend-474020-b4.olist.olist_order_payments_dataset`as pa
  ON o.order_id = pa.order_id
JOIN `pacific-legend-474020-b4.olist.olist_order_items_dataset`as oi
  ON o.order_id = oi.order_id
JOIN `pacific-legend-474020-b4.olist.olist_products_dataset` as p
  ON oi.product_id = p.product_id
LEFT JOIN `pacific-legend-474020-b4.olist.product_category_name_translation` pc
  ON LOWER(p.product_category_name) = LOWER(pc.string_field_0)
GROUP BY category
ORDER BY avg_order_val DESC;

-- Ödeme yöntemine göre AOV
SELECT DISTINCT
  pa.payment_type,
  (SUM(pa.payment_value) / COUNT(o.order_id)) AS avg_order_val
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`as o
JOIN `pacific-legend-474020-b4.olist.olist_order_payments_dataset` as pa
  ON o.order_id = pa.order_id
JOIN `pacific-legend-474020-b4.olist.olist_order_items_dataset`as oi
  ON o.order_id = oi.order_id
GROUP BY pa.payment_type
ORDER BY avg_order_val DESC;

-- ## 5) Aktif satıcı sayısı ve zaman içi değişim

-- Minimum 3 ay aktif olan satıcılar
WITH seller_stats AS (
  SELECT
    oi.seller_id,
    COUNT(DISTINCT o.order_id)            AS num_orders,
    MIN(DATE(o.order_purchase_timestamp)) AS start_date,   -- DATE
    MAX(DATE(o.order_purchase_timestamp)) AS end_date,     -- DATE
    COUNT(DISTINCT oi.product_id)         AS num_products_listed,
    SUM(oi.price + oi.freight_value)      AS total_rev
  FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset` oi
  JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset`      o USING (order_id)
  WHERE o.order_status <> 'canceled'
  GROUP BY oi.seller_id
)
SELECT COUNT(*) AS active_sellers_3m
FROM seller_stats
WHERE DATE_DIFF(end_date, start_date, MONTH) >= 3;

-- Minimum 6 ay aktif olan satıcılar
WITH seller_stats AS (
  SELECT
    oi.seller_id,
    COUNT(DISTINCT o.order_id)            AS num_orders,
    MIN(DATE(o.order_purchase_timestamp)) AS start_date,   
    MAX(DATE(o.order_purchase_timestamp)) AS end_date,   
    COUNT(DISTINCT oi.product_id)         AS num_products_listed,
    SUM(oi.price + oi.freight_value)      AS total_rev
  FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset` oi
  JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset`      o USING (order_id)
  WHERE o.order_status <> 'canceled'
  GROUP BY oi.seller_id
)
SELECT COUNT(*) AS active_sellers_3m
FROM seller_stats
WHERE DATE_DIFF(end_date, start_date, MONTH) >= 6;

-- Yıllık aktif satıcı (min. 3 ay aktivite)
SELECT
  EXTRACT(YEAR FROM DATE(o.order_approved_at)) AS year,
  COUNT(DISTINCT s.seller_id)                  AS active_sellers,
  MIN(o.order_purchase_timestamp)              AS start_date,
  MAX(o.order_purchase_timestamp)              AS end_date,
  COUNT(DISTINCT pr.product_id)                AS num_products_listd
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset` as oi
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o
  ON oi.order_id = o.order_id
JOIN `pacific-legend-474020-b4.olist.olist_order_payments_dataset`as p
  ON o.order_id = p.order_id
JOIN `pacific-legend-474020-b4.olist.olist_sellers_dataset` as s
  ON oi.seller_id = s.seller_id
JOIN `pacific-legend-474020-b4.olist.olist_products_dataset` as pr
  ON oi.product_id = pr.product_id
WHERE o.order_status <> 'canceled'
GROUP BY year
HAVING DATE_DIFF(
         DATE(MAX(o.order_purchase_timestamp)),
         DATE(MIN(o.order_purchase_timestamp)),
         MONTH) >= 3
ORDER BY year, active_sellers DESC;

-- ## 6) Satıcı puan dağılımı ve performans etkisi

SELECT
  CASE r.review_score
    WHEN 5 THEN 'Excellent'
    WHEN 4 THEN 'Very Good'
    WHEN 3 THEN 'Good'
    WHEN 2 THEN 'Bad'
    WHEN 1 THEN 'Very Bad'
  END AS rating,
  COUNT(DISTINCT o.order_id)  AS no_orders,
  round(SUM(p.payment_value),2) AS total_rev,
  ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS avg_revenue
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset` as o
JOIN `pacific-legend-474020-b4.olist.olist_order_reviews_dataset` as r USING (order_id)
JOIN `pacific-legend-474020-b4.olist.olist_order_items_dataset` as oi USING (order_id)
JOIN `pacific-legend-474020-b4.olist.olist_order_payments_dataset` as p USING (order_id)
WHERE o.order_status <> 'canceled' AND o.order_approved_at IS NOT NULL
GROUP BY rating
ORDER BY CASE rating
  WHEN 'Excellent' THEN 1
  WHEN 'Very Good' THEN 2
  WHEN 'Good'      THEN 3
  WHEN 'Bad'       THEN 4
  WHEN 'Very Bad'  THEN 5
END ASC;

-- ## 7) Tekrar alım yapan müşteri ve gelir payı

-- Tekrar alışveriş yapan müşteri sayısı → 2924
WITH cust_orders AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS orders_cnt
  FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`as o
  JOIN `pacific-legend-474020-b4.olist.customers_clean`as c
    USING (customer_id)
  WHERE o.order_status <> 'canceled'
  GROUP BY 1
)
SELECT COUNT(*) AS repeat_customers
FROM cust_orders
WHERE orders_cnt > 1;

-- Repeat purchase sayısı ve toplam satış içindeki payı (%) → 5,67
WITH valid_orders AS (
  SELECT
    o.order_id,
    c.customer_unique_id,
    COUNT(*) OVER (PARTITION BY c.customer_unique_id) AS order_cnt  
  FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`as o
  JOIN `pacific-legend-474020-b4.olist.olist_customers_dataset`as c USING (customer_id)
  WHERE o.order_status <> 'canceled'          
),
pay AS (
  SELECT order_id, SUM(payment_value) AS order_payment
  FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
  GROUP BY order_id
)
SELECT
  COUNT(DISTINCT IF(order_cnt > 1, customer_unique_id, NULL))  AS repeat_customers,
  ROUND(100 * SUM(IF(order_cnt > 1, p.order_payment, 0)) / SUM(p.order_payment), 2) AS repeat_revenue_pct
FROM valid_orders vo
JOIN pay as p USING (order_id);

-- ## 9) Ortalama iptal oranı ve etkisi

SELECT
  ROUND(100 * COUNTIF(order_status = 'canceled') / COUNT(*), 2) AS cancel_rate_pct
FROM `pacific-legend-474020-b4.olist.olist_orders_dataset`;

-- Satıcı bazında iptal oranı ve temel hacimler
select 
oi.seller_id,
count(*) as orders_total,
countif(o.order_status = 'canceled') as orders_canceled,
round(100 * countif(o.order_status = 'canceled') / count(*),2) as cancel_rate
from `pacific-legend-474020-b4.olist.olist_order_items_dataset` as oi
join `pacific-legend-474020-b4.olist.olist_orders_dataset` as o using(order_id)
group by seller_id
order by cancel_rate desc, orders_total desc;

-- ## 10) En çok satanlar ve yıllık satış trendi

SELECT
  EXTRACT(YEAR FROM DATETIME(o.order_approved_at))  AS year,
  COALESCE(pc.string_field_1, 'unknown_category') AS category,
  COUNT(oi.product_id)  AS no_product_sold,
  ROUND(SUM(pa.payment_value),2)  AS total_rev
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset`  AS oi
JOIN `pacific-legend-474020-b4.olist.olist_products_dataset` AS p   USING (product_id)
LEFT JOIN `pacific-legend-474020-b4.olist.product_category_name_translation` AS pc
  ON LOWER(p.product_category_name) = LOWER(pc.string_field_0)
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` AS o   USING (order_id)
JOIN `pacific-legend-474020-b4.olist.olist_order_payments_dataset` AS pa  USING (order_id)
WHERE o.order_status <> 'canceled' AND o.order_approved_at IS NOT NULL
GROUP BY year, category
ORDER BY year, total_rev DESC;

-- ## 11) Ödeme yöntemleri – genel, kategoriye ve konuma göre

-- Genel dağılım
WITH valid_pay AS (
  SELECT p.order_id, p.payment_type, p.payment_value
  FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset` p
  JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` o USING (order_id)
  WHERE o.order_status <> 'canceled' AND o.order_approved_at IS NOT NULL
)
SELECT
  payment_type,
  COUNT(DISTINCT order_id)                                        AS orders,
  SUM(payment_value)                                              AS revenue,
  ROUND(100 * COUNT(DISTINCT order_id) /
        SUM(COUNT(DISTINCT order_id)) OVER (), 2)                 AS orders_pct,
  ROUND(100 * SUM(payment_value) /
        SUM(SUM(payment_value)) OVER (), 2)                       AS revenue_pct
FROM valid_pay
GROUP BY payment_type
ORDER BY orders DESC;

-- Kategori × ödeme tipi
WITH valid_pay AS (
  SELECT p.order_id, p.payment_type, p.payment_value
  FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset` as p
  JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` o USING (order_id)
  WHERE o.order_status <> 'canceled' AND o.order_approved_at IS NOT NULL
),
order_cat AS (
  SELECT
    oi.order_id,
    COALESCE(tr.string_field_1, 'unknown_category') AS category
  FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset` as oi
  JOIN `pacific-legend-474020-b4.olist.olist_products_dataset`as pr USING (product_id)
  LEFT JOIN `pacific-legend-474020-b4.olist.product_category_name_translation` as tr
    ON LOWER(pr.product_category_name) = LOWER(tr.string_field_0)
  GROUP BY oi.order_id, category
)
SELECT
  oc.category,
  vp.payment_type,
  COUNT(DISTINCT vp.order_id) AS orders,
  SUM(vp.payment_value)       AS revenue,
  ROUND(100 * COUNT(DISTINCT vp.order_id)
        / SUM(COUNT(DISTINCT vp.order_id)) OVER (PARTITION BY oc.category), 2) AS orders_pct_in_cat,
  ROUND(100 * SUM(vp.payment_value)
        / SUM(SUM(vp.payment_value)) OVER (PARTITION BY oc.category), 2) AS revenue_pct_in_cat
FROM valid_pay as vp
JOIN order_cat as oc USING (order_id)
GROUP BY oc.category, vp.payment_type
ORDER BY oc.category, orders DESC;

-- Eyalet × ödeme tipi
WITH valid_pay AS (
  SELECT p.order_id, p.payment_type, p.payment_value, o.customer_id
  FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`as p
  JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` as o USING (order_id)
  WHERE o.order_status <> 'canceled' AND o.order_approved_at IS NOT NULL
)
SELECT
  c.customer_state AS state,
  vp.payment_type,
  COUNT(DISTINCT vp.order_id) AS orders,
  SUM(vp.payment_value)       AS revenue,
  ROUND(100 * COUNT(DISTINCT vp.order_id)
        / SUM(COUNT(DISTINCT vp.order_id)) OVER (PARTITION BY c.customer_state), 2) AS orders_pct_in_state,
  ROUND(100 * SUM(vp.payment_value)
        / SUM(SUM(vp.payment_value)) OVER (PARTITION BY c.customer_state), 2)  AS revenue_pct_in_state
FROM valid_pay vp
JOIN `pacific-legend-474020-b4.olist.customers_clean`as c
  ON vp.customer_id = c.customer_id
GROUP BY state, vp.payment_type
ORDER BY state, orders DESC;

-- ## 13) Kâr marjı (kategori bazında)

WITH pay AS (
  SELECT order_id, SUM(payment_value) AS payment_value    -- Sipariş bazında toplam ödeme
  FROM `pacific-legend-474020-b4.olist.olist_order_payments_dataset`
  GROUP BY order_id
)
SELECT
  COALESCE(tr.string_field_1, 'unknown_category') AS category, 
  ROUND(
    (SUM(p.payment_value) - SUM(oi.price) + SUM(oi.freight_value))
    / NULLIF(SUM(p.payment_value), 0) * 100
  , 2) AS g_profit_margin
FROM `pacific-legend-474020-b4.olist.olist_order_items_dataset` AS oi
JOIN pay   AS p  USING (order_id)
JOIN `pacific-legend-474020-b4.olist.olist_products_dataset`  AS pr USING (product_id)
LEFT JOIN `pacific-legend-474020-b4.olist.product_category_name_translation` AS tr
  ON LOWER(pr.product_category_name) = LOWER(tr.string_field_0)
JOIN `pacific-legend-474020-b4.olist.olist_orders_dataset` AS o  USING (order_id)
WHERE o.order_status <> 'canceled' AND o.order_approved_at IS NOT NULL
GROUP BY category
ORDER BY g_profit_margin DESC;

-- ## 15) Yüksek müşteri yoğunluklu konumlar

SELECT
  c.customer_city,
  c.customer_state,
  COUNT(DISTINCT c.customer_unique_id) AS unique_customers
FROM `pacific-legend-474020-b4.olist.customers_clean` AS c
GROUP BY 1,2
ORDER BY unique_customers DESC


