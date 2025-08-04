CREATE TABLE Employees (
    EmpId INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

SELECT * FROM Employees;

-- 2. Вставка данных
INSERT INTO Employees VALUES (1, 'Alisher', 3000);
INSERT INTO Employees VALUES (2, 'Sabina', 1500), (3, 'Mubina', 2000);

-- 3. Обновление зарплаты
UPDATE Employees SET Salary = 7000 WHERE EmpId = 1;

-- 4. Удаление сотрудника с EmpId = 2
DELETE FROM Employees WHERE EmpId = 2;

-- 5. Разница между DELETE, TRUNCATE и DROP
-- DELETE удаляет строки из таблицы с возможностью отката (можно WHERE)
-- TRUNCATE удаляет все строки без логгирования, быстрее, но нельзя WHERE
-- DROP полностью удаляет таблицу вместе со структурой

-- 6. Изменение типа столбца Name
ALTER TABLE Employees ALTER COLUMN Name VARCHAR(100);

-- 7. Добавление нового столбца Department
ALTER TABLE Employees ADD Department VARCHAR(50);

-- 8. Изменение типа Salary на FLOAT
ALTER TABLE Employees ALTER COLUMN Salary FLOAT;

-- 9. Создание таблицы Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

SELECT * FROM Departments;

-- 10. Очистка таблицы Employees
TRUNCATE TABLE Employees;

-- 11. Вставка данных в Departments
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'IT'
UNION ALL
SELECT 3, 'Finance'
UNION ALL
SELECT 4, 'Marketing'
UNION ALL
SELECT 5, 'Sales';

-- 12. Обновление отдела у сотрудников с зарплатой больше 5000
UPDATE Employees SET Department = 'Management' WHERE Salary > 5000;

-- 13. Очистка таблицы Employees
TRUNCATE TABLE Employees;

-- 14. Удаление столбца Department
ALTER TABLE Employees DROP COLUMN Department;

-- 15. Переименование таблицы Employees в StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';

-- 16. Удаление таблицы Departments
DROP TABLE Departments;

-- 17. Создание таблицы Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL
);

-- 18. Добавление ограничения: цена должна быть положительной
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

-- 19. Добавление колонки с количеством на складе по умолчанию 50
ALTER TABLE Products ADD StockQuantity INT DEFAULT 50;

-- 20. Переименование столбца Category в ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21. Вставка данных в Products
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES 
(1, 'Laptop', 'Technology', 1000, 300),
(2, 'Phone', 'Gadget', 800, 200),
(3, 'TV', 'Technology', 2000, 200),
(4, 'Earpods', 'Gadget', 300, 1000),
(5, 'Car', 'Auto', 35000, 50);

-- 22. Создание резервной копии таблицы Products
SELECT * INTO Products_backups FROM Products;

-- 23. Переименование таблицы Products в Inventory
EXEC sp_rename 'Products', 'Inventory';

-- 24. Изменение типа столбца Price на float
ALTER TABLE Inventory ALTER COLUMN Price FLOAT;

-- 25. Создание новой таблицы с автоинкрементом и перенос данных
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
    ProductName VARCHAR(100),
    Price FLOAT,
    StockQuantity INT
);

INSERT INTO Inventory_New (ProductName, Price, StockQuantity)
SELECT ProductName, Price, StockQuantity FROM Inventory;

DROP TABLE Inventory;
EXEC sp_rename 'Inventory_New', 'Inventory';
