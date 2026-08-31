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



SELECT tc.table_name,
       kcu.column_name
FROM   information_schema.table_constraints AS tc
       JOIN information_schema.key_column_usage AS kcu
	        ON tc.constraint_name = kcu.constraint_name
			AND tc.table_schema = kcu.table_schema
	   WHERE tc.constraint_type = 'PRIMARY KEY'
	        AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;
