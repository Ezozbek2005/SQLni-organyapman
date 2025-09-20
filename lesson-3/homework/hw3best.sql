/* ============================
   LESSON-3 SQL TASKS
   ============================ */

-- ============================
-- EASY LEVEL TASKS
-- ============================

-- 1. BULK INSERT izohi:
-- BULK INSERT tashqi fayldan (CSV, TXT va boshqalar) katta hajmdagi ma'lumotlarni tez yuklaydi

-- 2. Import formatlari (to‘g‘rilangan):
-- SQL Server BULK INSERT orqali quyidagi fayl formatlarini qabul qiladi:
-- CSV, TXT, XML, JSON

-- 3. Products jadvalini yaratish
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 4. Ma’lumot qo‘shish
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 1200.50),
(2, 'Smartphone', 800.00),
(3, 'Tablet', 450.75);

-- 5. NULL va NOT NULL izohi:
-- NULL = qiymat yo‘q
-- NOT NULL = ustun bo‘sh qoldirilishi mumkin emas

-- 6. UNIQUE constraint qo‘shish
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

-- 7. Barcha mahsulotlarni chiqarish
SELECT * FROM Products;

-- 8. Products jadvaliga CategoryID qo‘shish
ALTER TABLE Products
ADD CategoryID INT;

-- 9. Categories jadvalini yaratish
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- 10. IDENTITY tushuntirish:
-- IDENTITY ustuni avtomatik tartibda raqam beradi (1, 2, 3, ...)


-- ============================
-- MEDIUM LEVEL TASKS
-- ============================

-- 1. BULK INSERT misoli
BULK INSERT Products
FROM 'C:\Users\user\Desktop\products.txt'
WITH (
    FIELDTERMINATOR = ',',   -- ustunlarni ajratish belgisi
    ROWTERMINATOR = '\n',    -- qatorlarni ajratish belgisi
    FIRSTROW = 2             -- agar birinchi qatorda sarlavha bo‘lsa
);

-- 2. FOREIGN KEY qo‘shish
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- 3. PRIMARY KEY vs UNIQUE KEY izohi:
-- PRIMARY KEY: faqat 1 ta, NULL bo‘lmaydi, noyob
-- UNIQUE KEY: bir nechta bo‘lishi mumkin, NULL qabul qiladi

-- 4. CHECK constraint (narx > 0 bo‘lishi shart)
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- 5. Stock ustuni qo‘shish
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- 6. ISNULL ishlatish
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- 7. FOREIGN KEY izohi va kod bilan
-- Products jadvalidagi CategoryID → Categories jadvalidagi CategoryID ga bog‘lanadi
-- Bu jadval orasida mantiqiy bog‘lanish yaratadi


-- ============================
-- HARD LEVEL TASKS
-- ============================

-- 1. Customers jadvali (Age >= 18 bo‘lishi kerak)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18)
);

-- 2. Identity ustuni (100 dan boshlanib, 10 qadam bilan oshadi)
CREATE TABLE ExampleIdentity (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    ItemName VARCHAR(50)
);

-- 3. Composite PRIMARY KEY
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

-- 4. ISNULL va COALESCE amalda
CREATE TABLE Salaries (
    EmpID INT PRIMARY KEY,
    Bonus DECIMAL(10,2) NULL,
    Extra DECIMAL(10,2) NULL
);

INSERT INTO Salaries VALUES
(1, 500, NULL),
(2, NULL, 200),
(3, NULL, NULL);

-- ISNULL (NULL bo‘lsa, 0 chiqaradi)
SELECT EmpID, ISNULL(Bonus, 0) AS BonusAmount
FROM Salaries;

-- COALESCE (birinchi NULL bo‘lmagan qiymatni oladi)
SELECT EmpID, COALESCE(Bonus, Extra, 100) AS FinalPay
FROM Salaries;

-- 5. Employees jadvali (Email UNIQUE bo‘lishi kerak)
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- 6. Orders jadvali FOREIGN KEY bilan (CASCADE qo‘llanadi)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Izoh:
-- ON DELETE CASCADE → Customers dan mijoz o‘chsa, Orders dagi buyurtmalari ham o‘chadi
-- ON UPDATE CASCADE → Customers dagi ID yangilansa, Orders dagi mos qiymat ham yangilanadi
