CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

select * from #RegionSales


CREATE TABLE Employee17 (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee17;
INSERT INTO Employee17 VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);
select * from Employee17
--1-puzzle
-- 1. Barcha unikal regionlarni olamiz
go
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
-- 2. Barcha unikal distributorlarni olamiz
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
-- 3. Har bir distributor × region kombinatsiyasini hosil qilamiz
DistributorRegion AS (
    SELECT d.Distributor, r.Region
    FROM Distributors d
    CROSS JOIN Regions r
)
-- 4. Original sales bilan LEFT JOIN qilamiz, bo'sh qiymatni 0 qilamiz
SELECT 
    dr.Region,
    dr.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM DistributorRegion dr
LEFT JOIN #RegionSales rs
    ON dr.Distributor = rs.Distributor
   AND dr.Region = rs.Region
ORDER BY dr.Distributor, dr.Region;


--2-puzzle
SELECT 
    m.ID,
    m.Name,
    COUNT(e.ID) AS DirectReports
FROM Employees17 m
JOIN Employees17 e
    ON m.id = e.ManagerID
GROUP BY m. ID, m.Name
HAVING COUNT(e.ID) >= 5;

SELECT 
    m.name AS ManagerName,
    COUNT(e.id) AS DirectReports
FROM Employee17 m
JOIN Employee17 e
    ON m.id = e.managerId
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;

select * from Employee17

--3-puzzle  
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select * from Products
select * from Orders

SELECT 
    p.product_name,
    SUM(o.unit) AS amount
FROM Products p
JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' 
  AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


--4-puzzle
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

select * from Orders
WITH VendorOrders AS (
    SELECT 
        customerid,
        vendor,
        COUNT(*) AS order_count,
        ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY COUNT(*) DESC) AS rn
    FROM Orders
    GROUP BY customerid, vendor
)
SELECT 
    customerid,
    vendor
FROM VendorOrders
WHERE rn = 1;

--5-puzzle
DECLARE @Check_Prime INT = 91;  -- you can change this number
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;       -- assume it’s prime

WHILE @i*@i <= @Check_Prime 
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;       -- not prime
        BREAK;                  -- exit loop early
    END
    SET @i = @i + 1;
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--6-puzzle
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

select * from Device
go
WITH SignalCount AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS Signal_Count
    FROM Device
    GROUP BY Device_id, Locations
),
MaxSignal AS (
    SELECT 
        Device_id,
        MAX(Signal_Count) AS Max_Signal
    FROM SignalCount
    GROUP BY Device_id
)
SELECT 
    sc.Device_id,
    COUNT(DISTINCT sc.Locations) AS no_of_location,
    MAX(CASE WHEN sc.Signal_Count = ms.Max_Signal THEN sc.Locations END) AS max_signal_location,
    SUM(sc.Signal_Count) AS no_of_signals
FROM SignalCount sc
JOIN MaxSignal ms
    ON sc.Device_id = ms.Device_id
GROUP BY sc.Device_id;

--7-puzzle
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select * from Employee

SELECT 
    EmpID,
    EmpName,
    Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

--8-puzzle
CREATE TABLE Numbers (
    Number INT
);

CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);
-- G'olib raqamlar
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);

-- Har bir ticketdagi raqamlar
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),   -- bu ticketda 3 tadan 3 tasi mos → 100$
('B35643', 25),
('B35643', 45),
('B35643', 98),   -- bu ticketda 2 ta mos → 10$
('C98787', 67),
('C98787', 86),
('C98787', 91);   -- bu ticketda 0 ta mos → 0$

-- 1. Avval g'olib raqamlar sonini o'zgaruvchiga saqlaymiz
DECLARE @WinningCount INT;
SELECT @WinningCount = COUNT(*) FROM Numbers;

-- 2. Hisoblash
WITH TicketMatch AS (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT n.Number) AS MatchedNumbers
    FROM Tickets t
    LEFT JOIN Numbers n 
        ON t.Number = n.Number
    GROUP BY t.TicketID
)
SELECT 
    SUM(
        CASE 
            WHEN MatchedNumbers = @WinningCount THEN 100
            WHEN MatchedNumbers BETWEEN 1 AND @WinningCount - 1 THEN 10
            ELSE 0
        END
    ) AS Total_Winnings
FROM TicketMatch;

--9-puzzle
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);
select * from Spending
SELECT
    ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
    Spend_date,
    Platform,
    SUM(TotalAmount) AS Total_Amount,
    COUNT(User_id) AS Total_users
FROM (
    -- Har bir user va sana bo'yicha jami summani hisoblaymiz
    SELECT
        Spend_date,
        User_id,
        -- Platform turini aniqlaymiz
        CASE 
            WHEN SUM(CASE WHEN Platform='Mobile' THEN 1 ELSE 0 END) > 0
             AND SUM(CASE WHEN Platform='Desktop' THEN 1 ELSE 0 END) > 0
                THEN 'Both'
            WHEN SUM(CASE WHEN Platform='Mobile' THEN 1 ELSE 0 END) > 0
                THEN 'Mobile'
            ELSE 'Desktop'
        END AS Platform,
        SUM(Amount) AS TotalAmount
    FROM Spending
    GROUP BY Spend_date, User_id
) AS UserSummary
GROUP BY Spend_date, Platform
ORDER BY Spend_date, Platform;


--10-puzzle
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

select * from Grouped

-- Maksimal quantityni o'zgaruvchiga olamiz
DECLARE @MaxQuantity INT;
SELECT @MaxQuantity = MAX(Quantity) FROM Grouped;

-- Recursive CTE
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n + 1 <= @MaxQuantity
)
SELECT 
    g.Product,
    1 AS Quantity
FROM Grouped g
JOIN Numbers n
    ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
