DROP TABLE Employees;
DROP TABLE products;
DROP TABLE Customers;



-- Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    DepartmentName VARCHAR(50),
    Salary DECIMAL(10,2),
    Email VARCHAR(100)
);

INSERT INTO Employees VALUES
(1, 'Ali', 'Karimov', 28, 'HR', 55000, NULL),
(2, 'Aziza', 'Saidova', 35, 'IT', 75000, 'aziza@company.com'),
(3, 'Bekzod', 'Tursunov', 42, 'Finance', 68000, 'bekzod@company.com'),
(4, 'Dilshod', 'Abdullaev', 31, 'Marketing', 62000, NULL),
(5, 'Madina', 'Olimova', 26, 'HR', 61000, 'madina@company.com'),
(6, 'Kamol', 'Nazarov', 39, 'IT', 90000, 'kamol@company.com'),
(7, 'Asal', 'Rustamova', 41, 'Marketing', 58000, NULL),
(8, 'Otabek', 'Shukurov', 33, 'Finance', 72000, 'otabek@company.com'),
(9, 'Gulnoza', 'Ibragimova', 29, 'HR', 50000, NULL),
(10, 'Sherzod', 'Yusupov', 45, 'IT', 95000, 'sherzod@company.com');

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT,
    SalesAmount DECIMAL(12,2)
);

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 1200, 15, 18000),
(2, 'Phone', 'Electronics', 800, 40, 32000),
(3, 'Tablet', 'Electronics', 500, 25, 12500),
(4, 'Headphones', 'Accessories', 150, 60, 9000),
(5, 'Keyboard', 'Accessories', 75, 100, 7500),
(6, 'Mouse', 'Accessories', 50, 200, 10000),
(7, 'Chair', 'Furniture', 250, 30, 7500),
(8, 'Desk', 'Furniture', 400, 20, 8000),
(9, 'Book', 'Stationery', 20, 500, 10000),
(10, 'Pen', 'Stationery', 5, 1000, 5000);


-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50),
    PostalCode VARCHAR(10)
);

INSERT INTO Customers VALUES
(1, 'Akmal', 'Karimov', 'Tashkent', '100100'),
(2, 'Alisher', 'Sodiqov', 'Samarkand', '140120'),
(3, 'Anora', 'Jalilova', 'Bukhara', '200200'),
(4, 'Bobur', 'Rustamov', 'Andijan', '170150'),
(5, 'Dilnoza', 'Yuldasheva', 'Namangan', '160180'),
(6, 'Farruh', 'Ismatov', 'Tashkent', '100200'),
(7, 'Gulbahor', 'Niyazova', 'Fergana', '150160'),
(8, 'Javlon', 'Xolmatov', 'Nukus', '230230'),
(9, 'Kamila', 'Tursunova', 'Khiva', '220220'),
(10, 'Malika', 'Qodirova', 'Tashkent', '100150');

-- 1. Top 5 employees
SELECT TOP 5 * 
FROM Employees;

-- 2. Unique categories
SELECT DISTINCT Category 
FROM Products;

-- 3. Products with Price > 100
SELECT * 
FROM Products
WHERE Price > 100;

-- 4. Customers whose FirstName starts with 'A'
SELECT * 
FROM Customers
WHERE FirstName LIKE 'A%';

-- 5. Products ordered by Price ascending
SELECT * 
FROM Products
ORDER BY Price ASC;

-- 6. Employees with Salary >= 60000 and DepartmentName = 'HR'
SELECT * 
FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR';

-- 7. Replace NULL Email with default text
SELECT EmpID, LastName, ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;

-- 8. Products with Price BETWEEN 50 AND 100
SELECT * 
FROM Products
WHERE Price BETWEEN 50 AND 100;

-- 9. Distinct Category and ProductName
SELECT DISTINCT Category, ProductName
FROM Products;

-- 10. Distinct Category + ProductName ordered by ProductName descending
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;

-- 11. Top 10 products ordered by Price DESC
SELECT TOP 10 *
FROM Products
ORDER BY Price DESC;

-- 12. COALESCE on FirstName and LastName
SELECT EmpID, COALESCE(FirstName, LastName) AS FirstNonNullName
FROM Employees;

-- 13. Distinct Category and Price
SELECT DISTINCT Category, Price
FROM Products;

-- 14. Employees age between 30–40 OR in Marketing
SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';

-- 15. OFFSET-FETCH for Employees 11–20 by Salary DESC
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 16. Products Price <= 1000 and StockQuantity > 50
SELECT *
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;

-- 17. Products containing 'e' in name
SELECT *
FROM Products
WHERE ProductName LIKE '%e%';

-- 18. Employees in HR, IT, or Finance
SELECT *
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');

-- 19. Customers ordered by City ASC, PostalCode DESC
SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;


-- 20. Top 5 products by SalesAmount
SELECT TOP 5 *
FROM Products
ORDER BY SalesAmount DESC;

-- 21. Combine FirstName + LastName into FullName
SELECT EmpID, (FirstName + ' ' + LastName) AS FullName, DepartmentName, Salary
FROM Employees;

-- 22. Distinct Category, ProductName, and Price where Price > 50
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

-- 23. Products cheaper than 10% of average price
SELECT *
FROM Products
WHERE Price < (0.1 * (SELECT AVG(Price) FROM Products));


