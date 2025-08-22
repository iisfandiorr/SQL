--Easy-Level Tasks (10)
--Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, 
--along with their department names.
--Expected Columns: EmployeeName, Salary, DepartmentName

select e.name as employeename , e.salary, d.departmentname
from employees e join departments d 
on e.departmentid = d.departmentid
where e.salary > 50000

--Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--Expected Columns: FirstName, LastName, OrderDate

select c.firstname, c.lastname, o.orderdate
from customers c join orders o
on o.customerid = c.customerid
where year(orderdate) = 2023

--Using the Employees and Departments tables, write a query to show all employees along with their department names. 
--Include employees who do not belong to any department.
--Expected Columns: EmployeeName, DepartmentName

select e.name, d.departmentname from employees e full outer join departments d 
on d.departmentid = e.departmentid

--Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. 
--Show suppliers even if they don’t supply any product.
--Expected Columns: SupplierName, ProductName

select s.suppliername, p.productname
from suppliers s full outer join products p
on p.supplierid = s.supplierid

--Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. 
--Include orders without payments and payments not linked to any order.
--Expected Columns: OrderID, OrderDate, PaymentDate, Amount

select o.orderid, o.orderdate, p.paymentdate, p.amount
from orders o full outer join payments p
on o.orderid = p.orderid

--Using the Employees table, write a query to show each employee"s name along with the name of their manager.
--🔁 Expected Columns: EmployeeName, ManagerName

select e.name, c.name as managername
from employees e left join employees c
on e.employeeid = c.managerid

--Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Columns: StudentName, CourseName

select s.name as name, c.coursename
from enrollments e
join courses c on c.courseid = e.courseid
join students s on s.studentid = e.studentid
where c.coursename = 'math 101'

--Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items.
--Return their name and the quantity they ordered.
--🔁 Expected Columns: FirstName, LastName, Quantity

select c.firstname, c.lastname, o.quantity
from customers c join orders o
on c.customerid = o.customerid 
where quantity > 3

--Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Columns: EmployeeName, DepartmentName

select e.name, d.departmentname from employees e
join departments d 
on d.departmentid = e.departmentid
where d.departmentname = 'human resources'

--🟠 Medium-Level Tasks (9)
--Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
--🔁 Expected Columns: DepartmentName, EmployeeCount

select d.departmentname, count(e.name) as employeecount
from departments d join employees e
on d.departmentid = e.departmentid
group by d.departmentname
having count(e.name) > 5

--Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Columns: ProductID, ProductName

select p.productid, p.productname
from products p left join sales s 
on p.productid = s.productid
where s.productid is null

--Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Columns: FirstName, LastName, TotalOrders


select c.firstname, c.lastname, count(o.orderid) as total_orders
from customers c join orders o
on c.customerid = o.customerid
group by c.firstname, c.lastname
having count(o.orderid) >=1

--Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Columns: EmployeeName, DepartmentName

select e.name, d.departmentname 
from employees e join departments d
on e.departmentid = d.departmentid

--Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Columns: Employee1, Employee2, ManagerID

SELECT 
    e1.name AS Employee1,
    e2.name AS Employee2,
    m.name  AS ManagerName
FROM employees e1
JOIN employees e2
    ON e1.managerid = e2.managerid
   AND e1.employeeid < e2.employeeid
JOIN employees m
    ON e1.managerid = m.employeeid;

--Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName

select o.orderid, o.orderdate, c.firstname, c.lastname
from orders o
join customers c 
on o.customerid = c.customerid 
where year(orderdate) = 2022

--Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName

select e.name as employeename , e.salary, d.departmentname
from employees e join departments d 
on e.departmentid = d.departmentid
where e.salary > 60000 and d.departmentname = 'sales'

--Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

select o.orderid, o.orderdate, p.paymentdate, p.amount
from orders o join payments p
on o.orderid = p.orderid

--Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Columns: ProductID, ProductName

select p.productid, p.productname
from products p left join orders o
on p.productid = o.orderid
where p.productid is null

--🔴 Hard-Level Tasks (9)
--Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
--🔁 Expected Columns: EmployeeName, Salary

SELECT e.name AS EmployeeName,
       e.salary AS Salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.departmentid = e.departmentid
);

--Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate

SELECT o.orderid, o.orderdate
FROM orders o
LEFT JOIN payments p
    ON o.orderid = p.orderid
WHERE p.orderid IS NULL
  AND o.orderdate < '2020-01-01';


--Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Columns: ProductID, ProductName

SELECT p.productid, p.productname
FROM products p
LEFT JOIN categories c
    ON p.category = c.categoryid
WHERE c.categoryid IS NULL;

--Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary

SELECT 
    e1.name AS Employee1,
    e2.name AS Employee2,
    e1.managerid AS ManagerID,
    e1.salary AS Salary
FROM employees e1
JOIN employees e2
    ON e1.managerid = e2.managerid
   AND e1.employeeid < e2.employeeid
WHERE e1.salary > 60000
  AND e2.salary > 60000;


--Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT e.name AS EmployeeName,
       d.departmentname AS DepartmentName
FROM employees e
JOIN departments d
    ON e.departmentid = d.departmentid
WHERE d.departmentname LIKE 'M%';

--Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Columns: SaleID, ProductName, SaleAmount

SELECT s.saleid,
       p.productname,
       s.saleamount AS SaleAmount
FROM sales s
JOIN products p
    ON s.productid = p.productid
WHERE s.saleamount > 500;

--Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Columns: StudentID, StudentName

select s.name as name
from enrollments e
join courses c on c.courseid = e.courseid
join students s on s.studentid = e.studentid
where c.coursename <> 'math 101'

--Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Columns: OrderID, OrderDate, PaymentID

select o.orderid, o.orderdate, p.paymentid
from orders o full outer join payments p
on p.orderid = o.orderid
where p.paymentid is null or o.orderid is null or o.orderdate is null

--Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Columns: ProductID, ProductName, CategoryName

select p.productid, p.productname, c.categoryname
from products p join categories c
on p.category = c.categoryid
where c.categoryname = 'electronics' or c.categoryname = 'furniture'
