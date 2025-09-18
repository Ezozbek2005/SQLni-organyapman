-- Easy level task
1. BULK INSERT — tashqi fayldan (CSV, TXT, Excel) katta hajmdagi ma’lumotlarni SQL Server jadvaliga tez yuklash uchun ishlatiladi.

2. sql shu 4 ta turni export qiladi  CSV,TXT,Excel,(XLS/XLSX), XML

3.  CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

4. INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 1200.50),
(2, 'Smartphone', 800.00),
(3, 'Tablet', 450.75);

5. NULL  qiymat yo'qligini bildiradi (bo'sh).

NOT NULL ustun bo'sh qoldirilishi mumkin emas.'

6.ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

7. -- Bu query barcha mahsulotlarni chiqaradi
SELECT * FROM Products;

8.ALTER TABLE Products
ADD CategoryID INT;

9.CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

10.  Javob:
IDENTITY ustuni avtomatik raqam beradi (1, 2, 3, ...). Har safar yangi qator qo'shilganda qiymatni o'zi belgilaydi.

-- Medium Level tasks

1.BULK INSERT Products
FROM 'C:\Users\user\Desktop\products.txt'
WITH (
    FIELDTERMINATOR = ',',   -- ustunlarni ajratish belgisi
    ROWTERMINATOR = '\n',    -- qatorlarni ajratish belgisi
    FIRSTROW = 2             -- agar birinchi qatorda sarlavha bo‘lsa
);
 2.ALTER TABLE Products
ADD CategoryID INT;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

3.PRIMARY KEY:

Har doim noyob bo‘ladi

NULL qabul qilmaydi

Jadvalda faqat bitta PRIMARY KEY bo‘ladi

UNIQUE KEY:

Qiymatlar takrorlanmaydi, lekin bitta NULL bo‘lishi mumkin

Jadvalda bir nechta UNIQUE KEY bo‘lishi mumkin

4.ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

5.ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

6.SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

--7.FOREIGN KEY boshqa jadvaldagi PRIMARY KEY yoki UNIQUE KEY ga bog‘lanadi.

--Jadval orasida mantiqiy bog‘lanish yaratadi.

--Masalan:

--Products jadvalidagi CategoryID → Categories jadvalidagi CategoryID ga bog‘lanadi.

--Shunda mahsulot faqat mavjud kategoriyaga tegishli bo‘ladi.

-- Hard Level tasks

1.CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18)
);

2.CREATE TABLE ExampleIdentity (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    ItemName VARCHAR(50)
);

3.CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

4.--ISNULL(expression, replacement) → Agar qiymat NULL bo‘lsa, replacement bilan almashtiradi.

SELECT ISNULL(NULL, 0);  -- 0 qaytaradi


--COALESCE(expr1, expr2, expr3, ...) → Birinchi NULL bo‘lmagan qiymatni qaytaradi.

SELECT COALESCE(NULL, NULL, 5, 10);  -- 5 qaytaradi


 Farqi: ISNULL faqat 2 ta qiymat bilan ishlaydi, COALESCE esa bir nechta argumentni tekshiradi.

 5.CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

6.CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

--ON DELETE CASCADE → Customers jadvalidan biror mijoz o‘chirilib ketsa, Orders jadvalidagi unga tegishli buyurtmalar ham avtomatik o‘chiriladi.

--ON UPDATE CASCADE → Customers jadvalidagi CustomerID yangilansa, Orders jadvalidagi mos qiymat ham yangilanadi.



