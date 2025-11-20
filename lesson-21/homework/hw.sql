CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

select * from ProductSales

--1 - puzzle
select 
ProductName, SaleAmount, SaleDate,
row_number()over (order by saledate) as row_num
from ProductSales

--2 - puzzle
SELECT  
    SaleID,
    SUM(Quantity) AS TotalQuantity,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS SalesRank
FROM ProductSales
GROUP BY SaleID;
 

--3-puzzle
 select * 
 from (
      select 
	  saleid,
	  ProductName,
	  SaleAmount,
	  Quantity,
	  row_number() over (partition by saleid  order by saleamount desc) as salerank
	  from ProductSales
	  )  as ranksales
	  where salerank=1

-- 4-puzzle
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

-- 5 -puzzle
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    Lag(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;

--6-PUZZLE
select *
from(
    SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    Lag(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales) as s
where SaleAmount >  PrevSaleAmount;
--7 - puzzle
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (  ORDER BY SaleDate) AS PrevSaleAmount,
    SaleAmount - LAG(SaleAmount) OVER ( ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;

select * from ProductSales

-- 8 -puzzle
SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
    ROUND(
        ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount) * 100, 
        2
    ) AS PercentChange
FROM ProductSales;

--9-puzzle
SELECT
    Productname,
    SaleID,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY Productname ORDER BY SaleDate) AS PrevSaleAmount,
    ROUND(
        SaleAmount * 1.0 / NULLIF(LAG(SaleAmount) OVER (PARTITION BY Productname ORDER BY SaleDate), 0),
        2
    ) AS SaleRatio
FROM ProductSales;
--10-puzzle
SELECT
    SaleID,
    Productname,
    SaleDate,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY Productname ORDER BY SaleDate) AS DiffFromFirstSale
FROM ProductSales
ORDER BY Productname, SaleDate;

--11-puzzle
WITH SalesWithPrev AS (
    SELECT
        SaleID,
        Productname,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (PARTITION BY Productname ORDER BY SaleDate) AS PrevSaleAmount
    FROM
        ProductSales
)
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount
FROM
    SalesWithPrev
WHERE
    PrevSaleAmount IS NOT NULL
    AND SaleAmount > PrevSaleAmount
ORDER BY
    ProductName,
    SaleDate;

--12-puzzle
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ClosingBalance
FROM ProductSales
ORDER BY ProductName, SaleDate;

--13 - puzzle
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3
FROM
    ProductSales
ORDER BY
    ProductName,
    SaleDate;

--14-puzzzle
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER (PARTITION BY Productname) AS DiffFromAvgPerProduct
FROM ProductSales
ORDER BY ProductName, SaleDate;
