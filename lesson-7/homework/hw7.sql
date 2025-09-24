
-- 🟢 EASY LEVEL TASKS --

-- 1. Find the minimum price of a product
SELECT MIN(Price) AS MinPrice
FROM Products;

-- 2. Find the maximum Salary
SELECT MAX(Salary) AS MaxSalary
FROM Employees;

-- 3. Count the number of rows in Customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

-- 4. Count unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

-- 5. Total sales amount for product with id 7
SELECT SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE ProductID = 7;

-- 6. Average age of employees
SELECT AVG(Age) AS AvgAge
FROM Employees;

-- 7. Count employees in each department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;


-- 8. Min and Max price of products grouped by Category
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

-- 9. Total sales per Customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- 10. Departments having more than 5 employees
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;


-- 🟠 MEDIUM LEVEL TASKS --

-- 11. Total sales and average sales per product category
SELECT P.Category, SUM(S.SaleAmount) AS TotalSales, AVG(S.SaleAmount) AS AvgSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category;

-- 12. Count employees from Department HR
SELECT COUNT(*) AS HREmployees
FROM Employees
WHERE DepartmentName = 'HR';

-- 13. Highest and lowest Salary by department
SELECT DepartmentName, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

-- 14. Average salary per Department
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

-- 15. AVG salary and COUNT of employees in each department
SELECT DepartmentName, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 16. Product categories with avg price > 400
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- 17. Total sales per year
SELECT YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);

-- 18. Customers who placed at least 3 orders
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

-- 19. Departments with avg salary > 60000
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;


-- 🔴 HARD LEVEL TASKS --

-- 20. Average price per category, filter avg > 150
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 21. Customers with total sales > 1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 22. Total and avg salary of employees in each department, filter avg > 65000
SELECT DepartmentName, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 23. Total sales > $50 for each customer, with least purchases
SELECT CustomerID, SUM(SaleAmount) AS TotalSales, MIN(SaleAmount) AS LeastPurchase
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 50;

-- 24. Total sales and unique products per month/year, filter months with >= 2 products
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth,
       SUM(TotalAmount) AS TotalSales, COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 25. Min and Max order quantity per Year
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM Orders
GROUP BY YEAR(OrderDate);
