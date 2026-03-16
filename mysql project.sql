CREATE DATABASE project;
DROP DATABASE project;
use  project;
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales(
  transactions_id VARCHAR(50),
  sale_date VARCHAR(50),
  sale_time VARCHAR(50),
  customer_id VARCHAR(50),
  gender VARCHAR(50),
  age VARCHAR(50),
  category VARCHAR(50),
  quantity VARCHAR(50),
  price_per_unit VARCHAR(50),
  cogs VARCHAR(50),
  total_sale VARCHAR(50)
);
SELECT COUNT(*) FROM retail_sales;
SHOW TABLES;
SELECT COUNT(*) FROM retail_sales;
SELECT * FROM retail_sales LIMIT 2000;

SELECT *
FROM retail_sales
WHERE transactions_id = ''
   OR sale_date = ''
   OR sale_time = ''
   OR customer_id = ''
   OR gender = ''
   OR age = ''
   OR category = ''
   OR quantity = ''
   OR price_per_unit = ''
   OR cogs = ''
   OR total_sale = '';
 
 SELECT COUNT(*) AS total_sale
FROM retail_sales;
-- HOW MANY SALES IN TOTAL WE HAVE ?

SELECT COUNT(*) AS total_sales
FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;

select*from retail_sales
where sale_date= '2022-11-05';

SELECT COALESCE(SUM(total_sale), 0) AS total_sales_sum
FROM retail_sales
WHERE LOWER(TRIM(category)) = 'clothing'
  AND quantity > 10
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

SELECT *
FROM retail_sales
WHERE LOWER(TRIM(category)) = 'clothing'
  AND quantity > 10
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
  
  SELECT COUNT(*)
FROM retail_sales
WHERE LOWER(TRIM(category)) = 'clothing';

 SELECT COUNT(*)
FROM retail_sales
WHERE LOWER(TRIM(category)) = 'clothing'
AND quantity >=4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

SELECT *
FROM retail_sales
WHERE LOWER(TRIM(category)) = 'clothing'
  AND quantity >= 4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

SELECT category,
       COUNT(*) AS total_orders,
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

SELECT ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE LOWER(TRIM(category)) = 'beauty';

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

SELECT category,
       gender,
       COUNT(*) AS total_transactions,
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender;

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale), 2) AS average_monthly_sale
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month_number,
    MONTHNAME(sale_date) AS month,
    AVG(total_sale) AS avg_monthly_sales,
    RANK() OVER (
        PARTITION BY YEAR(sale_date)
        ORDER BY AVG(total_sale) DESC
    ) AS year_rank
FROM retail_sales
GROUP BY 
    YEAR(sale_date), 
    MONTH(sale_date), 
    MONTHNAME(sale_date);

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;

SELECT 
    CASE 
        WHEN HOUR(sale_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift
ORDER BY total_orders DESC;
