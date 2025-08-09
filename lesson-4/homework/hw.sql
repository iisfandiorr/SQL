

1. select top (5) [EmployeeID], [FirstName], [LastName], [DepartmentName], 
[Salary], [HireDate], [Age], [Email], [Country] from Employees
2. SELECT DISTINCT Category
FROM Products;
3. select * from Products
where Price > 100
4. select * from Customers
Where FirstName Like 'A%'
5. select * from Products
order by [Price] asc
6. select * from Employees
where Salary >= 60000 and DepartmentName = 'HR'
7. SELECT ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;
8. select * from Products
where Price Between 50 and 100
9. SELECT DISTINCT Category, ProductName
FROM Products;
10. SELECT DISTINCT Category, ProductName
FROM Products
order by [Productname] desc;

11. select top (10) [ProductId], [ProductName], [Price], [Category], [StockQuantity]
from Products
order by [Price] desc
12. SELECT COALESCE(FirstName, LastName) AS FirstNonNullName
FROM Employees;
13. select distinct Category, Price from Products
14. select * from Employees
where (Age between 30 and 40) or DepartmentName = 'Marketintg'
15. SELECT * FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;
16. Select * from Products
where Price <= 1000 and StockQuantity > 50
order by [StockQuantity] asc
17. select * from Products
where ProductName like '%e%';
18. select * from Employees
where DepartmentName in ('HR', 'IT', 'Finance');
19. SELECT * FROM Customers
ORDER BY City ASC, PostalCode DESC;


20. select top (5) [SaleId], [ProductID], [CustomerID], [SaleDate], [SaleAmount] 
from Sales
order by [SaleAmount] desc
21. SELECT FirstName + ' ' + LastName AS FullName
FROM Employees;
22. select distinct Category, ProductName, Price from Products
where Price > 50 
23. SELECT * FROM Products
WHERE Price < 0.1 * (SELECT AVG(Price) FROM Products);
24. select * from Employees
where Age < 30 and DepartmentName = 'HR' or DepartmentName = 'HR' 
25. select * from Employees
where Email like '%@gmail.com'
26. SELECT * FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE Department = 'Sales');
27. select * from Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();























