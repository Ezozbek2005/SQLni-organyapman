 /* ===============================
   EASY LEVEL TASKS
   =============================== */

-- 1. Har bir kategoriyadagi mahsulotlar soni
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- 2. Electronics kategoriyasidagi mahsulotlarning o‘rtacha narxi
SELECT AVG(Price) AS AvgElectronicsPrice
FROM Products
WHERE Category = 'Electronics';

-- 3. L harfi bilan boshlanadigan shaharlar bo‘yicha mijozlar
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Nomi 'er' bilan tugaydigan mahsulotlar
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. Mamlakati 'A' harfi bilan tugaydigan mijozlar
SELECT *
FROM Customers
WHERE Country LIKE '%A';

-- 6. Eng qimmat mahsulot narxi
SELECT MAX(Price) AS HighestPrice
FROM Products;

-- 7. Ombordagi mahsulotlarni “Low Stock” (<30) yoki “Sufficient” sifatida belgilash
SELECT ProductName, StockQuantity,
       CASE 
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Har bir mamlakatdagi mijozlar soni
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

-- 9. Buyurtmalarda eng kichik va eng katta miqdor
SELECT MIN(Quantity) AS MinOrder, MAX(Quantity) AS MaxOrder
FROM Orders;


/* ===============================
   MEDIUM LEVEL TASKS
   =============================== */

-- 1. 2023-yanvarda buyurtma bergan, lekin Invoice bo‘lmagan mijozlar
SELECT DISTINCT o.CustomerID
FROM Orders2 o
WHERE o.OrderDate >= '2023-01-01'
  AND o.OrderDate < '2023-02-01'
  AND NOT EXISTS (
        SELECT 1
        FROM Invoices1 i
        WHERE i.CustomerID = o.CustomerID
          AND i.InvoiceDate >= '2023-01-01'
          AND i.InvoiceDate < '2023-02-01'
  );


-- 2. Products va Products_Discounted dagi barcha mahsulot nomlari (takrorlari bilan)
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 3. Products va Products_Discounted dagi mahsulot nomlari (takrorsiz)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Har yil bo‘yicha buyurtma summasining o‘rtachasi
SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);

-- 5. Mahsulotlarni narx guruhlari bo‘yicha tasniflash
SELECT ProductName, 
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 6. City_Population → Pivot: yillarni alohida ustunlarda ko‘rsatish
SELECT district_name, [2012], [2013]
INTO Population_Each_Year
FROM (
    SELECT district_name, year, population
    FROM city_population
) AS src
PIVOT (
    SUM(population) FOR year IN ([2012], [2013])
) AS pvt;

select * from Population_Each_Year
-- 7. Har bir mahsulot bo‘yicha umumiy sotuvlar
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales1
GROUP BY ProductID;


-- 8. Nomi ichida 'oo' bo‘lgan mahsulotlar
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

-- 9. City_Population → Pivot: shaharlarni ustunlarga chiqarish
SELECT Year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM (
    SELECT district_name, Year, Population
    FROM City_Population
) AS src
PIVOT (
    SUM(Population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS pvt;
 select * from Population_Each_City
/* ===============================
   HARD LEVEL TASKS
   =============================== */

-- 1. Eng katta umumiy invoice summasiga ega TOP 3 mijoz

SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices1
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 2. Population_Each_Year ni qayta City_Population formatiga o‘tkazish
SELECT district_name, '2012' AS Year, [2012] AS Population
FROM Population_Each_Year
UNION ALL
SELECT district_name, '2013' AS Year, [2013] AS Population
FROM Population_Each_Year;

-- 3. Mahsulot nomlari va sotilgan soni
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 4. Population_Each_City ni qayta City_Population formatiga o‘tkazish
SELECT 'Bektemir' AS CityName, Year, [Bektemir] AS Population
FROM Population_Each_City
UNION ALL
SELECT 'Chilonzor' AS CityName, Year, [Chilonzor] AS Population
FROM Population_Each_City
UNION ALL
SELECT 'Yakkasaroy' AS CityName, Year, [Yakkasaroy] AS Population
FROM Population_Each_City;
