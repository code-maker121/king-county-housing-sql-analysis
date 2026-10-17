-- King County Housing Market Analysis
-- Source: King County House Sales Dataset (Kaggle)
-- Database: SQLite | Table: housing_sales

-- 1. Basic price statistics
SELECT
    COUNT(*) AS total_sales,
    ROUND(AVG(price), 2) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM housing_sales;

-- 2. Missing SQL NULL values in selected columns
SELECT
    COUNT(*) - COUNT(price) AS missing_price,
    COUNT(*) - COUNT(bedrooms) AS missing_bedrooms,
    COUNT(*) - COUNT(bathrooms) AS missing_bathrooms,
    COUNT(*) - COUNT(sqft_living) AS missing_sqft,
    COUNT(*) - COUNT(zipcode) AS missing_zipcode
FROM housing_sales;

-- 3. Duplicate house ID and sale-date combinations
SELECT
    id,
    date,
    COUNT(*) AS duplicate_count
FROM housing_sales
GROUP BY id, date
HAVING COUNT(*) > 1;

-- 4. Potentially invalid values
SELECT *
FROM housing_sales
WHERE price <= 0
   OR sqft_living <= 0
   OR bedrooms < 0
   OR bathrooms < 0;

-- 5. Bedroom distribution
SELECT
    bedrooms,
    COUNT(*) AS house_count
FROM housing_sales
GROUP BY bedrooms
ORDER BY bedrooms DESC;

-- 6. Average house price by bedrooms (1 to 6)
SELECT
    bedrooms,
    COUNT(*) AS house_count,
    ROUND(AVG(price), 2) AS avg_price
FROM housing_sales
WHERE bedrooms BETWEEN 1 AND 6
GROUP BY bedrooms
ORDER BY bedrooms;

-- 7. Top ZIP codes by average sale price
SELECT
    zipcode,
    COUNT(*) AS house_count,
    ROUND(AVG(price), 2) AS avg_price
FROM housing_sales
GROUP BY zipcode
ORDER BY avg_price DESC
LIMIT 10;

-- 8. Average price by living area group
SELECT
    CASE
        WHEN sqft_living < 1000 THEN 'Under 1000'
        WHEN sqft_living < 2000 THEN '1000-1999'
        WHEN sqft_living < 3000 THEN '2000-2999'
        WHEN sqft_living < 4000 THEN '3000-3999'
        ELSE '4000+'
    END AS size_group,
    COUNT(*) AS house_count,
    ROUND(AVG(price), 2) AS avg_price
FROM housing_sales
GROUP BY size_group
ORDER BY MIN(sqft_living);

-- 9. Monthly average sale price
SELECT
    SUBSTR(date, 1, 4) || '-' || SUBSTR(date, 5, 2) AS month,
    COUNT(*) AS house_count,
    ROUND(AVG(price), 2) AS avg_price
FROM housing_sales
GROUP BY month
ORDER BY month;

-- 10. Average price per square foot by ZIP code (CTE)
WITH house_prices AS (
    SELECT
        zipcode,
        price * 1.0 / sqft_living AS price_per_sqft
    FROM housing_sales
    WHERE sqft_living > 0
)
SELECT
    zipcode,
    COUNT(*) AS house_count,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM house_prices
GROUP BY zipcode
HAVING COUNT(*) >= 30
ORDER BY avg_price_per_sqft DESC
LIMIT 10;

-- 11. Month-over-month change in average sale price (CTEs + window function)
WITH monthly_prices AS (
    SELECT
        SUBSTR(date, 1, 4) || '-' || SUBSTR(date, 5, 2) AS month,
        AVG(price) AS avg_price
    FROM housing_sales
    GROUP BY month
),
monthly_changes AS (
    SELECT
        month,
        avg_price,
        LAG(avg_price) OVER (ORDER BY month) AS prev_price
    FROM monthly_prices
)
SELECT
    month,
    ROUND(avg_price, 2) AS avg_price,
    ROUND(prev_price, 2) AS prev_price,
    ROUND((avg_price - prev_price) / prev_price * 100, 2) AS mom_change_pct
FROM monthly_changes
ORDER BY month;
