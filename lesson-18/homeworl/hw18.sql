CREATE TABLE Products18 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales18 (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products18(ProductID)
);

INSERT INTO Products18 (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales18 (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

select * from Products18
select * from Sales18

--1-TEMP TABLE (#MonthlySales) yaratish  , u har bir mahsulot uchun joriy oyda sotilgan umumiy miqdor (TotalQuantity) va umumiy daromad (TotalRevenue)ni topish

create table #Monthlysales (
productid int,
totalquantity int,
totalrevenue dec(10,2) )

insert into #Monthlysales(productid, totalquantity, totalrevenue)
select
 s.productid,
 sum(quantity) as totalquantity,
 sum(quantity * p.price) as totalavenue
from Sales18 s
JOIN Products18 p ON s.ProductID = p.ProductID
WHERE MONTH(s.SaleDate) = 4  -- aprel oyi
  AND YEAR(s.SaleDate) = 2025

 group by s.ProductID

 select * from  #Monthlysales

 --2-VIEW (ya’ni saqlanadigan so‘rov) yaratish — u har bir mahsulot uchun jami sotilgan miqdorni ko‘rsatish.

 CREATE VIEW vw_ProductSalesSummary
AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Products18 p
JOIN Sales18 s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;
GO

SELECT * FROM vw_ProductSalesSummary;

-- 3- fn_GetTotalRevenueForProduct nomli funksiya yarating.
--Unga ProductID beriladi, va funksiya shu mahsulot uchun umumiy daromad (Total Revenue) ni qaytaradi.

create function fn_GetTotalRevenueForProduct(@productid int)
returns decimal(18,2)
as
begin
declare @totalrevenue decimal(18,2)
select @totalrevenue = sum (quantity * p.price)
from Sales18 s
join Products18 p on  s.ProductID = p.ProductID
where s.ProductID = @productid;

return @totalrevenue
end;
go

SELECT dbo.fn_GetTotalRevenueForProduct(1) AS TotalRevenue;   -- Samsung Galaxy S23
SELECT dbo.fn_GetTotalRevenueForProduct(5) AS TotalRevenue;   -- Organic Eggs

--4- fn_GetSalesByCategory(@Category VARCHAR(50)) nomli funksiya yarating.
--U berilgan kategoriya bo‘yicha mahsulot nomi, umumiy sotilgan miqdor va umumiy daromadni (TotalRevenue) qaytarsin.

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Sales18 s
    JOIN Products18 p ON s.ProductID = p.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);
GO
SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');
SELECT * FROM dbo.fn_GetSalesByCategory('Groceries');

-- 5 - tub sonni aniqlovchi funksiya
 go
 CREATE FUNCTION fn_IsPrime(@Number INT)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @i INT = 2
    DECLARE @IsPrime BIT = 1

    IF @Number <= 1
        SET @IsPrime = 0
    ELSE
    BEGIN
        WHILE @i <= SQRT(@Number)
        BEGIN
            IF @Number % @i = 0
            BEGIN
                SET @IsPrime = 0
                BREAK
            END
            SET @i = @i + 1
        END
    END

    
    RETURN (CASE WHEN @IsPrime = 1 THEN 'Tub son' ELSE 'Murakkab son' END)
END;
GO

 select dbo.fn_IsPrime(101544451) as tubsonmi


 --6- puzzle
 go
 CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Result TABLE (
    Number INT
)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Result VALUES (@i);
        SET @i = @i + 1;
    END

    RETURN;
END;
GO

SELECT * FROM dbo.fn_GetNumbersBetween(5, 12);

-- 7- puzzle
go
CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    SELECT @result = salary
    FROM (
        SELECT DISTINCT salary,
               ROW_NUMBER() OVER (ORDER BY salary DESC) AS rownum
        FROM Employees
    ) AS t
    WHERE rownum = @N;

    RETURN @result;
END;
GO

SELECT dbo.getNthHighestSalary(2);

CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date)
VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');
 select * from RequestAccepted
 
 -- 8 - puzzle

 SELECT person_id AS id, COUNT(friend_id) AS friendnumber
FROM (
    SELECT requester_id AS person_id, accepter_id AS friend_id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS person_id, requester_id AS friend_id
    FROM RequestAccepted
) AS all_friends
GROUP BY person_id
ORDER BY COUNT(friend_id) DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);
 
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);

 

--9- puzzle
go
CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

select * from  vw_CustomerOrderSummary
select * from Customers
select * from Orders


 

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)

--10-puzzle 
SELECT 
    g1.RowNumber,
    (
        SELECT TOP 1 g2.TestCase
        FROM Gaps g2
        WHERE g2.RowNumber <= g1.RowNumber
          AND g2.TestCase IS NOT NULL
        ORDER BY g2.RowNumber DESC
    ) AS Workflow
FROM Gaps g1
ORDER BY g1.RowNumber;

select * from Gaps
