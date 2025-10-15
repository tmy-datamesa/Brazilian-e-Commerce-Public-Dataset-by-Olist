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



