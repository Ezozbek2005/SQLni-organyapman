CREATE TABLE employees15 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees15 (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select * from employees15
-- 1- eng past maoshni topish
SELECT name, salary
FROM employees15
WHERE salary = (
    SELECT MIN(salary)
    FROM employees15
);

-- 2 - o'rtachadan yuqori maoshni topish

 

CREATE TABLE products15 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products15 (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products15

select product_name, price
from products15
where price > (select avg(price) from products15);

-- 3 "Sales" bo'limida ishlaydiganlarni topish
 DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
GO

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
GO

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
GO

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');
GO

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);
GO

SELECT * FROM departments;
SELECT * FROM employees;

select name 
from employees
where department_id = (select id from departments where department_name = 'sales');

 --4 - Buyurtma bermagan mijozlarni topish
 CREATE TABLE customers15 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders15 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers15(customer_id)
);

INSERT INTO customers15 (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders15 (order_id, customer_id) VALUES
(1, 1),
(2, 1);

select * from customers15
select * from orders15
SELECT name
FROM customers15 c
WHERE not EXISTS (
    SELECT 1
    FROM orders15 o
    WHERE o.customer_id = c.customer_id
);
-- 5 Har bir category_id bo‘yicha eng qimmat mahsulot(lar) ni topish.

CREATE TABLE products151 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products151 (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);

select * from products151

SELECT p.product_name, p.price, p.category_id
FROM products151 p
WHERE p.price = (
    SELECT MAX(price)
    FROM products151
    WHERE  category_id =p.category_id
);
 -- 6- O‘rtacha ish haqi eng yuqori bo‘lgan bo‘limni topish, va shu bo‘limda ishlaydigan xodimlarni chiqarish.
 CREATE TABLE departments156 (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees156 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments156(id)
);

INSERT INTO departments156 (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees156 (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

select * from departments156
select * from employees156

SELECT e.name, e.salary, d.department_name
FROM employees156 e
JOIN departments156 d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees156
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);
  -- 7 department o‘rtacha maoshidan yuqori oladigan xodimlarni topish
  CREATE TABLE employees157 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees157 (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);

select * from employees157

 

SELECT e.name, e.salary, e.department_id
FROM employees157 e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees157
    WHERE department_id = e.department_id
);
 -- 8 - Har bir kurs (course_id) bo‘yicha eng yuqori baho (grade) olgan talaba(lar)ni topish.
 CREATE TABLE students158 (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades158 (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students158(student_id)
);

INSERT INTO students158 (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades158 (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select * from students158
select * from grades158

SELECT s.name, g.grade, g.course_id
FROM students158 s
 join grades158 g on s.student_id = g.student_id
 where g.grade =  ( select max(grade) from grades158 where course_id = g.course_id);

 --9 - Har bir category_id uchun 3-chi eng katta narxga ega mahsulot(lar)ni topish.

 CREATE TABLE products159 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products159 (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

select * from products159

SELECT p1.product_name, p1.price, p1.category_id
FROM products159 p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products159 p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);

-- 10 - 1️ Ishchi kompaniya bo‘yicha o‘rtacha oylikdan ko‘p olgan bo‘lishi kerak.
--      2️ Lekin uning oyligi o‘z bo‘limidagi eng katta oylikdan kichik bo‘lishi kerak.

CREATE TABLE employees1510 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees1510 (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);

select * from employees1510

SELECT e.id, e.name, e.salary, e.department_id
FROM employees1510 e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees1510
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employees1510 d
    WHERE d.department_id = e.department_id
);
