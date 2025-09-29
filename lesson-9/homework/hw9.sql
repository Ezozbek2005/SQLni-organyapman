/* ============================
   🟢 EASY (10 puzzles)
   ============================ */

-- 1. Products × Suppliers – barcha kombinatsiyalar
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

-- 2. Departments × Employees – barcha kombinatsiyalar
SELECT D.DepartmentName, E. Name
FROM Departments D
CROSS JOIN Employees E;

-- 3. Supplier → Product real bog‘langan kombinatsiyalar
SELECT S.SupplierName, P.ProductName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 4. Orders × Customers
SELECT C.lastName, O.OrderID
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;
 

-- 5. Students × Courses – barcha kombinatsiyalar
SELECT S. Name, C.CourseName
FROM Students S
CROSS JOIN Courses C;
 

-- 6. Products × Orders – ProductID mos bo‘lganlar
SELECT P.ProductName, O.OrderID
FROM Products P
JOIN Orders O ON P.ProductID = O.ProductID;

-- 7. Employees × Departments – mos bo‘lganlar
SELECT E. Name, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. Students × Enrollments – kursga yozilganlar
SELECT S. Name, E.CourseID
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID;

-- 9. Payments × Orders – mos kelganlar
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID;

-- 10. Orders × Products – narxi 100 dan katta
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;


/* ============================
   🟡 MEDIUM (10 puzzles)
   ============================ */

-- 1. Employees × Departments – ID mos emas
SELECT E. Name, D.DepartmentName
FROM Employees E
CROSS JOIN Departments D
WHERE E.DepartmentID <> D.DepartmentID;

-- 2. Orders × Products – Quantity > StockQuantity
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;

-- 3. Customers × Sales – SaleAmount ≥ 500
SELECT C.LastName, S.ProductID, S.SaleAmount
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE S.SaleAmount >= 500;

-- 4. Students × Enrollments × Courses
SELECT S. Name, C.CourseName
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;

-- 5. Products × Suppliers – Supplier nomida “Tech” bo‘lganlar
SELECT P.ProductName, S.SupplierName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

-- 6. Orders × Payments – Paid < TotalAmount
SELECT O.OrderID, P.PaymentID, 
       O.Quantity * PR.Price AS TotalAmount, 
       P.Amount AS Paid
FROM Orders O
JOIN Products PR ON O.ProductID = PR.ProductID
JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < (O.Quantity * PR.Price);

-- 7. Employees × Departments – har bir employee uchun department nomi
SELECT E. Name, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. Products × Categories – Electronics yoki Furniture
SELECT P.ProductName, C.CategoryName
FROM Products1 P
JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');

 



-- 9. Sales × Customers – faqat USA
SELECT S.SaleID, S.SaleAmount, C.LastName
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';

-- 10. Orders × Customers – Germany + Total > 100
SELECT O.OrderID, C.LastName, 
       O.Quantity * P.Price AS Total
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID
WHERE C.Country = 'Germany'
  AND (O.Quantity * P.Price) > 100;


/* ============================
   🔴 HARD (5 puzzles)
   ============================ */

-- 1. Employees – boshqa departmentdan bo‘lgan juftliklar
SELECT E1. Name AS Employee1, 
       E2. Name AS Employee2
FROM Employees E1
JOIN Employees E2 
     ON E1.EmployeeID < E2.EmployeeID
WHERE E1.DepartmentID <> E2.DepartmentID;

-- 2. Payments × Orders × Products – Paid ≠ (Quantity × Price)
SELECT C.LastName, O.OrderID, (O.Quantity * P.Price) AS Total
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID
WHERE C.Country = 'Germany'
  AND (O.Quantity * P.Price) > 100;


-- 3. Students – kursga yozilmaganlar
SELECT S. Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.StudentID IS NULL;

-- 4. Managers – o‘zidan kam maosh oluvchi xodim
SELECT M. Name AS Manager, M.Salary AS ManagerSalary, 
       E. Name AS Employee, E.Salary AS EmployeeSalary
FROM Employees E
JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;

-- 5. Customers – buyurtma qilgan, lekin to‘lov qilmaganlar
SELECT DISTINCT C.LastName, O.OrderID
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;
