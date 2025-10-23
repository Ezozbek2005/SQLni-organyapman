------------------------------------------------------
-- 1️⃣ Name ustunini vergul (,) orqali ikkiga ajratish
-------------------------------------------------------
-- 🎯 Shart: "Name" ustunidagi matn "Ism,Familiya" shaklida bo‘lsa,
-- uni alohida FirstName va Surname ustunlariga ajratamiz.

SELECT 
    LEFT(Name, CHARINDEX(',', Name) - 1) AS FirstName,
    LTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name))) AS Surname
FROM TestMultipleColumns;
-- 🧠 CHARINDEX() — vergulning o‘rnini topadi.
-- LEFT() — vergulgacha bo‘lgan qismni oladi.
-- RIGHT() — verguldan keyingi qismini oladi.
-------------------------------------------------------


-------------------------------------------------------
-- 2️⃣ Ichida % belgisi bor satrlarni topish
-------------------------------------------------------
-- 🎯 Shart: String ustunida '%' belgisi ishtirok etgan satrlarni chiqarish.

SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';
-- 🧠 [%] — bu maxsus belgini literal sifatida izlash uchun ishlatiladi.
-- LIKE '%[%]%' — matnda '%' belgisi borligini bildiradi.
-------------------------------------------------------
select * from TestPercent

-------------------------------------------------------
-- 3️⃣ '.' bo‘yicha satrni bo‘lish
-------------------------------------------------------
-- 🎯 Shart: 'sql.server.database' kabi matnni nuqta orqali ajratish.

SELECT 
    VALUE AS SplitPart
FROM STRING_SPLIT('sql.server.database', '.');
-- 🧠 STRING_SPLIT() — berilgan belgiga qarab satrni bo‘ladi.
-- Har bir qism yangi qatorda chiqadi.
-------------------------------------------------------


-------------------------------------------------------
-- 4️⃣ 2 tadan ko‘p nuqtasi bor satrlarni topish
-------------------------------------------------------
-- 🎯 Shart: "Vals" ustunidagi satrlardan 3 yoki undan ko‘p nuqtasi (.) borlarini topamiz.

SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;
-- 🧠 LEN() — uzunlikni hisoblaydi.
-- REPLACE(Vals, '.', '') — nuqtalarni olib tashlaydi.
-- Farq → nechta nuqta borligini bildiradi.
-------------------------------------------------------
select * from testDots

-------------------------------------------------------
-- 5️⃣ Satr ichidagi bo‘sh joylar (space) sonini sanash
-------------------------------------------------------
-- 🎯 Shart: Har bir satrda nechta bo‘sh joy borligini topamiz.

SELECT 
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;
-- 🧠 REPLACE() — bo‘sh joylarni olib tashlaydi.
-- Asl uzunlikdan bo‘sh joysiz uzunlikni ayiramiz → natija = bo‘sh joylar soni.
-------------------------------------------------------
select * from CountSpaces

-------------------------------------------------------
-- 6️⃣ Menejeridan ko‘proq maosh oladigan xodimlar
-------------------------------------------------------
-- 🎯 Shart: O‘z menejeriga qaraganda maoshi yuqori bo‘lgan xodimlarni topamiz.

SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.Last_Name, e.Salary, e.MANAGER_ID
FROM Employees14 e
JOIN Employees14 m ON e.MANAGER_ID = m.EMPLOYEE_ID
WHERE e.Salary > m.Salary;
-- 🧠 Bu self-join.
-- Har bir xodim o‘z menejeri bilan solishtiriladi (ManagerID orqali).
-------------------------------------------------------
select * from Employees14

-------------------------------------------------------
-- 7️⃣ Ish staji 10 yildan 15 yilgacha bo‘lgan xodimlar
-------------------------------------------------------
-- 🎯 Shart: Ishga kirgan sanasi 10–15 yil oraliqda bo‘lganlarni topamiz.
-- Natijada EmployeeID, ism, familiya, hire date va ish staji chiqadi.

SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees14
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;
-- 🧠 DATEDIFF(YEAR, HireDate, GETDATE()) — ishga kirganidan beri o‘tgan yilni hisoblaydi.
-- BETWEEN 10 AND 15 → 10–15 yil oraliqda ishlaganlar chiqadi.
-------------------------------------------------------
-- medium level

------------------------------------------------------------
-- 1️⃣ Weather: Kechagi kunga nisbatan harorati yuqori bo‘lgan sanalar
------------------------------------------------------------
-- 🎯 Shart: Har bir sanani kechagi sana bilan solishtirib, 
-- agar bugungi harorat undan yuqori bo‘lsa, shu sananing ID sini chiqarish.

SELECT w1.Id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

-- 🧠 Bu yerda:
-- DATEDIFF(DAY, ...) = 1 → w1 sanasi w2 sanasidan 1 kun keyinligini bildiradi.
-- Solishtirish → bugungi harorat > kechagidan katta.
------------------------------------------------------------


------------------------------------------------------------
-- 2️⃣ Activity: Har bir o‘yinchining birinchi kirgan sanasini topish
------------------------------------------------------------
-- 🎯 Shart: Har bir player uchun eng erta (birinchi) login sanani topish.

SELECT 
    player_id,
    MIN(event_date) AS FirstLoginDate
FROM Activity
GROUP BY player_id;

-- 🧠 MIN(LoginDate) → eng kichik (erta) sanani beradi.
-- Har bir PlayerID bo‘yicha GROUP BY bilan guruhlanadi.
------------------------------------------------------------
select * from Activity

------------------------------------------------------------
-- 3️⃣ Fruits: Ro‘yxatdan 3-elementni olish
------------------------------------------------------------
-- 🎯 Shart: fruits jadvalidan faqat uchinchi itemni olish.
SELECT 
    fruit_list,
    SUBSTRING(
        fruit_list,
        CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1,  -- 2-verguldan keyingi pozitsiya
        CHARINDEX(',', fruit_list + ',', CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1)
        - (CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1)
    ) AS ThirdWord
FROM fruits;

------------------------------------------------------------


------------------------------------------------------------
-- 4️⃣ Employees: Ish stajiga qarab Employment Stage ni aniqlash
------------------------------------------------------------
-- 🎯 Shart:
--   <1 yil → 'New Hire'
--   1–5 yil → 'Junior'
--   5–10 yil → 'Mid-Level'
--   10–20 yil → 'Senior'
--   >20 yil → 'Veteran'

SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS YearsWorked,
    CASE 
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees14;

-- 🧠 CASE ... WHEN → shartlarga qarab text chiqaradi.
-- DATEDIFF(YEAR, Hire_Date, GETDATE()) → ishlagan yilni topadi.
------------------------------------------------------------

------------------------------------------------------------
-- 5️⃣ GetIntegers: Satr boshidagi raqamni ajratib olish
------------------------------------------------------------
-- 🎯 Shart: Har bir satrda boshida raqam bo‘lsa (masalan '123abc'),
-- faqat raqam qismini (123) ajratib olish.

SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'a') - 1) AS NumberPart
FROM GetIntegers
WHERE PATINDEX('%[0-9]%', Vals) = 1;

-- 🧠 PATINDEX('%[^0-9]%', ...) → raqam bo‘lmagan 1-pozitsiyani topadi.
-- LEFT(..., n-1) → faqat raqam qismini oladi.
-- + 'a' → null bo‘lmasligi uchun xavfsiz usul.
------------------------------------------------------------
-- difficult tasks
 
-- 1-🔹 Birinchi ikkita harfni joyini almashtirish
SELECT 
    Vals,
    SUBSTRING(Vals, 2, 1)        -- 2-harf
    + SUBSTRING(Vals, 1, 1)      -- 1-harf
    + SUBSTRING(Vals, 3, LEN(Vals) - 2)  -- qolgan qismi
      AS Swapped
FROM MultipleVals;
 
 SELECT 
    Vals,
    SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 1) + 
    LEFT(Vals, 1) + 
    SUBSTRING(Vals, CHARINDEX(',', Vals), LEN(Vals) - CHARINDEX(',', Vals) + 1) AS Swapped
FROM MultipleVals;




--2 -- 🔹 Har bir belgini alohida qatorda chiqarish
SELECT 
    SUBSTRING(Vals, Number, 1) AS CharValue
FROM StringData
JOIN master.dbo.spt_values 
    ON Number BETWEEN 1 AND LEN(Vals)
WHERE type = 'P';

select * from stringdata

--3 -- 🔹 Har bir player uchun eng birinchi login qilgan qurilmasini topish
SELECT player_id, device_id
FROM Activity a
WHERE event_date = (
    SELECT MIN(event_date)
    FROM Activity
    WHERE player_id = a.player_id
);

select * from Activity

--4-  🔹 Belgilarni sonlar va harflarga ajratish
SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[0-9]%', Vals + 'a') - 1) AS Characters,
    SUBSTRING(Vals, PATINDEX('%[0-9]%', Vals), LEN(Vals)) AS Numbers
FROM MixedValues;
