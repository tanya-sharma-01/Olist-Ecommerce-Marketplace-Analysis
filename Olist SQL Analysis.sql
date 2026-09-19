CREATE DATABASE olist_ecommerce;
USE olist_ecommerce;
SELECT*FROM olist_customers_dataset;
SELECT*FROM olist_order_items_dataset;
SELECT*FROM olist_orders_dataset;
SELECT*FROM olist_products_dataset;
ALTER TABLE olist_products_dataset RENAME COLUMN product_description_lenght TO product_description_length;
Select Count(distinct order_id) from olist_order_items_dataset;
SELECT COUNT(*)
FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_geolocation_dataset;
DROP TABLE olist_order_reviews_dataset;
DESCRIBE olist_customers_dataset;
SELECT customer_zip_code_prefix FROM olist_customers_dataset;
SELECT*FROM olist_customers_dataset WHERE customer_state IS NULL;
SELECT COUNT(*) FROM (SELECT customer_unique_id, COUNT(*) FROM olist_customers_dataset 
GROUP BY customer_unique_id
HAVING COUNT(*)>1) AS DUPLICATES;
SELECT customer_id, COUNT(*) FROM olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*)>1;
SELECT DISTINCT(customer_city) FROM olist_customers_dataset;
SELECT LOWER(customer_city), COUNT(DISTINCT customer_city)
FROM olist_customers_dataset
GROUP BY LOWER(customer_city) HAVING COUNT(DISTINCT customer_city)>1;
SELECT customer_city, COUNT(*)
FROM olist_customers_dataset
WHERE customer_city <> TRIM(customer_city)
GROUP BY customer_city; 
SELECT DISTINCT customer_state FROM olist_customers_dataset;
SELECT customer_state, COUNT(*)
FROM olist_customers_dataset
GROUP BY customer_state
HAVING COUNT(*)>1;
SELECT customer_state
FROM olist_customers_dataset
WHERE customer_state<> TRIM(customer_state); 
SELECT*FROM olist_customers_dataset
WHERE customer_zip_code_prefix='';
SELECT customer_zip_code_prefix
FROM olist_customers_dataset
WHERE customer_zip_code_prefix IS NULL;
SELECT customer_zip_code_prefix, COUNT(*)
FROM olist_customers_dataset
GROUP BY customer_zip_code_prefix
HAVING COUNT(*)>1;
SELECT customer_zip_code_prefix
FROM olist_customers_dataset
WHERE customer_zip_code_prefix <10000
OR customer_zip_code_prefix > 99999;
SELECT customer_zip_code_prefix
FROM olist_customers_dataset
WHERE customer_zip_code_prefix < 10000
LIMIT 20;
SELECT MIN(customer_zip_code_prefix) AS min_zip,
MAX(customer_zip_code_prefix) AS max_zip
FROM olist_customers_dataset;
SELECT COUNT(*) AS four_digit_values
FROM olist_customers_dataset
WHERE customer_zip_code_prefix < 10000;
ALTER TABLE olist_customers_dataset
MODIFY COLUMN customer_zip_code_prefix VARCHAR(5);
UPDATE olist_customers_dataset
SET customer_zip_code_prefix= LPAD(customer_zip_code_prefix, 5, '0')
WHERE LENGTH(customer_zip_code_prefix)<5;
SELECT freight_value FROM olist_order_items_dataset
WHERE freight_value IS NULL;
SELECT order_id, COUNT(*)
FROM olist_order_items_dataset
GROUP BY order_id
HAVING COUNT(*)>1;
SELECT order_id, order_item_id, COUNT(*)
FROM olist_order_items_dataset
GROUP BY order_id, order_item_id
HAVING COUNT(*)>1;
SELECT DISTINCT(order_item_id)
FROM olist_order_items_dataset
ORDER BY order_item_id;
DESCRIBE olist_order_items_dataset;
SELECT price, freight_value
FROM olist_order_items_dataset
LIMIT 20;
ALTER TABLE olist_order_items_dataset
MODIFY COLUMN price DECIMAL(10,2),
MODIFY COLUMN freight_value DECIMAL(10,2);
SELECT price, freight_value FROM olist_order_items_dataset;
DROP TABLE olist_order_items_original;
SELECT seller_id FROM olist_order_items_dataset
WHERE TRIM(seller_id)='';
SELECT MIN(shipping_limit_date),
MAX(shipping_limit_date)
FROM olist_order_items_dataset;
SELECT freight_value, COUNT(*)
FROM olist_order_items_dataset
GROUP BY freight_value
HAVING freight_value<=0;
DROP TABLE olist_order_payments_dataset;
DESCRIBE olist_order_payments_dataset;
SELECT payment_installments FROM olist_order_payments_dataset
WHERE payment_installments IS NULL;
SELECT DISTINCT(payment_type)
FROM olist_order_payments_dataset;
SELECT COUNT(*) FROM olist_order_payments_dataset
WHERE payment_type='not_defined';
SELECT payment_installments, COUNT(*)
FROM olist_order_payments_dataset
WHERE payment_installments<=0
GROUP BY payment_installments;
SELECT*FROM olist_order_payments_dataset
WHERE payment_value=0;
SELECT payment_value, COUNT(*)
FROM olist_order_payments_dataset
WHERE payment_value <=0
GROUP BY payment_value;
DESCRIBE olist_orders_dataset;
DROP TABLE olist_orders_dataset;
CREATE TABLE olist_orders_dataset (
order_id TEXT,
customer_id TEXT,
order_status TEXT,
order_purchase_timestamp DATETIME,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATETIME);
SELECT*FROM olist_orders_dataset;
LOAD DATA LOCAL INFILE 'C:/Users/tanya/Downloads/archive (8)/olist_orders_dataset.csv'
INTO TABLE olist_orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY'"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE'local_infile';
SET GLOBAL local_infile=1;
DESCRIBE olist_orders_dataset;
SELECT*FROM olist_orders_dataset
WHERE order_estimated_delivery_date IS NULL;
SELECT order_id, COUNT(*)
FROM olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*)>1;
SELECT customer_id
FROM olist_orders_dataset
WHERE customer_id='';
SELECT DISTINCT(order_status)
FROM olist_orders_dataset;
SELECT MIN(order_approved_at),
MAX(order_approved_at)
FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_orders_dataset
WHERE order_approved_at='0000-00-00 00:00:00';
SELECT COUNT(*) AS zero_dates
FROM olist_orders_dataset
WHERE order_approved_at IS NULL;
SELECT COUNT(*) AS zero_dates
FROM olist_orders_dataset
WHERE YEAR(order_approved_at) = 0;
SELECT order_status, COUNT(*) AS count
FROM olist_orders_dataset
WHERE YEAR(order_approved_at) = 0
GROUP BY order_status;
UPDATE olist_orders_dataset
SET order_approved_at=NULL 
WHERE (order_approved_at)=0;
SELECT COUNT(*) AS null_approved_dates
FROM olist_orders_dataset
WHERE order_approved_at IS NULL;
SELECT MIN(order_delivered_carrier_date),
MAX(order_delivered_carrier_date)
FROM olist_orders_dataset;
SELECT COUNT(*) AS zero_dates
FROM olist_orders_dataset
WHERE YEAR(order_delivered_carrier_date) = 0;
SELECT order_status, COUNT(*)
FROM olist_orders_dataset
WHERE YEAR(order_delivered_carrier_date)=0
GROUP BY order_status;
UPDATE olist_orders_dataset
SET order_delivered_carrier_date= NULL
WHERE YEAR(order_delivered_carrier_date) = 0;
SELECT*FROM olist_orders_dataset;
SELECT COUNT(*)
FROM olist_orders_dataset
WHERE order_delivered_carrier_date IS NULL;
SELECT MIN(order_estimated_delivery_date),
MAX(order_estimated_delivery_date)
FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_orders_dataset
WHERE order_delivered_customer_date=0;
SELECT order_status, COUNT(*)
FROM olist_orders_dataset
WHERE YEAR(order_delivered_customer_date) = 0
GROUP BY order_status;
UPDATE olist_orders_dataset
SET order_delivered_customer_date=NULL 
WHERE YEAR(order_delivered_customer_date)=0;
SELECT COUNT(*) FROM olist_orders_dataset
WHERE (order_delivered_customer_date) IS NULL;
DESCRIBE olist_products_dataset;
SELECT product_id, COUNT(*)
FROM olist_products_dataset
GROUP BY product_id
HAVING COUNT(*)>1;
SELECT DISTINCT(product_category_name) 
FROM olist_products_dataset;
SELECT product_width_cm, COUNT(*)
FROM olist_products_dataset
WHERE product_width_cm<0
GROUP BY product_width_cm;
SELECT product_width_cm, COUNT(*)
FROM olist_products_dataset
WHERE product_width_cm=0;
SELECT product_category_name, COUNT(*)
FROM olist_products_dataset
WHERE product_weight_g=0
GROUP BY product_category_name;
SELECT product_id, product_weight_g
FROM olist_products_dataset
WHERE product_category_name='cama_mesa_banho'
AND product_weight_g=0;
UPDATE olist_products_dataset
SET product_weight_g= NULL
WHERE product_weight_g=0;
DESCRIBE olist_sellers_dataset;
SELECT COUNT(*)
FROM olist_sellers_dataset
WHERE seller_state IS NULL;
SELECT seller_id, COUNT(*)
FROM olist_sellers_dataset
GROUP BY seller_id
HAVING COUNT(*)>1;
SELECT COUNT(*) FROM olist_sellers_dataset
WHERE seller_zip_code_prefix<00000 OR seller_zip_code_prefix>99999;
SELECT MIN(seller_zip_code_prefix),
MAX(seller_zip_code_prefix)
FROM olist_sellers_dataset
WHERE seller_zip_code_prefix<10000 OR seller_zip_code_prefix>99999;
SELECT COUNT(*) FROM olist_sellers_dataset;
SELECT seller_zip_code_prefix
FROM olist_sellers_dataset
LIMIT 10;
SELECT COUNT(*) FROM olist_sellers_dataset
WHERE seller_state='';
SELECT DISTINCT(seller_state) FROM olist_sellers_dataset;
DESCRIBE product_category_name_translation;
ALTER TABLE product_category_name_translation
RENAME COLUMN ï»¿product_category_name to product_category_name;
SELECT COUNT(*) FROM product_category_name_translation
WHERE product_category_name=0;
SELECT product_category_name,
COUNT(DISTINCT product_category_name_english) AS english_count
FROM product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(DISTINCT product_category_name_english) > 1;
SELECT product_category_name,
       product_category_name_english
FROM product_category_name_translation
WHERE product_category_name IN ('03717', '03726', '03733', '03757');
SELECT COUNT(*) AS total_rows
FROM product_category_name_translation;
SELECT *
FROM product_category_name_translation;
SELECT DISTINCT p.product_category_name
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name IS NULL;
DELETE FROM product_category_name_translation
WHERE product_category_name LIKE '037%';
SELECT COUNT(*)
FROM product_category_name_translation;
DROP TABLE product_category_name_translation;
SELECT DISTINCT(product_category_name_english) FROM product_category_name_translation;
SELECT COUNT(*) FROM product_category_name_translation
WHERE product_category_name_english ='';
SELECT product_category_name, product_category_name_english FROM product_category_name_translation
GROUP BY product_category_name, product_category_name_english
HAVING COUNT(*)>1;
SELECT product_category_name,
COUNT(DISTINCT product_category_name_english)
FROM product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(DISTINCT product_category_name_english)>1;
SELECT 
    p.product_id,
    p.product_category_name,
    t.product_category_name_english
FROM olist_products_dataset p
JOIN product_category_name_translation t
ON p.product_category_name = t.product_category_name;
SELECT
p.product_id,
p.product_category_name,
t.product_category_name_english
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t
ON p.product_category_name=t.product_category_name
WHERE t.product_category_name_english IS NULL;
SELECT *
FROM product_category_name_translation
WHERE product_category_name IN (
    'pc_gamer',
    'portateis_cozinha_e_preparadores_de_alimentos');
SELECT COUNT(*) FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t
ON p.product_category_name = t.product_category_name
WHERE t.product_category_name IS NULL;
SELECT DISTINCT p.product_category_name
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t
ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IS NULL;
SELECT p.payment_type,
p.payment_installments,
p.payment_value,
o.order_status,
o.customer_id
FROM olist_order_payments_dataset p
JOIN olist_orders_dataset o
ON p.order_id = o.order_id
ORDER BY payment_value DESC
LIMIT 10;
SELECT SUM(p.payment_value),
p.payment_type,
o.order_status
FROM olist_order_payments_dataset p
JOIN olist_orders_dataset o
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.payment_type;
SELECT*FROM olist_customers_dataset;
SELECT*FROM olist_order_items_dataset;
SELECT*FROM olist_order_payments_dataset;
SELECT*FROM olist_orders_dataset;
SELECT*FROM olist_products_dataset;
SELECT*FROM olist_sellers_dataset;
SELECT*FROM product_category_name_translation;
SELECT p.product_category_name,
COUNT(o.order_item_id)
FROM olist_products_dataset p
JOIN olist_order_items_dataset o
ON p.product_id = o.product_id
GROUP BY p.product_category_name
ORDER BY COUNT(o.order_item_id) DESC
LIMIT 1;
SELECT p.product_category_name,
sum(o.price)
FROM olist_order_items_dataset o
JOIN olist_products_dataset p
ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY SUM(o.price)DESC
LIMIT 1;
SELECT COUNT(customer_id), customer_city
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY COUNT(customer_id) ASC
LIMIT 1;
SELECT COUNT(seller_id), seller_city
FROM olist_sellers_dataset
GROUP BY seller_city
ORDER BY COUNT(seller_id) DESC
LIMIT 1;
SELECT s.seller_city,
SUM(o.price)
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset o
ON o.seller_id = s.seller_id
GROUP BY seller_city
ORDER BY SUM(o.price) ASC
LIMIT 1;
SELECT*FROM olist_order_payments_dataset;
SELECT COUNT(payment_type), payment_type
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY COUNT(payment_type) DESC
LIMIT 1;
SELECT payment_type, AVG(payment_value)
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY AVG(payment_value) DESC
LIMIT 1;

SELECT DISTINCT(order_status) FROM olist_orders_dataset;

SELECT COUNT(order_status), order_status
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY COUNT(order_status) DESC;
SELECT COUNT(order_status) FROM olist_orders_dataset; 

SELECT order_status,
COUNT(order_status) AS order_count,
COUNT(order_status)/
(SELECT COUNT(order_status) FROM olist_orders_dataset)*100 AS percentage
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY percentage DESC;

SELECT p.product_category_name,
COUNT(o.order_id)
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
ON o.order_id = oi.order_id
JOIN olist_products_dataset p
ON oi.product_id = p.product_id
WHERE o.order_status <> 'delivered'
GROUP BY p.product_category_name
ORDER BY COUNT(o.order_id) DESC;

SELECT*FROM olist_orders_dataset;

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
FROM olist_orders_dataset
WHERE order_status ='delivered';

SELECT c.customer_state,
AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp))
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp))
DESC LIMIT 1;

SELECT AVG(order_value)
FROM (SELECT order_id, SUM(payment_value) AS order_value
FROM olist_order_payments_dataset
GROUP BY order_id)
AS orders;

SELECT AVG(freight_value) FROM olist_order_items_dataset;

SELECT p.product_category_name,
AVG(oi.price)
FROM olist_products_dataset p
JOIN olist_order_items_dataset oi
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY AVG(oi.price) DESC
LIMIT 1;

SELECT product_category_name_english
FROM product_category_name_translation
WHERE product_category_name = 'cama_mesa_banho';

-- SELECT *FROM product_category_name_translation;
SELECT 
    s.seller_city,
    s.seller_count,
    d.avg_delivery_days
FROM
(
    SELECT seller_city, COUNT(DISTINCT seller_id) AS seller_count
    FROM olist_sellers_dataset
    GROUP BY seller_city
) s
JOIN
(
    SELECT 
        c.customer_city,
        AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)) AS avg_delivery_days
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_city
) d
ON s.seller_city = d.customer_city
ORDER BY s.seller_count DESC;

SELECT 
    s.seller_city,
    COUNT(DISTINCT s.seller_id) AS seller_count,
    COUNT(DISTINCT c.customer_id) AS customer_count
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi
    ON s.seller_id = oi.seller_id
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
GROUP BY s.seller_city
ORDER BY seller_count DESC;

SELECT 
    p.product_category_name,
    COUNT(DISTINCT CASE WHEN o.order_status <> 'delivered' THEN o.order_id END) AS non_delivered_orders,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT CASE WHEN o.order_status <> 'delivered' THEN o.order_id END) 
        * 100.0 / COUNT(DISTINCT o.order_id), 
        2
    ) AS non_delivery_rate
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY non_delivery_rate DESC;

USE olist_ecommerce;
SELECT AVG(order_value)
FROM( SELECT SUM(payment_value) AS order_value, order_id
FROM olist_order_payments_dataset
GROUP BY order_id)
AS orders;

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
AS avg_delivery_time
FROM olist_orders_dataset
WHERE order_status ='delivered';

SELECT COUNT(seller_id), seller_state
FROM olist_sellers_dataset
WHERE seller_state ='RR';

SELECT seller_state, COUNT(seller_id)
FROM olist_sellers_dataset
GROUP BY seller_state
ORDER BY COUNT(seller_id) DESC;

SELECT AVG(o.price),
p.product_category_name
FROM olist_order_items_dataset o
JOIN olist_products_dataset p
ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY AVG(o.price) DESC
LIMIT 1;

SELECT p.product_category_name,
COUNT(o.order_item_id)
FROM olist_products_dataset p
JOIN olist_order_items_dataset o
ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY COUNT(o.order_item_id) DESC;

SELECT
YEAR (order_purchase_timestamp) AS year,
MONTH (order_purchase_timestamp) AS month,
COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY 
YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
ORDER BY year, month;





