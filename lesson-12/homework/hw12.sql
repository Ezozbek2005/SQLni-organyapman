-- 1️⃣ Combine Two Tables
SELECT 
    p.firstName, 
    p.lastName, 
    a.city, 
    a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;


-- 2️⃣ Employees Earning More Than Their Managers
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;


-- 3️⃣ Duplicate Emails
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;


-- 4️⃣ Delete Duplicate Emails (faqat eng kichik ID qolsin)
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);


-- 5️⃣ Parents Who Have Only Girls
SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (SELECT ParentName FROM boys);


-- 6️⃣ Total over 50 and Least
SELECT 
    custid,
    SUM(val) AS TotalSales,
    MIN(weight) AS LeastWeight
FROM Sales.Orders
WHERE weight > 50
GROUP BY custid;


-- 7️⃣ Carts (FULL JOIN)
SELECT 
    ISNULL(c1.Item, '') AS [Item Cart 1],
    ISNULL(c2.Item, '') AS [Item Cart 2]
FROM Cart1 c1
FULL JOIN Cart2 c2 ON c1.Item = c2.Item;


-- 8️⃣ Customers Who Never Order
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;


-- 9️⃣ Students and Examinations
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
