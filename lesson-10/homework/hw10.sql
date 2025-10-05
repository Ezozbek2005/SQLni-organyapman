-- 1-MASALA
-- Employees va Departments jadvalidan
-- maoshi 50000 dan katta xodimlarni ularning bo‘lim nomi bilan chiqaring
-------------------------------
SELECT 
    e.Name AS EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000
ORDER BY e.Salary DESC;



-------------------------------
-- 2-MASALA
-- 2023-yilda buyurtma bergan mijozlar ismi, familiyasi va buyurtma sanasi
-------------------------------
SELECT 
    c.FirstName,
    c.LastName,
    o.OrderDate
FROM Customers c
INNER JOIN Orders o  
    ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;



-------------------------------
-- 3-MASALA
-- Har bir xodimni o‘z bo‘limi bilan ko‘rsatish
-- (agar bo‘limi bo‘lmasa ham xodim chiqadi)
-------------------------------
SELECT  
    e.Name AS EmployeeName, 
    d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName;



-------------------------------
-- 4-MASALA
-- Supplier va ular yetkazib beradigan mahsulotlar ro‘yxati
-- (agar supplier hech nima yetkazmasa ham chiqadi)
-------------------------------
SELECT  
    s.SupplierName, 
    p.ProductName
FROM Suppliers s
LEFT JOIN Products p
    ON p.SupplierID = s.SupplierID;



-------------------------------
-- Qo‘shimcha MASALA
-- Orders, Payments va Products jadvallarini birlashtirib ko‘rsatish
-------------------------------
SELECT  
    o.OrderID,
    o.TotalAmount, 
    p.Amount, 
    pr.ProductName
FROM Orders o
FULL OUTER JOIN Payments p
    ON o.OrderID = p.OrderID
FULL OUTER JOIN Products pr
    ON pr.ProductID = o.ProductID;



-------------------------------
-- 5-MASALA
-- Orders va Payments – to‘lovli va to‘lovsiz buyurtmalarni ko‘rsatish
-------------------------------
SELECT  
    o.OrderID,
    o.TotalAmount, 
    p.Amount,
    p.PaymentDate
FROM Orders o
FULL OUTER JOIN Payments p
    ON o.OrderID = p.OrderID;



-------------------------------
-- 6-MASALA
-- Xodim va uning boshlig‘i (manager) ismi
-------------------------------
SELECT 
    e.Name AS EmployeeName,
    m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmployeeID;



-------------------------------
-- 7-MASALA
-- “Math 101” kursida o‘qiyotgan talabalar
-------------------------------
SELECT 
    s.Name AS StudentName,
    c.CourseName
FROM Enrollments e
INNER JOIN Students s 
    ON e.StudentID = s.StudentID
INNER JOIN Courses c 
    ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';



-------------------------------
-- 8-MASALA
-- 3 tadan ortiq buyurtma bergan mijozlar
-------------------------------
SELECT 
    c.FirstName,
    c.LastName,
    o.Quantity
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;



-------------------------------
-- 9-MASALA
-- "Human Resources" bo‘limidagi xodimlar
-------------------------------
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';

--Medium-Level Tasks 

-- 1️ Departmentlarda 5 tadan ko‘p xodimlar
SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;

-- 2️ Sotilmagan mahsulotlar
SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;

-- 3️ Kamida 1 ta buyurtma bergan mijozlar
SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING COUNT(o.OrderID) >= 1;

-- 4️ Faqat mavjud xodim va bo‘limlar (NULLs yo‘q)
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;

-- 5️ Bir boshliqqa bo‘ysunadigan xodim juftliklari
SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2 
ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID;

-- 6️ 2022-yilda berilgan buyurtmalar va mijoz ismlari
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

-- 7️ Sales bo‘limidagi maoshi 60000 dan katta xodimlar
SELECT 
    e.Name AS EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

-- 8️ To‘lov qilingan buyurtmalar
SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID;

-- 9️ Buyurtma qilinmagan mahsulotlar
SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

-- high level task
-- 1-masala: Bo‘limidagi o‘rtacha maoshdan yuqori oladigan xodimlar
SELECT 
    e.Name AS EmployeeName,
    e.Salary
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);

------------------------------------------------------------
-- 2-masala: 2020-yildan oldingi, to‘lovi yo‘q buyurtmalar
SELECT 
    o.OrderID,
    o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL
  AND o.OrderDate < '2020-01-01';

------------------------------------------------------------
-- 3-masala: Kategoriyasi yo‘q mahsulotlar
SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Categories c ON p.ProductID = c.CategoryID
WHERE c.CategoryID IS NULL;
select * from Products
select * from Categories

------------------------------------------------------------
-- 4-masala: Bir xil managerni bo‘lishadigan va 60000 dan ortiq maosh oladigan juftliklar
SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID,
    e1.Salary
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID 
   AND e1.EmployeeID < e2.EmployeeID
WHERE e1.Salary > 60000 
  AND e2.Salary > 60000;

------------------------------------------------------------
-- 5-masala: Bo‘lim nomi "M" bilan boshlanadigan xodimlar
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

------------------------------------------------------------
-- 6-masala: Summasi 500 dan katta bo‘lgan sotuvlar (mahsulot nomi bilan)
SELECT 
    s.SaleID,
    p.ProductName,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;

------------------------------------------------------------
-- 7-masala: "Math 101" kursiga yozilmagan talabalar
SELECT 
    s.StudentID,
    s.Name AS StudentName
FROM Students s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Math 101'
);

------------------------------------------------------------
-- 8-masala: To‘lov ma’lumoti yo‘q buyurtmalar
SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

------------------------------------------------------------
-- 9-masala: “Electronics” yoki “Furniture” kategoriyasidagi mahsulotlar
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName
FROM Products p
JOIN Categories c ON p.ProductID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
