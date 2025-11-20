CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')


CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

CREATE TABLE Orders1 (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders1 (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)
select * from Family
select * from Fruits
select * from #Sales

--1-puzzle
SELECT c.SaleID, c.CustomerName,c.SaleDate
FROM #Sales c
WHERE EXISTS (
    SELECT 1
    FROM #Sales o
    WHERE o.SaleID = c.Saleid
      AND o.SaleDate >= '2024-03-01'
      AND o.SaleDate < '2024-04-01'
);

--2-puzzle
SELECT Product , TotalRevenue
FROM (
    SELECT Product, SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product 
) AS t
WHERE TotalRevenue = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product 
    ) AS x
);

--3-puzzle

SELECT MAX(price*quantity) AS SecondHighest
FROM #Sales
WHERE price*quantity < (
    SELECT MAX(price*quantity)
    FROM #Sales
);
 --4-puzzle

 SELECT DISTINCT
    FORMAT(s1.SaleDate, 'yyyy-MM') AS SaleMonth,
    (
        SELECT SUM(s2.Quantity)
        FROM #Sales s2
        WHERE FORMAT(s2.SaleDate, 'yyyy-MM') = FORMAT(s1.SaleDate, 'yyyy-MM')
    ) AS TotalQuantity
FROM #Sales s1
ORDER BY SaleMonth;

--5-PUZZLE
 SELECT DISTINCT s1.Customername
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);

--6-puzzle
SELECT Name, [Apple], [Orange], [Banana]
FROM (
    SELECT Name, Fruit, COUNT(*) AS FruitCount
    FROM Fruits
    GROUP BY Name, Fruit
) AS SourceTable
PIVOT (
    SUM(FruitCount)
    FOR Fruit IN ([Apple], [Banana], [Orange])
) AS PivotTable
ORDER BY Name;

--7-puzzle
WITH FamilyCTE AS (
    -- 1️⃣ Boshlang‘ich (bevosita ota-bola juftliklari)
    SELECT ParentId, ChildId
    FROM Family

    UNION ALL

    -- 2️⃣ Rekursiv qism (ota → nabira → evara ...)
    SELECT f.ParentId, c.ChildId
    FROM Family f
    INNER JOIN FamilyCTE c
        ON f.ChildId = c.ParentId
)
SELECT *
FROM FamilyCTE
ORDER BY ParentId, ChildId;

select * from Family

--8-puzzle
select customerid, DeliveryState, Amount
from #Orders o 
where o.DeliveryState ='tx' and  
 exists
 (
 select 1
 from #Orders c
 where  o.CustomerID = c.CustomerID
 and c.DeliveryState = 'ca')
select * from #Orders

--9-puzzle
UPDATE #Residents
SET fullname = 
    SUBSTRING(address, 
               CHARINDEX('name=', address) + 5,
               CHARINDEX(' age', address) - CHARINDEX('name=', address) - 5)
WHERE fullname IS NULL 
  AND address LIKE '%name=%';

select * from #residents


--10-puzzle
go
WITH RouteCTE AS (
    -- Boshlang'ich shahar
    SELECT 
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    
    UNION ALL
    
    -- Keyingi shaharlar
    SELECT 
        r.DepartureCity,
        r.ArrivalCity,
        CAST(c.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)) AS Route,
        c.Cost + r.Cost
    FROM #Routes r
    INNER JOIN RouteCTE c ON r.DepartureCity = c.ArrivalCity
    WHERE CHARINDEX(r.ArrivalCity, c.Route) = 0  -- sikllardan qochish
)
SELECT TOP 1 WITH TIES
    Route,
    Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost desc; -- eng arzon uchun


select * from #Routes

--11-puzzle

SELECT 
    ID,
    Vals,
    'Product ' + CAST(SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
                      OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS VARCHAR(10)) AS ProductGroup
FROM #RankingPuzzle;


select * from #RankingPuzzle

SELECT *,
       ROW_NUMBER() OVER (ORDER BY ID) AS Rank
FROM #RankingPuzzle;


--12-puzzle
select * from #EmployeeSales

SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
)
ORDER BY e.Department, e.SalesAmount DESC;

--13-puzzle
SELECT e1.EmployeeID, e1.EmployeeName, e1.Department, e1.SalesAmount, e1.SalesMonth, e1.SalesYear
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.Department = e1.Department
      AND e2.SalesMonth = e1.SalesMonth
      AND e2.SalesYear = e1.SalesYear
      AND e2.SalesAmount > e1.SalesAmount
)
ORDER BY e1.SalesMonth, e1.SalesAmount DESC;

--14-puzzle
select distinct  e1.EmployeeName, e1.Department
from #EmployeeSales e1
where not exists (
select 1
from ( select distinct  SalesMonth from #EmployeeSales)
   as m
where not exists (
select 1
from #EmployeeSales e2
where e1.EmployeeName = e2.EmployeeName
   and e2.SalesMonth = m.SalesMonth)
   );


select * from #EmployeeSales

--15-puzzle
 select name,price
 from products
 where price > ( 
    select avg(price) 
	from Products)

--16-puzzle

SELECT Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);
select * from Products

--17-puzzle
select name, Category
from Products
where Category = (
  select category
  from Products
  where name = 'Laptop')
--18-puzzle
select name, Category,Price
from Products
where Price >(
  select min(price)
  from Products
  where Category = 'Electronics ')  

  --19-puzzle
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p.Category
);

-- 20-puzzle
SELECT DISTINCT p.ProductID, p.Name, p.Category, p.Price, p.Stock
FROM Products p
JOIN Orders1 o ON p.ProductID = o.ProductID;


select * from Orders1
select * from Products

--21-puzzle
SELECT DISTINCT p.Name, o.Quantity
FROM Orders1 o
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > (
    SELECT AVG(Quantity)
    FROM Orders1
);

--22-puzzle
SELECT p.Name
FROM Products p
LEFT JOIN Orders1 o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

--23-puzzle
SELECT TOP 1 
    p.Name,
    SUM(o.Quantity) AS TotalOrdered
FROM Orders1 o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalOrdered DESC;

