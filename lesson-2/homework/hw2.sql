--BASIC LEVEL
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
 SELECT *from Employees;

-- Bir nechta yozuvni birdan qo‘shish
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(1, 'John Doe', 6000),
(2, 'Jane Smith', 5500),
(3, 'Alice Brown', 4800),
(4, 'Mike Johnson', 7200);


UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

DELETE FROM Employees
WHERE EmpID = 2;

--DELETE, TRUNCATE, DROP farqi

--DELETE – faqat shartga mos yozuvlarni o‘chiradi (WHERE ishlatiladi).

--TRUNCATE – jadvaldagi hamma yozuvlarni o‘chiradi, lekin strukturasi saqlanadi.

--DROP – butun jadvalni (strukturasi bilan) o‘chiradi.

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);


ALTER TABLE Employees
ADD Department VARCHAR(50);

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);



TRUNCATE TABLE Employees;

-- INTERMEDIATE LEVEL
select * from Departments

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'Finance' UNION ALL
SELECT 3, 'IT' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'Sales';

UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

TRUNCATE TABLE Employees;

ALTER TABLE Employees
DROP COLUMN Department;

EXEC sp_rename 'Employees', 'StaffMembers';

select * from staffMembers;

DROP TABLE Departments;

--ADVANCED LEVEL

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(200)
);

SELECT * from Products

ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);


ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, '15-inch laptop'),
(2, 'Phone', 'Electronics', 800.00, '128GB smartphone'),
(3, 'Table', 'Furniture', 150.00, 'Wooden dining table'),
(4, 'Chair', 'Furniture', 75.00, 'Office chair'),
(5, 'Headphones', 'Electronics', 120.00, 'Noise-cancelling');

SELECT * INTO Products_Backup
FROM Products;

SELECT *from Products_Backup

EXEC sp_rename 'Products', 'Inventory';

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
 

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);

select *from Inventory
