-- EASY TASKS
 -- 1- jadval yaratish va uni 1 dan 1000 gacha sonlar bilan to'ldirish
-- Numbers jadvalini yaratamiz
CREATE TABLE sonlar (
    n INT NOT NULL PRIMARY KEY
);
GO
-- Recursive CTE orqali 1..1000 gacha sonlarni kiritish
WITH NumbersCTE AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM NumbersCTE
    WHERE n < 1000
)
INSERT INTO sonlar (n)
SELECT n FROM NumbersCTE
OPTION (MAXRECURSION 0);  -- 0 => rekursiya chegarasiz (yoki OPTION (MAXRECURSION 1000) ham qo'yish mumkin)
GO
-- Tekshirish
SELECT COUNT(*) AS TotalNumbers FROM sonlar;
SELECT TOP (10) n FROM sonlar ORDER BY n;       -- 1..10
SELECT TOP (10) n FROM sonlar ORDER BY n DESC;  -- 1000..991

 
CREATE TABLE Employees162 (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees162 (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Sales162 (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales162 (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products162 (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products162 (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);

select * from Employees162
select * from Sales162
-- 2 - har bir xodimning umumiy savdosini topish
SELECT e.FirstName, s.TotalSales
FROM Employees162 e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales162
    GROUP BY EmployeeID
) AS s
ON e.EmployeeID = s.EmployeeID;

-- 3-Xodimlarning o‘rtacha (average) maoshini topish uchun CTE (Common Table Expression) yarating
WITH AvgSalaryCTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees162
)
SELECT avg_salary
FROM AvgSalaryCTE;
 

 select * from Sales162
 select * from Products162
 -- 4-Har bir mahsulot (product) uchun eng yuqori sotuv (highest sales)ni topish uchun derived table (ya’ni, ichki jadval)dan foydalangan holda so‘rov yozing
 SELECT p.ProductName, s.maxSales
FROM Products162 p
JOIN (
    SELECT ProductID, max(SalesAmount) AS maxSales
    FROM Sales162
    GROUP BY ProductID
) AS s
ON p.ProductID = s.ProductID;

-- 5- rekursiv CTE (Common Table Expression) yordamida raqamni 1 dan boshlab har safar ikki baravar oshirib borish, va 
--1 000 000 dan kichik bo‘lgan oxirgi qiymatgacha yetkazish
WITH DoubleNumbers AS (
    SELECT 1 AS num           -- Boshlanish qiymati: 1
    UNION ALL
    SELECT num * 2            -- Har safar ikki baravar oshir
    FROM DoubleNumbers
    WHERE num * 2 < 1000000   -- 1 000 000 dan kichik bo‘lishi kerak
)
SELECT num
FROM DoubleNumbers;
--6-CTE (Common Table Expression) yordamida 5 tadan ko‘p sotuv qilgan xodimlarning ismlarini topish
select * from Employees162
select * from Sales162
 

WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS total_sales
    FROM Sales162
    GROUP BY EmployeeID
)
SELECT e.FirstName, s.total_sales
FROM Employees162 e
JOIN SalesCount s ON e.EmployeeID = s.EmployeeID
WHERE s.total_sales > 5;

-- 7-CTE (Common Table Expression) yordamida har bir mahsulotning umumiy sotuv summasini hisoblab, $500 dan ortiq bo‘lgan mahsulotlarni topish
WITH ProductSales AS (
    SELECT productid, SUM(SalesAmount) AS total_sales
    FROM Sales162
    GROUP BY productid
)
SELECT p.productname, ps.total_sales
FROM Products162 p
JOIN ProductSales ps ON p.productid = ps.productid
WHERE ps.total_sales > 500;

select * from Sales162

-- 8-CTE (Common Table Expression) yordamida o‘rtacha maoshdan yuqori maosh oladigan xodimlarni topish
WITH AvgSalaryCTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees162
)
SELECT e.FirstName, e.salary
FROM Employees162 e, AvgSalaryCTE
WHERE e.salary > AvgSalaryCTE.avg_salary;

--MEDIUM TASKS
--1-Derived Table (ichki SELECT) yordamida har bir xodim nechta buyurtma (orders) qilganini hisoblab, eng ko‘p 5 ta xodimni topamiz.
 
Select top 5 e.FirstName
from Employees162 e
JOIN (
    select EmployeeID, count(*) as order_count
	from Sales162
	group by EmployeeID
	) as s
	on e.EmployeeID = s.EmployeeID
	order by s.order_count desc

	--2-Derived Table (ya’ni ichki SELECT natijasidan hosil bo‘lgan vaqtinchalik jadval)
	--yordamida har bir mahsulot toifasi (category) bo‘yicha jami sotuv (sales) summasini topamiz
	select * from Products162
	select * from sales162
 

select p.categoryid, s1.totalsales
from(
    select p.CategoryID, sum(s.SalesAmount) as totalsales
	from Products162 p
	join sales162 s on p.ProductID = s.ProductID
	group by p.CategoryID
	) as s1
join Products162 p  on p.CategoryID = s1.CategoryID
group by p.CategoryID, s1.totalsales
  

CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)

select * from Numbers1

-- 3-rekursiv CTE (Common Table Expression) yordamida har bir sonning faktorialini hisoblash

-- Faktorialni topuvchi rekursiv CTE
WITH FactorialCTE AS (
    SELECT 
        Number AS Num,
        1 AS Counter,
        1 AS Factorial
    FROM Numbers1

    UNION ALL

    SELECT 
        f.Num,
        Counter + 1,
        Factorial * (Counter + 1)
    FROM FactorialCTE f
    WHERE Counter + 1 <= f.Num
)
SELECT 
    Num AS Number,
    MAX(Factorial) AS FactorialValue
FROM FactorialCTE
GROUP BY Num
ORDER BY Num;

-- medium tasks 4
DROP TABLE IF EXISTS Example;

CREATE TABLE Example
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [String] VARCHAR(30) NOT NULL
);

INSERT INTO Example ([String])
VALUES ('123456789'),
       ('abcdefghi');

	   WITH SplitCTE AS (
    -- 1-qadam: boshlang‘ich belgini olish
    SELECT 
        E.Id,
        1 AS Position,
        SUBSTRING(E.[String], 1, 1) AS Character,
        LEN(E.[String]) AS TotalLength
    FROM Example AS E

    UNION ALL

    -- 2-qadam: rekursiv bosqich (har safar bitta belgi oldinga)
    SELECT
        E.Id,
        S.Position + 1 AS Position,
        SUBSTRING(E.[String], S.Position + 1, 1) AS Character,
        S.TotalLength
    FROM SplitCTE AS S
    INNER JOIN Example AS E 
        ON S.Id = E.Id
    WHERE S.Position + 1 <= LEN(E.[String])
)

-- 3-qadam: natijani ko‘rsatish
SELECT 
    S.Id,
    S.Position,
    S.Character
FROM SplitCTE AS S
ORDER BY S.Id, S.Position
OPTION (MAXRECURSION 0);

--5-CTE (Common Table Expression) orqali oylar bo‘yicha sotuvlar farqini (sales difference) hisoblash

WITH SalesByMonth AS (
    SELECT 
        MONTH(saledate) AS MonthNo,
        SUM(salesamount) AS TotalSales
    FROM Sales162
    GROUP BY MONTH(saledate)
)
SELECT 
    s1.MonthNo,
    s1.TotalSales,
    s2.TotalSales AS PrevMonthSales,
    s1.TotalSales - s2.TotalSales AS Difference
FROM SalesByMonth s1
LEFT JOIN SalesByMonth s2
ON s1.MonthNo = s2.MonthNo + 1;

select * from Sales162

--6- Har chorakda (3 oylik davrda) jami sotuv summasi 45 000 dollardan oshgan xodimlarni toping.

SELECT 
    e.FirstName,
    q.Quarter,
    q.TotalSales
FROM Employees162 e
JOIN (
    SELECT 
        employeeid,
        DATEPART(QUARTER, saledate) AS Quarter,
        SUM(salesamount) AS TotalSales
    FROM Sales162
    GROUP BY employeeid, DATEPART(QUARTER, saledate)
) AS q
ON e.EmployeeID = q.employeeid
WHERE q.TotalSales > 45000;
 select * from Employees162

 -- Difficult  tasks
 --1 fibanachi sonlari
 WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS a, 1 AS b  -- boshlanish qiymatlar
    UNION ALL
    SELECT n + 1, b, a + b
    FROM Fibonacci
    WHERE n < 10  -- 10 ta son chiqaramiz
)
SELECT n, b AS FibonacciNumber
FROM Fibonacci;


CREATE TABLE FindSameCharacters1
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters1 VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')
-- 2 -har bir belgisi bir xil bo‘lgan (masalan “aaa”, “111”, “zz”) va uzunligi 1 dan katta bo‘lgan satrlarni topish
select * from FindSameCharacters1

SELECT *
FROM FindSameCharacters1
WHERE LEN(Vals) > 1
AND Vals = REPLICATE(LEFT(Vals, 1), LEN(Vals));

SELECT *
FROM FindSameCharacters1
WHERE LEN(Vals) > 1
AND PATINDEX('%[^' + LEFT(Vals,1) + ']%', Vals) = 0;
-- 3- n gacha bo‘lgan sonlar ketma-ket yozilib borilsin — ya’ni 1, keyin 12, keyin 123 va hokazo

DECLARE @n INT = 5;  -- bu yerda n qiymatini o'zgartirishingiz mumkin

WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(100)) AS seq
    UNION ALL
    SELECT num + 1, CAST(seq + CAST(num + 1 AS VARCHAR(10)) AS VARCHAR(100))
    FROM Numbers
    WHERE num + 1 <= @n
)
SELECT seq
FROM Numbers;

--4 - Oxirgi 6 oy ichida eng ko‘p sotuv qilgan xodimlarni toping
SELECT e.FirstName, s.sales_count
FROM Employees162 e
JOIN (
    SELECT employeeid, COUNT(*) AS sales_count
    FROM Sales162
    WHERE saledate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY employeeid
) s ON e.EmployeeID = s.employeeid
WHERE s.sales_count = (
    SELECT MAX(sales_count)
    FROM (
        SELECT employeeid, COUNT(*) AS sales_count
        FROM Sales162
        WHERE saledate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY employeeid
    ) x
);

select * from Employees162
select * from Sales162

CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )

select * from RemoveDuplicateIntsFromNames

--5 
;WITH Numbers AS (
    SELECT 
        Id,
        SUBSTRING(Vals, 1, 1) AS Digit,
        1 AS n
    FROM RemoveDuplicateIntsFromNames

    UNION ALL

    SELECT 
        r.Id,
        SUBSTRING(r.Vals, n + 1, 1),
        n + 1
    FROM RemoveDuplicateIntsFromNames r
    JOIN Numbers c ON r.Id = c.Id
    WHERE n + 1 <= LEN(r.Vals)
),
Counts AS (
    SELECT 
        Id, 
        Digit, 
        COUNT(*) AS cnt
    FROM Numbers
    GROUP BY Id, Digit
)
SELECT 
    c.Id,
    STRING_AGG(Digit, '') AS CleanedVals
FROM Counts c
WHERE c.cnt > 1       -- faqat 2 martadan ko‘p uchraganlar
GROUP BY c.Id;
