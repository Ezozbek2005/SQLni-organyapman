  Easy
1. Ta’riflar:

Data (ma’lumot) – saqlanadigan faktlar, qiymatlar yoki yozuvlar (masalan, ism, yosh, narx).

Database (ma’lumotlar bazasi) – ma’lumotlarni tartibli saqlash, boshqarish va ularga murojaat qilish uchun tizim (masalan, SQL Server bazasi).

Relational database (munosabatli baza) – ma’lumotlarni jadvallar ko‘rinishida saqlaydigan baza, jadvallar bir-biriga kalitlar (keys) orqali bog‘lanadi.

Table (jadval) – qator (row) va ustunlardan (column) tashkil topgan tuzilma. Har bir qator yozuvni, har bir ustun esa atributni bildiradi.

2. SQL Serverning 5 ta asosiy xususiyati:

Katta hajmdagi ma’lumotlarni boshqarish imkoniyati.

Xavfsizlik: Authentication (Windows/SQL), Encryption, Roles.

Zaxira nusxa olish va tiklash (Backup/Restore).

Transaksiyalarni qo‘llab-quvvatlash (ACID prinsiplari).

Tarmoq orqali ko‘p foydalanuvchilar bilan ishlash.

3. SQL Server’da mavjud authentication turlari:

Windows Authentication – Windows tizimidagi login orqali kirish.

SQL Server Authentication – SQL Server’ga maxsus foydalanuvchi (username/password) orqali kirish.

  Medium
1. Yangi baza yaratish (SchoolDB)
CREATE DATABASE SchoolDB;
GO

2. Students jadvali yaratish
USE SchoolDB;
GO

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

3. SQL Server, SSMS va SQL farqlari:

SQL Server – ma’lumotlarni saqlovchi va boshqaruvchi ma’lumotlar bazasi boshqaruv tizimi (DBMS).

SSMS (SQL Server Management Studio) – SQL Server bilan ishlash uchun vizual dastur (interfeys).

SQL (Structured Query Language) – ma’lumotlar bilan ishlash uchun qo‘llaniladigan so‘rov tili.

  Hard
1. SQL buyruqlari guruhlari:

DQL (Data Query Language) – ma’lumotlarni olish uchun:

SELECT * FROM Students;


DML (Data Manipulation Language) – ma’lumotlarni o‘zgartirish uchun:

INSERT INTO Students VALUES (1, 'Ali', 20);
UPDATE Students SET Age = 21 WHERE StudentID = 1;
DELETE FROM Students WHERE StudentID = 1;


DDL (Data Definition Language) – jadval/baza tuzilmasini boshqarish:

CREATE TABLE Teachers (Id INT, Name VARCHAR(50));
ALTER TABLE Students ADD Email VARCHAR(100);
DROP TABLE Teachers;


DCL (Data Control Language) – huquqlarni boshqarish:

GRANT SELECT ON Students TO User1;
REVOKE SELECT ON Students FROM User1;


TCL (Transaction Control Language) – transaksiyalarni boshqarish:

BEGIN TRANSACTION;
UPDATE Students SET Age = 22 WHERE StudentID = 2;
COMMIT;
-- yoki
ROLLBACK;

2. Students jadvaliga 3 ta yozuv qo‘shish
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Laylo', 22),
(3, 'Jasur', 19);
