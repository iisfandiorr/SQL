-- Easy-Level Tasks (7)
--Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the customers who placed them.
--Tables Used: Orders, Customers

select o.orderid, c.firstname, c.lastname, o.orderdate
from orders o join customers c
on o.customerid = c.customerid
where year(orderdate) >= 2022

--Return: EmployeeName, DepartmentName
--Task: Display the names of employees who work in either the Sales or Marketing department.
--Tables Used: Employees, Departments

select e.name, d.departmentname
from employees e join departments d 
on e.departmentid = d.departmentid
where d.departmentname = 'sales' or d.departmentname =  'marketing'

--Return: DepartmentName, MaxSalary
--Task: Show the highest salary for each department.
--Tables Used: Departments, Employees

select d.departmentname, max(e.salary) as highestsalary
from employees e join departments d 
on e.departmentid = d.departmentid
group by d.departmentname 
order by max(e.salary) desc

--Return: CustomerName, OrderID, OrderDate
--Task: List all customers from the USA who placed orders in the year 2023.
--Tables Used: Customers, Orders

select c.firstname, c.lastname, o.orderid, o.orderdate
from customers c join orders o
on c.customerid = o.customerid
where c.country = 'usa' and year(o.orderdate) = 2023

--Return: CustomerName, TotalOrders
--Task: Show how many orders each customer has placed.
--Tables Used: Orders , Customers

select c.firstname, c.lastname, count(o.orderid) as totalorders
from customers c join orders o
on c.customerid = o.customerid
group by c.firstname, c.lastname

--Return: ProductName, SupplierName
--Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--Tables Used: Products, Suppliers

SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');

--Return: CustomerName, MostRecentOrderDate
--Task: For each customer, show their most recent order. Include customers who haven"t placed any orders.
--Tables Used: Customers, Orders

select c.firstname, c.lastname, max(o.orderdate) as recentorder
from customers c join orders o
on o.customerid = c.customerid
group by c.firstname, c.lastname, o.orderdate

--🟠 Medium-Level Tasks (6)
--Return: CustomerName, OrderTotal
--Task: Show the customers who have placed an order where the total amount is greater than 500.
--Tables Used: Orders, Customers

select c.lastname, c.firstname, o.totalamount
from customers c join orders o
on c.customerid = o.customerid
where o.totalamount > 500

--Return: ProductName, SaleDate, SaleAmount
--Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
--Tables Used: Products, Sales

select p.productname, s.saledate, s.saleamount
from products p join sales s 
on p.productid = s.productid
where year(s.saledate) = 2023 and s.saleamount > 400

--Return: ProductName, TotalSalesAmount
--Task: Display each product along with the total amount it has been sold for.
--Tables Used: Sales, Products

select p.productname, sum(saleamount) as totalamount
from products p join sales s 
on p.productid = s.productid
group by p.productname

--Return: EmployeeName, DepartmentName, Salary
--Task: Show the employees who work in the HR department and earn a salary greater than 60000.
--Tables Used: Employees, Departments

select e.name, d.departmentname, e.salary
from employees e join departments d
on e.departmentid = d.departmentid
where d.departmentname = 'hr' and e.salary > 60000

--Return: ProductName, SaleDate, StockQuantity
--Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
--Tables Used: Products, Sales

select * from products
select * from sales

select p.productname, s.saledate, p.stockquantity
from products p join sales s
on p.productid = s.productid
where p.stockquantity > 100

--Return: EmployeeName, DepartmentName, HireDate
--Task: Show employees who either work in the Sales department or were hired after 2020.
--Tables Used: Employees, Departments

select * from employees
select * from departments

select e.name, d.departmentname, e.hiredate
from employees e join departments d
on d.departmentid = e.departmentid
where year(e.hiredate) > 2020 or d.departmentname = 'sales'


--🔴 Hard-Level Tasks (7)
--Return: CustomerName, OrderID, Address, OrderDate
--Task: List all orders made by customers in the USA whose address starts with 4 digits.
--Tables Used: Customers, Orders

SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

--Return: ProductName, Category, SaleAmount
--Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
--Tables Used: Products, Sales

select p.productname, c.categoryname, s.saleamount
from products p join categories c
on p.category = c.categoryid
join sales s on p.productid = s.productid
where c.categoryname = 'electronics' or s.saleamount > 350

--Return: CategoryName, ProductCount
--Task: Show the number of products available in each category.
--Tables Used: Products, Categories

select c.categoryname, sum(p.stockquantity) as totalavailable
from categories c join products p
on p.category = c.categoryid
group by c.categoryname

--Return: CustomerName, City, OrderID, Amount
--Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
--Tables Used: Customers, Orders

select c.firstname + ' ' + c.lastname, o.orderid, o.totalamount
from customers c join orders o
on c.customerid = o.customerid
where c.city = 'los angeles' and o.totalamount > 300

--Return: EmployeeName, DepartmentName
--Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
--Tables Used: Employees, Departments

select e.name, d.departmentname
from employees e join departments d
on e.departmentid = d.departmentid
where d.departmentname in ('hr' , 'finance') and e.name like '%[A, E, I, O, U],%,[A, E, I, O, U],%,[A, E, I, O, U],%,[A, E, I, O, U]%'


--Return: EmployeeName, DepartmentName, Salary
--Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
--Tables Used: Employees, Departments

select e.name, d.departmentname, e.salary
from employees e join departments d
on e.departmentid = d.departmentid
where d.departmentname in ('sales', 'marketing') and e.salary > 60000
