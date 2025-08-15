--Easy-Level Tasks (10)
--Write a query to find the minimum (MIN) price of a product in the Products table.

 1. select min(price) as minimumprice from Products

--Write a query to find the maximum (MAX) Salary from the Employees table.

2. select max(salary) as maxsalary from Employees

--Write a query to count the number of rows in the Customers table.

select * from Customers

3. select count(CustomerID) from Customers

select count (*) CustomerID from Customers

--Write a query to count the number of unique product categories from the Products table.

select * from Products
4. select Count(distinct Category) as uniqueproducts from Products

--Write a query to find the total sales amount for the product with id 7 in the Sales table.

select * from Sales
7. select sum(Saleamount) as totalsalefor7 from Sales
   where productId = 7

--Write a query to calculate the average age of employees in the Employees table.

8. select avg(age) as avgage from employees

--Write a query to count the number of employees in each department.

select * from Employees
9. select count(DepartmentName) from Employees
group by DepartmentName

--Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.

10. select category, max(Price) as maxprice, min(price) as minprice from products
group by category

--Write a query to calculate the total sales per Customer in the Sales table.

select * from Sales
11. select customerid, sum(productid * saleamount) as totalsales from Sales
group by customerid

--Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).

select * from Employees
12. select departmentname, count(EmployeeID) as more_5_emp from Employees
group by DepartmentName
having count(EmployeeID) > 5

--Medium-Level Tasks (9)

--Write a query to calculate the total sales and average sales for each product category from the Sales table.

select * from Sales
13. select sum(saleamount) as totalsales from sales
    select avg(SaleAmount) as avgsales from sales

--Write a query to count the number of employees from the Department HR.

select * from employees
14. select departmentname, count(departmentname) as employeeshr from employees
    group by DepartmentName
    having DepartmentName = 'hr'

--Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).

select * from Employees
15. select departmentname, max(salary) as highest_salary, min(salary) as lowest_salary from employees
    group by departmentname

--Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).

16. select departmentname, avg(salary) as avg_salary from employees
    group by departmentname

--Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).

17. select departmentname, avg(salary) as avg_salary, count(*) employeeid from employees
    group by departmentname

--Write a query to filter product categories with an average price greater than 400.

select * from Products
18. select category, avg(price) as avgprice from products
    group by category
    having avg(price) > 400

--Write a query that calculates the total sales for each year in the Sales table.

select * from sales
19. select year(saledate), sum(saleamount) as totalsale from sales
    group by year(saledate)


--Write a query to show the list of customers who placed at least 3 orders.

select * from Sales
20. select customerid, count(saleid) as ordersamount from sales
    group by customerid
    having count(saleid) > 3

--Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).

select * from employees

21. select departmentname, avg(salary) as avgsalary from employees
    group by departmentname
    having avg(salary) > 60000

--Hard-Level Tasks (6)


--Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.

select * from products
22. select category, avg(price) as avgprice from products
    group by category 
	having avg(price) > 150

--Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.

select * from sales
23. select customerid, sum(saleamount) as totalorders from sales
    group by customerid
	having sum(saleamount) > 1500

--Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.

select * from employees

24. select departmentname, sum(salary) as total, avg(salary) as avgsalary from employees
    group by DepartmentName
    having avg(salary) > 65000

--Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.
--(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).

25. select * from sales
    select customerid, sum(saleamount) as total from sales
    group by customerid




--Write a query that calculates the total sales 
--and counts unique products sold in each month of each year,
--and then filter the months with at least 2 products sold.(Orders)


select * from Sales
26. select month(saledate) as monthname, sum(SaleAmount) as total, count( distinct productid) as uniquep from sales
    group by month(saledate)
    having count( distinct productid) > 2


--Write a query to find the MIN and MAX order quantity per Year. From orders table.

select * from orders

27. select year(orderdate), min(quantity) as minimum, max(quantity) as maximum from orders
    group by year(orderdate) 
