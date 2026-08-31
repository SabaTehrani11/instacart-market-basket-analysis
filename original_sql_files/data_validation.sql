-- =====================================================
--  Instacart Data Validation
-- =====================================================


-- =====================================================
-- 1. CHECK NULL VALUES IN PRIMARY KEYS
-- =====================================================


SELECT aisle_id,
       COUNT(*) AS null_pk_count
FROM aisles
WHERE aisle_id IS NULL
GROUP BY 1;

SELECT department_id,
       COUNT(*) AS null_pk_count
FROM departments
WHERE department_id IS NULL
GROUP BY 1;

SELECT order_id,
       COUNT(*) AS null_pk_count
FROM orders
WHERE order_id IS NULL
GROUP BY 1;

SELECT product_id,
       COUNT(*) AS null_pk_count
FROM products
WHERE product_id IS NULL
GROUP BY 1;

SELECT order_id, product_id,
       COUNT(*) AS null_pk_count
FROM order_products__prior
WHERE order_id IS NULL
      OR product_id IS NULL
GROUP BY 1, 2;

SELECT order_id, product_id,
       COUNT(*) AS null_pk_count
FROM order_products__train
WHERE order_id IS NULL
      OR product_id IS NULL
GROUP BY 1, 2;


-- =====================================================
-- 2. CHECK DUPLICATE PRIMARY KEYS
-- =====================================================


SELECT aisle_id,
       COUNT(*) AS duplicate_count
FROM aisles
GROUP BY aisle_id
HAVING COUNT(*) > 1;

SELECT department_id,
       COUNT(*) AS duplicate_count
FROM departments
GROUP BY department_id
HAVING COUNT(*) > 1;

SELECT order_id,
       COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT product_id,
       COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id, product_id,
       COUNT(*) AS duplicate_count
FROM order_products__prior
GROUP BY 1,2
HAVING COUNT(*) > 1;

SELECT order_id, product_id,
       COUNT(*) AS duplicate_count
FROM order_products__train
GROUP BY 1,2
HAVING COUNT(*) > 1;


-- =====================================================
-- 3. CHECK NULL VALUES IN FOREIGN KEYS 
-- =====================================================


SELECT COUNT(*) AS null_aisle_fk
FROM products 
WHERE aisle_id IS NULL;

SELECT COUNT(*) AS null_department_fk
FROM products 
WHERE department_id IS NULL;

SELECT COUNT(*) AS null_prior_product_fk
FROM order_products__prior 
WHERE product_id IS NULL;

SELECT COUNT(*) AS null_prior_order_fk
FROM order_products__prior 
WHERE order_id IS NULL;  

SELECT COUNT(*) AS null_train_product_fk
FROM order_products__train
WHERE product_id IS NULL;  

SELECT COUNT(*) AS null_train_order_fk
FROM order_products__train 
WHERE order_id IS NULL; 


-- =====================================================
-- 4. CHECK FOREIGN KEYS INTEGRITY
-- =====================================================


SELECT COUNT(*) AS invalid_aisle_fk
FROM products AS p
     LEFT JOIN aisles AS a
	      ON p.aisle_id = a.aisle_id
WHERE a.aisle_id IS NULL;

SELECT COUNT(*) AS invalid_department_fk
FROM products AS p
     LEFT JOIN departments AS d
	      ON p.department_id = d.department_id
WHERE d.department_id IS NULL;

SELECT COUNT(*) AS invalid_prior_product_fk
FROM order_products__prior AS opp
     LEFT JOIN products AS p
	      ON opp.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS invalid_prior_order_fk
FROM order_products__prior AS opp
     LEFT JOIN orders AS o
	      ON opp.order_id = o.order_id
WHERE o.order_id IS NULL;  

SELECT COUNT(*) AS invalid_train_product_fk
FROM order_products__train AS opt
     LEFT JOIN products AS p
	      ON opt.product_id = p.product_id
WHERE p.product_id IS NULL;  

SELECT COUNT(*) AS invalid_train_order_fk
FROM order_products__train AS opt
     LEFT JOIN orders AS o
	      ON opt.order_id = o.order_id
WHERE o.order_id IS NULL;  


-- =====================================================
-- 5. CHECK NULL VALUES IN TEXT COLUMNS 
-- =====================================================


SELECT COUNT(*) AS null_aisle_text
FROM aisles 
WHERE aisle IS NULL;

SELECT COUNT(*) AS null_product_name_text
FROM products 
WHERE product_name IS NULL;

SELECT COUNT(*) AS null_department_text
FROM departments
WHERE department IS NULL;


-- =====================================================
-- 6. CHECK ORDERS VALUES 
-- =====================================================


SELECT COUNT(order_number) AS invalid_order_number
FROM orders
WHERE order_number < 1;

-- SELECT COUNT(*) AS invalid_order_number
--FROM orders
--WHERE order_number < 1;

SELECT COUNT(order_dow) AS invalid_order_dow
FROM orders
WHERE order_dow < 0
   OR order_dow > 6;

--SELECT COUNT(*) AS invalid_order_dow
--FROM orders
--WHERE order_dow < 0
--   OR order_dow > 6;

SELECT COUNT(order_hour_of_day) AS invalid_order_hour_of_day
FROM orders
WHERE order_hour_of_day < 0
   OR order_hour_of_day > 23;

--SELECT COUNT(*) AS invalid_order_hour_of_day
--FROM orders
--WHERE order_hour_of_day < 0
--   OR order_hour_of_day > 23;

SELECT COUNT(*) AS invalid_days_since_prior_order
FROM orders
WHERE days_since_prior_order < 0;


-- =====================================================
-- 7. CHECK ORDER_PRODUCTS__PRIOR VALUES 
-- =====================================================


SELECT COUNT(add_to_cart_order) AS invalid_add_to_cart_order
FROM order_products__prior
WHERE add_to_cart_order < 1;

--SELECT COUNT(*) AS invalid_add_to_cart_order
--FROM order_products__prior
--WHERE add_to_cart_order < 1;

SELECT COUNT(reordered) AS invalid_reordered
FROM order_products__prior
WHERE reordered NOT IN (0, 1);

--SELECT COUNT(*) AS invalid_reordered
--FROM order_products__prior
--WHERE reordered NOT IN (0, 1);


-- =====================================================
-- 8. CHECK ORDER_PRODUCTS__TRAIN VALUES 
-- =====================================================


SELECT COUNT(add_to_cart_order) AS invalid_add_to_cart_order
FROM order_products__train
WHERE add_to_cart_order < 1;

--SELECT COUNT(*) AS invalid_add_to_cart_order
--FROM order_products__train
--WHERE add_to_cart_order < 1;

SELECT COUNT(reordered) AS invalid_reordered
FROM order_products__train
WHERE reordered NOT IN (0, 1);

--SELECT COUNT(*) AS invalid_reordered
--FROM order_products__train
--WHERE reordered NOT IN (0, 1);






