-- =====================================================
-- Question 1: Top 20 Most Frequently Purchased Products
-- =====================================================

SELECT p.product_id, p.product_name,
       COUNT(*) AS purchased_count
FROM order_products__prior AS opp
     JOIN products AS p
	      ON p.product_id = opp.product_id
GROUP BY 1, 2
ORDER BY purchased_count DESC
LIMIT 20;

-- =====================================================
-- Question 2: Products With The Highest Reorder Rate
-- =====================================================

SELECT p.product_id, p.product_name,
       ROUND((AVG(reordered):: numeric) * 100 ,2 ) AS reorder_rate
FROM  order_products__prior AS opp
       JOIN products AS p
	        ON p.product_id = opp.product_id 
GROUP BY 1, 2
ORDER BY reorder_rate DESC
LIMIT 20;

-- =====================================================
-- Question 3: Departments Generate The Most Purchases
-- =====================================================

SELECT d.department_id, COUNT(*) AS purchased_count
FROM departments AS d
     JOIN products AS p
	      ON d.department_id = p.department_id
	 JOIN order_products__prior AS opp
	      ON p.product_id = opp.product_id
GROUP BY 1
ORDER BY purchased_count DESC
LIMIT 20;

-- =====================================================
-- Question 4: Aisle Has The Largest Average Basket Size
-- =====================================================

WITH basket_size AS (
     SELECT order_id , COUNT(*) AS basket_size
	 FROM order_products__prior
	 GROUP BY 1
)
SELECT a.aisle_id , a.aisle, 
       ROUND(AVG(bs.basket_size) ,2) AS avg_basket_size
FROM basket_size AS bs
     JOIN order_products__prior AS opp
	      ON bs.order_id = opp.order_id
	 JOIN products AS p
	      ON opp.product_id = p.product_id
	 JOIN aisles AS a
	      ON p.aisle_id = a. aisle_id
GROUP BY 1, 2
ORDER BY avg_basket_size DESC
LIMIT 20;

-- =====================================================
-- Question 5: Percentage Of Customers Reorder Within 7 Days
-- =====================================================

SELECT 
   ROUND(COUNT(DISTINCT CASE
    WHEN days_since_prior_order <= 7 THEN user_id
    END) * 100.0 
    /
    COUNT(DISTINCT user_id), 2)
FROM orders;


-- =====================================================
-- Question 6: Customers Who Have Stopped Ordering
-- =====================================================

SELECT user_id,
       MAX(order_number) AS last_order_number
FROM orders
WHERE eval_set = 'train'
GROUP BY 1
ORDER BY 1;


-- =====================================================
-- Question 7: Products That Are Commonly Purchased Together
-- =====================================================

WITH purchased_together AS (
    SELECT
        opp1.product_id AS product_1_id,
        opp2.product_id AS product_2_id,
        COUNT(*) AS commonly_purchased_together
    FROM order_products__prior AS opp1
    JOIN order_products__prior AS opp2
        ON opp1.order_id = opp2.order_id
       AND opp1.product_id < opp2.product_id
    GROUP BY
        opp1.product_id,
        opp2.product_id
)

SELECT
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    pt.commonly_purchased_together
FROM purchased_together AS pt
JOIN products AS p1
    ON pt.product_1_id = p1.product_id
JOIN products AS p2
    ON pt.product_2_id = p2.product_id
ORDER BY pt.commonly_purchased_together DESC
LIMIT 20;

-- =====================================================
-- Question 8: Day Of The Week Generates The Highest Order Volume
-- =====================================================

SELECT order_dow, COUNT(order_id) AS order_volume
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC;

-- =====================================================
-- Question 9: Build Customer Segments Based On Purchase Frequency
-- =====================================================

SELECT o.user_id, COUNT(*) AS purchased_count
FROM order_products__prior AS opp
     JOIN orders AS o
	      ON opp.order_id = o.order_id
GROUP BY 1
ORDER BY purchased_count DESC;

-- =====================================================
-- Question 10: Rank Products Within Every Department By Popularity
-- =====================================================

SELECT d.department_id, p.product_id , p.product_name,
       COUNT(*) AS purchased_count ,
	   RANK() OVER (PARTITION BY d.department_id ORDER BY COUNT(*) DESC) AS rnk
FROM order_products__prior AS opp
     JOIN products AS p
	      ON opp.product_id = p.product_id
	 JOIN departments AS d
	      ON p.department_id = d.department_id
GROUP BY 1, 2, 3
ORDER BY 2, rnk;
 

       
 
       




		  

	   

		  


