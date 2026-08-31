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


SELECT tc.table_name,
       kcu.column_name,
	   tc.table_schema,
	   tc.constraint_type,
	   kcu.constraint_name
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