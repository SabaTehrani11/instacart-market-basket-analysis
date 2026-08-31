SELECT 'aisles' AS table_name, 
       COUNT(*) AS row_count 
FROM aisles 

UNION ALL 

SELECT 'departments' AS table_name, 
        COUNT(*) AS row_count 
FROM departments 

UNION ALL 

SELECT 'order_products__prior' AS table_name, 
        COUNT(*) AS row_count 
FROM order_products__prior 

UNION ALL 

SELECT 'order_products__train' AS table_name, 
        COUNT(*) AS row_count 
FROM order_products__train 

UNION ALL 

SELECT 'orders' AS table_name, 
        COUNT(*) AS row_count 
FROM orders 

UNION ALL 

SELECT 'products' AS table_name, 
        COUNT(*) AS row_count
FROM products;