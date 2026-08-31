-- =====================================================
# 9. README - Instacart Data Analysis Project
-- =====================================================


-- ==================
#  Project Overview
-- ==================

This project analyzes Instacart grocery order data using SQL and postgreSQL.
The goal is explore the database schema, validate data quality and integrity ,
and answer key business questions related to orders, products, aisles, departments,
and customer purchasing behavior.

-- ==================
#  Objectives
-- ==================

- Explore database schema and table relationships.
- Validate data quality and referential integrity.
- Analyze customer purchasing behavior through business analysis.
- Generate actionable business insights from online grocery order data.

-- ==================
#  Dataset
-- ==================

Instacart Market Basket Analysis dataset includes the following tables:
- aisles
- departments
- orders
- products
- order_products__prior
- order_products__train

Dataset: Instacart Market Basket Analysis (Kaggle).
Raw CSV files are excluded from this repository due to GitHub file size limitations.

-- ====================
#  Tools & Technologies
-- ====================

- PostgrSQL
- pgAdmin
- SQL
- Markdown
- GitHub

-- ====================
#  Project Structure
-- ====================

instacart_data_analysis/
├── README.md
├── Business_Insight.md
├── sql/
│   ├── 01_schema_exploration.sql
│   ├── 02_data_validation.sql
│   └── 03_business_analysis.sql
├── diagrams/
│   └── instacart_ERD.png
└── screenshots/
    └── table_row_count.png

-- ====================
#  SQL Workflow
-- ====================

### 1. Schema Exploration
`01_schema_exploration.sql`

Explore tables, row counts, columns, primary keys, foreign keys, and indexes.

### 2. Data Validation
`02_data_validation.sql`

Check null values in primary keys, duplicate primary keys, null values in foreign keys, 
foreign keys integrity, null values in text columns, and allowed values in specific columns.

### 3. Business Analysis
`03_business_analysis.sql`

Include SQL quesries used to answer 10 business questions.

-- ====================
#  Business Questions
-- ====================

1. What are the top 20 most frequently purchased products?
2. Which products have the highest reorder rate?
3. Which departments generate the most purchases?
4. Which aisle has the largest average basket size?
5. What percentage of customers reorder within 7 days?
6. Which customers have stopped ordering?
7. Which products are commonly purchased together?
8. Which day of the week generates the highest order volume?
9. Build customer segments based on purchase frequency.
10. Rank products within every department by popularity.

-- ====================
#  Key Insights
-- ====================

- Bananas are the most purchased product, and organic products show high customer demand.
- Row Veggie Wrappers have the highest reorder rate.
- The baby fruit formula aisle has The largest average basket size.
- Customers show strong repeat-purchase behavior within 7 days.
- Banana and Bag of organic bananas are commonly purchased together.
- Sunday has the highest order volume.


-- ====================
#  Business Insights
-- ====================

Detailed results and business interpretations for all 10 questions are available in: 
Business_Insight.md ,and 
the corresponding SQL queries are available in :
Business_Insight.sql

-- ====================
#  Conclusion
-- ====================

This project demonstrates SQL-based data exploration, data validation, and customer 
purchasing behavior analysis to generate business insights from a real-world online grocery transaction dataset.










