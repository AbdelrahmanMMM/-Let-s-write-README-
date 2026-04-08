-- 🗄️ Hive Queries (Data Warehouse Layer)

-- =========================================
-- 1. CREATE DATABASE
-- =========================================

CREATE DATABASE IF NOT EXISTS bike_dw;

-- Use the database
USE bike_dw;

-- =========================================
-- 2. VERIFY DATA FROM SPARK TABLES
-- =========================================

-- Check KPI table created from Spark
SELECT * FROM bike_dw.sales_kpi;

-- =========================================
-- 3. CREATE EXTERNAL TABLE (SALES KPI)
-- =========================================

-- External table pointing to Spark output (Parquet files)

CREATE EXTERNAL TABLE bike_dw.sales_kpi_ext (
store_id INT,
total_sales DOUBLE,
total_orders BIGINT
)
STORED AS PARQUET
LOCATION '/user/hive/warehouse/bike_dw.db/sales_kpi';

-- Validate external table
SELECT * FROM bike_dw.sales_kpi_ext;

-- =========================================
-- 4. OPTIONAL: PRODUCT KPI TABLE
-- =========================================

CREATE EXTERNAL TABLE bike_dw.product_kpi_ext (
product_id INT,
revenue DOUBLE
)
STORED AS PARQUET
LOCATION '/user/hive/warehouse/bike_dw.db/product_kpi';

-- Validate
SELECT * FROM bike_dw.product_kpi_ext
ORDER BY revenue DESC;

-- =========================================
-- 5. OPTIONAL: CUSTOMER KPI TABLE
-- =========================================

CREATE EXTERNAL TABLE bike_dw.customer_kpi_ext (
customer_id INT,
spending DOUBLE
)
STORED AS PARQUET
LOCATION '/user/hive/warehouse/bike_dw.db/customer_kpi';

-- Validate
SELECT * FROM bike_dw.customer_kpi_ext
ORDER BY spending DESC;

-- =========================================
-- 6. SAMPLE ANALYTICAL QUERIES
-- =========================================

-- Total sales across all stores
SELECT SUM(total_sales) AS total_revenue
FROM bike_dw.sales_kpi;

-- Store with highest sales
SELECT store_id, total_sales
FROM bike_dw.sales_kpi
ORDER BY total_sales DESC
LIMIT 1;

-- Top 5 customers
SELECT *
FROM bike_dw.customer_kpi_ext
ORDER BY spending DESC
LIMIT 5;

-- Top 5 products
SELECT *
FROM bike_dw.product_kpi_ext
ORDER BY revenue DESC
LIMIT 5;

-- =========================================
-- END OF FILE
-- =========================================
