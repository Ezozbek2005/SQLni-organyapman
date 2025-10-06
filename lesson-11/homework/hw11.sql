-- 🟢 EASY LEVEL TASKS
------------------------------------------------------------

-- 1. Show all orders placed after 2022 along with customer names
SELECT 
    o.OrderID,
    c.LastName,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;


-- 2. Employees who work in Sales or Marketing
SELECT 
    e. Name,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');


-- 3. Highest salary for each department
SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;


-- 4. Customers from USA who placed orders in 2023
SELECT 
    c.LastName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND YEAR(o.OrderDate) = 2023;


-- 5. Show how many orders each customer has placed
SELECT 
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.LastName;


-- 6. Products supplied by 'Gadget Supplies' or 'Clothing Mart'
SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.ProductID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');


-- 7. For each customer, show most recent order (include customers without orders)
SELECT 
    c.LastName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.LastName;


------------------------------------------------------------
-- 🟠 MEDIUM LEVEL TASKS
------------------------------------------------------------

-- 8. Customers who placed an order > 500
SELECT 
    c.LastName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;


-- 9. Product sales in 2022 OR sale amount > 400
SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;


-- 10. Each product with total sold amount
SELECT 
    p.ProductName,
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;


-- 11. Employees in HR dept earning > 60000
SELECT 
    e. Name,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR' AND e.Salary > 60000;


-- 12. Products sold in 2023 and stock > 100
SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;
 


-- 13. Employees in Sales or hired after 2020
SELECT 
    e. Name,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020;


------------------------------------------------------------
-- 🔴 HARD LEVEL TASKS
------------------------------------------------------------

-- 14. Orders by USA customers whose address starts with 4 digits
SELECT 
    c.LastName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';


-- 15. Product sales: Electronics category OR SaleAmount > 350
SELECT 
    p.ProductName,
    p.Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = 'Electronics' OR s.SaleAmount > 350;


-- 16. Number of products in each category
 
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p 
    ON c.CategoryName = p.Category
GROUP BY c.CategoryName
ORDER BY ProductCount DESC;


-- 17. Orders from Los Angeles with amount > 300
SELECT 
    c.LastName,
    c.City,
    o.OrderID,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;


-- 18. Employees in HR or Finance, OR name with ≥4 vowels
SELECT 
    e. Name,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('HR', 'Finance')
   OR e. Name LIKE '%a%e%i%o%u%' 
   OR e. Name LIKE '%a%e%i%o%' 
   OR e.Name LIKE '%e%i%o%u%';

 


-- 19. Employees in Sales/Marketing with salary > 60000
SELECT 
    e. Name,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
  AND e.Salary > 60000;

