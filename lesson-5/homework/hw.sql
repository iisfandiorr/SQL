

1. SELECT ProductName AS Name FROM Products;
2. select * from Customers as Client;
3. select ProductName from Products
union all
select ProductName from Products_Discounted;
4. select ProductName, Category  from Products
intersect 
Select ProductName, Category from Products_Discounted;
5. Select Distinct FirstName, Country from Customers;
6. select Price,
case
when Price > 1000 then 'High'
when Price <= 1000 then 'Low'
else 'Okay'
end as Conditional_column from Products
7. Select StockQuantity,
iif (StockQuantity > 100, 'Yes', 'No')
As StockLevel
From Products_Discounted
8. select ProductName from Products
Union
Select ProductName from Products_Discounted
9. Select ProductName, Category from Products
Except
select ProductName, Category from Products_Discounted
10. select Price,
iif(Price > 1000, 'Expensive', 'Affordable') as PriceLevel
from Products
11. select * from Employees
where Salary > 60000 and Age < 25
12. UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR'
   OR EmployeeID = 5;
13. select SaleAmount,
case
when SaleAmount > 500 then 'Top_tier'
when SaleAmount between 200 and 500 then 'Mid_tier'
else 'Low_tier'
end as SalesLevel
from Sales
14. select CustomerID from Orders
except
Select CustomerID from Sales
15. select Quantity,
case 
when Quantity = 1 then '3%'
when Quantity > 1 then '5%'
when Quantity > 3 then '7%'
else 'No_discount'
end as Discount_level
from Orders







