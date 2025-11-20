CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

	select * from sales_data

--1 - puzzle
select 
  customer_id,
  customer_name,
  sale_id,
  unit_price,
  sum(unit_price) over(
  partition by customer_id
  order by customer_id
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
from sales_data


--2-puzzle
 select 
    sale_id,
    customer_name,
    product_category,
    COUNT(sale_id) OVER(PARTITION BY product_category) AS OrdersPerCategory
FROM sales_data
ORDER BY product_category, sale_id;


 --3-puzzle
 select 
  product_category,
  max(total_amount) over (partition by product_category) as maxamount
  from sales_data
  order by product_category, total_amount

  --4-puzzle
   select 
  product_category,
  min(unit_price) over (partition by product_category) as maxamount
  from sales_data
  order by product_category, unit_price

  --5--puzzle
  SELECT
    order_date,
    total_amount,
    ROUND(
        AVG(total_amount) OVER(
            ORDER BY order_date
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        ), 2
    ) AS MovingAvg3Days
FROM sales_data
ORDER BY order_date;

--6-puzzle
SELECT
    sale_id,
    customer_name,
    region,
    total_amount,
    SUM(total_amount) OVER(PARTITION BY region) AS TotalSalesPerRegion
FROM sales_data
ORDER BY region, sale_id;

--7-puzzle
SELECT
    customer_name,
    SUM(total_amount) AS TotalPurchase,
    RANK() OVER(ORDER BY SUM(total_amount) DESC) AS PurchaseRank
FROM sales_data
GROUP BY customer_name
ORDER BY PurchaseRank;

--8-puzzle
SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount AS CurrentSale,
    LAG(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS PreviousSale,
    total_amount - LAG(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS Difference
FROM sales_data
ORDER BY customer_id, order_date;

--9-puzzle
select * 
from (
select 
   product_name,
   product_category,
   total_amount,
   rank() over ( partition by  product_category order by total_amount desc) as pricerank
from sales_data)  as ranked

 where pricerank<=3
 order by product_category, pricerank 

 --10-puzzle
 SELECT
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER(
        PARTITION BY region
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeSales
FROM sales_data
ORDER BY region, order_date;

--11-puzzle
SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM sales_data
ORDER BY product_category, order_date;

--12-puzzle
SELECT
    product_name,
     SUM(sale_id) OVER (
        ORDER BY sale_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM sales_data
 
 --13-puzzle
 go
WITH CustomerCategoryCount AS (
    SELECT
        customer_id,
        customer_name,
        COUNT(DISTINCT product_category) AS NumCategories
    FROM sales_data
    GROUP BY customer_id, customer_name
)
SELECT *
FROM CustomerCategoryCount
WHERE NumCategories > 1
ORDER BY customer_name;

 --15-puzzle
WITH CustomerTotal AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS TotalSpending
    FROM sales_data
    GROUP BY customer_id, customer_name, region
),
CustomerWithAvg AS (
    SELECT
        *,
        AVG(TotalSpending) OVER (PARTITION BY region) AS AvgSpendingInRegion
    FROM CustomerTotal
)
SELECT
    customer_id,
    customer_name,
    region,
    TotalSpending,
    AvgSpendingInRegion
FROM CustomerWithAvg
WHERE TotalSpending > AvgSpendingInRegion
ORDER BY region, TotalSpending DESC;

 --16-puzzle
 WITH CustomerTotal AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS TotalSpending
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)

SELECT
    customer_id,
    customer_name,
    region,
    TotalSpending,
	  RANK() OVER(
        PARTITION BY region
        ORDER BY TotalSpending DESC
    ) AS RankInRegion
FROM CustomerTotal
 
ORDER BY region, RankInRegion;
 

 --17-puzzle
 SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;

--18-puzzle
 ;

select * from sales_data

--19-puzzle
WITH CustomerOrders AS (
    SELECT
        sale_id,
        customer_id,
        customer_name,
        order_date,
        total_amount,
        LAG(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS PreviousOrderAmount
    FROM sales_data
)
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    PreviousOrderAmount
FROM CustomerOrders
WHERE PreviousOrderAmount IS NOT NULL
  AND total_amount > PreviousOrderAmount
ORDER BY customer_id, order_date;

--20-puzzle
SELECT
    product_name,
    product_category,
    unit_price,
    AVG(unit_price) OVER () AS avg_price_all
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price) FROM sales_data
)
ORDER BY unit_price DESC;

--21-puzzle
CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

select * from mydata
