-- =====================================================
-- 8. Business_Insights
-- Instacart Data Engineering Project
-- =====================================================


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

-- Result Query 1: 
-- Bananas are the most purchased product, 
-- with 472565 purchases ,followed by Bag of Organic Bananas 
-- and Organic Strawberries with 379450 and 264683 purchases,
-- respectively among groceries.

-- Business Insight Query 1:
-- This Query indicates the high customer demand for organic products,
-- as 15 of the 20 Most Frequently Purchased Products are organic.

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

-- Result Query 2: 
-- Row Veggie Wrappers have the highest reorder rate 
-- with 94.12% ,followed by Serenity Ultimate Extrema Overnight pads 
-- and Orange Energy Shots with 93.10% and 92.31% respectively.

-- Business Insight Query 2:
-- This Query indicates that the top 20 products consistently have high reorder rates,
-- ranging from 88.00% to 94.12%, showing strong repeat customer demand.

-- =====================================================
-- Question 3: Departments Generate The Most Purchases
-- =====================================================

SELECT d.department_id, d.department, COUNT(*) AS purchased_count
FROM departments AS d
     JOIN products AS p
	      ON d.department_id = p.department_id
	 JOIN order_products__prior AS opp
	      ON p.product_id = opp.product_id
GROUP BY 1, 2
ORDER BY purchased_count DESC
LIMIT 21;

-- Result Query 3:
-- Produce is the department with the most purchases, with 9479291 purchases, 
-- followed by dairy eggs and snacks with 5414016 and 2887550 purchases respectively.

-- Business Insight Query 3:
-- This Query indicates that the produce department has the highest customer demand,  
-- with about 4.1 million more purchase than Dairy eggs department.

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

-- Result Query 4:
-- The baby fruit formula aisle has The Largest Average Basket Size
-- at 19.81, followed by canned fruit appleasauce
-- and instant foods at 18.54 and 17.75, respectively.

-- Business Insight Query 4:
-- Customers who buy baby fruit formula tend to make larger shopping 
-- trips, with an average basket size of 19.81.

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

-- Result Query 5:
-- 76.41% of customers reorder within 7 days.

-- Business Insight Query 5:
-- The high percentage of customers reordering within 7 days
-- indicates strong repeat-purchase behavior.

-- =====================================================
-- Question 6: Customers Who Have Stopped Ordering
-- =====================================================

SELECT user_id,
       order_number AS last_order_number,
	   eval_set
FROM orders
WHERE eval_set IN ('train' , 'test') 
ORDER BY 1;

-- Result Query 6:
-- Each customer's last order appears in either the train or test eval set.

-- Business Insight Query 6:
-- The train or test set indicates the endpoint of each customer's order history.

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
    GROUP BY 1, 2
        
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

-- Result Query 7:
-- Banana and Bag of organic bananas are commonly purchased together,with 
-- 15000 joint purchases.

-- Business Insight Query 7:
-- This indicates a strong purchasing association between 
-- these two products.

-- =====================================================
-- Question 8: Day Of The Week Generates The Highest Order Volume
-- =====================================================

SELECT order_dow, COUNT(order_id) AS order_volume
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC;

-- Result Query 8:
-- Sunday has the highest order volume at 600905, while 
-- The lowest order volume is on Thursday , at around 426339.

-- Business Insight Query 8:
-- Higher order volume on peak days indicates stronger customer 
-- purchasing activity on those days.

-- =====================================================
-- Question 9: Build Customer Segments Based On Purchase Frequency
-- =====================================================

SELECT o.user_id, COUNT(DISTINCT opp.order_id) AS purchased_count,
    CASE
      WHEN COUNT(DISTINCT opp.order_id) >= 5 THEN 'High Frequency'
	  WHEN COUNT(DISTINCT opp.order_id) >= 2 THEN 'Medium Frequency'
	  ELSE 'Low Frequency'
    END AS customer_segment
FROM order_products__prior AS opp
     JOIN orders AS o
	      ON opp.order_id = o.order_id
GROUP BY 1
ORDER BY purchased_count DESC;

-- Result Query 9:
-- The maximum purchase count is 99, classsified as high frequency.

-- Business Insight Query 9:
-- Customers with higher order counts are more frequent buyers.

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
ORDER BY 1, rnk;

-- Result Query 10: 
-- Blueberries are the most popular product in department 1, 
-- with 55946 purchases ,followed by organic broccoli florets 
-- and organic whole strawberries with 32887 and 31445 purchases, respectively.

-- Business Insight Query 10:
-- This Query indicates that blueberries have the highest customer demand 
-- in department 1.