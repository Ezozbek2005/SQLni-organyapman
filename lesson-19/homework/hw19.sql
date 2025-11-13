CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE DepartmentBonus (
    Department NVARCHAR(50) PRIMARY KEY,
    BonusPercentage DECIMAL(5,2)
);

INSERT INTO Employees VALUES
(1, 'John', 'Doe', 'Sales', 5000),
(2, 'Jane', 'Smith', 'Sales', 5200),
(3, 'Mike', 'Brown', 'IT', 6000),
(4, 'Anna', 'Taylor', 'HR', 4500);

INSERT INTO DepartmentBonus VALUES
('Sales', 10),
('IT', 15),
('HR', 8);

CREATE TABLE Products_Current (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Products_New (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO Products_Current VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 600),
(3, 'Smartphone', 800);

INSERT INTO Products_New VALUES
(2, 'Tablet Pro', 700),
(3, 'Smartphone', 850),
(4, 'Smartwatch', 300);


CREATE TABLE   Tree (id INT, p_id INT);
TRUNCATE TABLE Tree;
INSERT INTO Tree (id, p_id) VALUES (1, NULL);
INSERT INTO Tree (id, p_id) VALUES (2, 1);
INSERT INTO Tree (id, p_id) VALUES (3, 1);
INSERT INTO Tree (id, p_id) VALUES (4, 2);
INSERT INTO Tree (id, p_id) VALUES (5, 2);


-- ===============================
-- 1. Jadval mavjud bo'lsa o'chiramiz
-- ===============================
IF OBJECT_ID('Confirmations', 'U') IS NOT NULL DROP TABLE Confirmations;
IF OBJECT_ID('Signups', 'U') IS NOT NULL DROP TABLE Signups;

-- ===============================
-- 2. Jadval yaratish
-- ===============================
CREATE TABLE Signups (
    user_id INT,
    time_stamp DATETIME
);

CREATE TABLE Confirmations (
    user_id INT,
    time_stamp DATETIME,
    action NVARCHAR(20) CHECK (action IN ('confirmed','timeout'))
);

-- ===============================
-- 3. Signups jadvaliga ma'lumot kiritish
-- ===============================
INSERT INTO Signups (user_id, time_stamp) VALUES 
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

-- ===============================
-- 4. Confirmations jadvaliga ma'lumot kiritish
-- ===============================
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES 
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

-- ===============================
-- 5. Natijani tekshirish
-- ===============================
SELECT * FROM Signups;
SELECT * FROM Confirmations;


CREATE TABLE employees19 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees19 (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);
 select * from employees19

 -- Products Table
CREATE TABLE Products19 (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

-- Sales Table
CREATE TABLE Sales19 (
    SaleID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    SaleDate DATE
);

INSERT INTO Products19 (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop Model A', 'Electronics', 1200),
(2, 'Laptop Model B', 'Electronics', 1500),
(3, 'Tablet Model X', 'Electronics', 600),
(4, 'Tablet Model Y', 'Electronics', 700),
(5, 'Smartphone Alpha', 'Electronics', 800),
(6, 'Smartphone Beta', 'Electronics', 850),
(7, 'Smartwatch Series 1', 'Wearables', 300),
(8, 'Smartwatch Series 2', 'Wearables', 350),
(9, 'Headphones Basic', 'Accessories', 150),
(10, 'Headphones Pro', 'Accessories', 250),
(11, 'Wireless Mouse', 'Accessories', 50),
(12, 'Wireless Keyboard', 'Accessories', 80),
(13, 'Desktop PC Standard', 'Computers', 1000),
(14, 'Desktop PC Gaming', 'Computers', 2000),
(15, 'Monitor 24 inch', 'Displays', 200),
(16, 'Monitor 27 inch', 'Displays', 300),
(17, 'Printer Basic', 'Office', 120),
(18, 'Printer Pro', 'Office', 400),
(19, 'Router Basic', 'Networking', 70),
(20, 'Router Pro', 'Networking', 150);

INSERT INTO Sales19 (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-15'),
(2, 1, 1, '2024-02-10'),
(3, 1, 3, '2024-03-08'),
(4, 2, 1, '2024-01-22'),
(5, 3, 5, '2024-01-20'),
(6, 5, 2, '2024-02-18'),
(7, 5, 1, '2024-03-25'),
(8, 6, 4, '2024-04-02'),
(9, 7, 2, '2024-01-30'),
(10, 7, 1, '2024-02-25'),
(11, 7, 1, '2024-03-15'),
(12, 9, 8, '2024-01-18'),
(13, 9, 5, '2024-02-20'),
(14, 10, 3, '2024-03-22'),
(15, 11, 2, '2024-02-14'),
(16, 13, 1, '2024-03-10'),
(17, 14, 2, '2024-03-22'),
(18, 15, 5, '2024-02-01'),
(19, 15, 3, '2024-03-11'),
(20, 19, 4, '2024-04-01');

--1- ishcilarni oyligiga foiz qo'shish
 go
create  PROCEDURE CalculateEmployeeBonus
     
AS
BEGIN
    -- 1️⃣ Vaqtincha jadval yaratish
    CREATE TABLE #EmployeeBonus
    (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
		BonusPercentage DECIMAL(5,2),
        BonusAmount DECIMAL(10,2)
    );

    -- 2️⃣ Ma'lumotlarni jadvalga qo'shish
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount, BonusPercentage )
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
		d.BonusPercentage,
        e.Salary * d.BonusPercentage / 100 AS BonusAmount
    FROM Employees e  -- Bu yerda sizning asosiy xodimlar jadvali nomi
	join DepartmentBonus d  on e.Department = d.Department;

    -- 3️⃣ Natijani chiqarish
    SELECT * FROM #EmployeeBonus;

    -- 4️⃣ Vaqtincha jadvalni o'chirish (ixtiyoriy, session tugaganda avtomatik o'chadi)
    DROP TABLE #EmployeeBonus;
END;

EXEC CalculateEmployeeBonus  
 

--2-puzzle
CREATE PROCEDURE IncreaseDepartmentSalary
    @DepartmentName NVARCHAR(50),
    @IncreasePercentage DECIMAL(5,2)  -- Masalan, 10.00 = 10%
AS
BEGIN
    -- 1️⃣ Tanlangan bo‘limdagi xodimlarning maoshini yangilash
    UPDATE Employees
    SET Salary = Salary *(1+ @IncreasePercentage / 100)
    WHERE Department = @DepartmentName;

    -- 2️⃣ Yangilangan xodimlarni chiqarish
    SELECT EmployeeID, 
           FirstName, 
           LastName, 
           Department, 
           Salary
    FROM Employees
    WHERE Department = @DepartmentName;
END;

EXEC IncreaseDepartmentSalary 
    @DepartmentName = 'Sales', 
    @IncreasePercentage = 10.00;
	select * from Employees
select * from DepartmentBonus


--3-puzzle
select * from Products_Current
select * from  Products_New

MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- 1️⃣ Agar ProductID mos kelsa → UPDATE
WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- 2️⃣ Agar ProductID yangi jadvalda bor, lekin eski jadvalda yo‘q → INSERT
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- 3️⃣ Agar ProductID eski jadvalda bor, lekin yangi jadvalda yo‘q → DELETE
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- 4️⃣ Yakuniy holatni ko‘rish
SELECT * FROM Products_Current;

--4-puzzle

SELECT
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN c.id IS NOT NULL THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree t
LEFT JOIN Tree c
    ON t.id = c.p_id
GROUP BY t.id, t.p_id, c.id;

SELECT 
    t1.id,
    CASE
        WHEN t1.p_id IS NULL THEN 'Root'  -- Hech kimga bo‘ysunmaydi
        WHEN t2.id IS NOT NULL THEN 'Inner'  -- Kimningdir ota-si (ya’ni boshqa satrda p_id = t1.id)
        ELSE 'Leaf'  -- Bolasi yo‘q, o‘zi esa boshqa birining bolasi
    END AS type
FROM Tree t1
LEFT JOIN Tree t2
    ON t1.id = t2.p_id  -- t1 (ota) va t2 (bola)
GROUP BY t1.id, t1.p_id, t2.id;

--5-puzzle
SELECT 
    s.user_id,
    ISNULL(
        CAST(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 
             / NULLIF(COUNT(c.user_id), 0) AS DECIMAL(5,2)),
        0
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c 
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;


SELECT * FROM Signups;
SELECT * FROM Confirmations;

--6-puzzle
select * 
from employees19 
where Salary = (select min(Salary) from employees19  )

--7-puzzle

CREATE or alter PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        P.ProductName,
        SUM(S.Quantity) AS TotalQuantity,
        SUM(S.Quantity * P.Price) AS TotalAmount,
        MIN(S.SaleDate) AS FirstSaleDate,
        MAX(S.SaleDate) AS LastSaleDate
    FROM Products19 P
    LEFT JOIN Sales19 S ON P.ProductID = S.ProductID
    WHERE P.ProductID = @ProductID
    GROUP BY P.ProductName
END;

EXEC GetProductSalesSummary @ProductID = 1;
 
select * from sales19
select * from Products19
