-- =====================================================
-- 1. SCHEMA EXPLORATION 
-- Instacart Data Engineering Project
-- =====================================================

-- 1. List Tables 
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- 2. Row Counts
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

-- 3. Primary Keys
SELECT tc.table_name,
       kcu.column_name,
	   tc.constraint_name,
	   tc.table_schema, 
	    tc.constraint_type
FROM   information_schema.table_constraints AS tc
       JOIN information_schema.key_column_usage AS kcu
	        ON tc.constraint_name = kcu.constraint_name
			AND tc.table_schema = kcu.table_schema
			AND tc.table_name = kcu.table_name
	   WHERE tc.constraint_type = 'PRIMARY KEY'
	        AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;

-- 4. Foreign Keys
SELECT tc.table_name,
       kcu.column_name,
	   tc.table_schema,
	   tc.constraint_type,
	   kcu.constraint_name,
	   ccu.table_name AS refrenced_table,
	   ccu.column_name AS refrenced_column
FROM   information_schema.table_constraints AS tc
       JOIN information_schema.key_column_usage AS kcu
	        ON tc.constraint_name = kcu.constraint_name
			AND tc.table_schema = kcu.table_schema
			AND tc.table_name = kcu.table_name
	   JOIN information_schema.constraint_column_usage ccu
	        ON tc.constraint_name = ccu.constraint_name
			AND tc.table_schema = ccu.table_schema
       WHERE tc.constraint_type = 'FOREIGN KEY' 
	         AND tc.table_schema = 'public'
ORDER BY  tc.table_name, kcu.column_name;

-- 5. Indexes
SELECT tablename,
       indexname,
	   indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY  1, 2;