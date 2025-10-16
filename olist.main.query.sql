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





