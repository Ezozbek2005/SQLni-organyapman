
-- 1. EmployeeID + FirstName + LastName birlashtirish
SELECT 
    CAST(EMPLOYEE_ID AS VARCHAR) + '-' + first_name + ' ' + last_name AS Employee_Detail
FROM Employees;

 

-- 2. Phone_number ichida '124' ni '999' ga almashtirish
UPDATE Employees
SET phone_number = REPLACE(phone_number, '124', '999');

-- 3. Ismi A, J, yoki M bilan boshlanuvchilar va uzunligi
SELECT 
    first_name AS [First Name],
    LEN(first_name) AS [Name Length]
FROM Employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'M%'
ORDER BY first_name;

-- 4. Har bir manager_id bo‘yicha jami ish haqi
SELECT 
    manager_id,
    SUM(salary) AS Total_Salary
FROM Employees
GROUP BY manager_id;

-- 5. Har bir yil uchun Max1, Max2, Max3 ichidan eng kattasi
SELECT 
    Year1,
    (SELECT MAX(v) FROM (VALUES (Max1), (Max2), (Max3)) AS val(v)) AS Highest_Value
FROM TestMax;
select * from TestMax
-- 6. Faqat toq id va "boring" bo‘lmagan kinolar
SELECT *
FROM cinema
WHERE id % 2 = 1
  AND description <> 'boring';
  select * from cinema

-- 7. Id bo‘yicha sortlash, 0 doimo oxirida
SELECT *
FROM SingleOrder
ORDER BY 
    CASE WHEN Id = 0 THEN 1 ELSE 0 END, 
    Id;
	select * from SingleOrder
-- 8. Birinchi NULL bo‘lmagan qiymatni tanlash
SELECT 
    id,
    COALESCE(ssn, passportid, itin) AS First_NonNull
FROM person;
select * from person


--MEDIUM TASKS
-- 1️ FullName ni 3 qismga ajratish (First, Middle, Last)
SELECT 
    PARSENAME(REPLACE(Name, ' ', '.'), 2) AS FirstName,
    
    PARSENAME(REPLACE(Name, ' ', '.'), 1) AS LastName
FROM Students;
select  * from Students

-- 2️ California’dan buyurtma bergan mijozlarning Texasdagi buyurtmalari
SELECT *
FROM Orders13
WHERE CustomerID IN (
    SELECT CustomerID FROM Orders13 WHERE DeliveryState = 'Ca '
)
AND DeliveryState = 'Tx';

select * from Orders13


-- 3️ Har bir bo‘limdagi xodimlarni bitta qatorga birlashtirish
 

SELECT 
    STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber) AS FullSQL
FROM DMLTable;



-- 4️ To‘liq ismida (FirstName + LastName) kamida 3 ta 'a' harfi bor xodimlar
SELECT *
FROM Employees
WHERE LEN(CONCAT(FIRST_NAME, LAST_NAME)) 
      - LEN(REPLACE(CONCAT(FIRST_NAME, LAST_NAME), 'a', '')) >= 3;

	  select * from Employees


-- 5️ Har bir bo‘limdagi jami xodimlar va 3 yildan ko‘p ishlaganlar foizi
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS Over3Years,
    CAST(
        SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS PercentOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

-- Difficult tasks

-----------------------------------------------------------
-- 1️ Har bir satrni o‘zidan oldingi qiymatlar yig‘indisi bilan almashtirish (Students)
-----------------------------------------------------------
SELECT 
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS RunningTotal
FROM Students13;

select * from Students13


-----------------------------------------------------------
-- 2️ Tug‘ilgan kuni bir xil bo‘lgan talabalarni topish (Student)
-----------------------------------------------------------
SELECT 
    s1.StudentName, 
    s1.Birthday
FROM Student s1
JOIN Student s2 
    ON s1.Birthday = s2.Birthday
    
ORDER BY s1.Birthday;

select * from Student

-----------------------------------------------------------
-- 3️⃣ Har bir o‘yinchilar juftligi uchun umumiy ballni hisoblash (PlayerScores)
-----------------------------------------------------------
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA > PlayerB THEN PlayerA ELSE PlayerB END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA > PlayerB THEN PlayerA ELSE PlayerB END;


-----------------------------------------------------------
-- 4️⃣ Belgilarni turiga qarab ajratish: katta harf, kichik harf, raqam, belgilar
-----------------------------------------------------------
DECLARE @text VARCHAR(100) = 'tf56sd#%OqH';

WITH chars AS (
    SELECT SUBSTRING(@text, number + 1, 1) AS ch
    FROM master.dbo.spt_values
    WHERE type = 'P' AND number < LEN(@text)
)
SELECT
    @text AS OriginalString,
    STRING_AGG(CASE WHEN ASCII(ch) BETWEEN 65 AND 90 THEN ch END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN ASCII(ch) BETWEEN 97 AND 122 THEN ch END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN ASCII(ch) BETWEEN 48 AND 57 THEN ch END, '') AS Numbers,
    STRING_AGG(CASE WHEN ASCII(ch) NOT BETWEEN 48 AND 57
                    AND ASCII(ch) NOT BETWEEN 65 AND 90
                    AND ASCII(ch) NOT BETWEEN 97 AND 122
                    THEN ch END, '') AS OtherChars
FROM chars;
