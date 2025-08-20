Easy-Level Tasks (10)

--Easy (10 puzzles)
--Using Products, Suppliers table List all combinations of product names and supplier names.

SELECT P.PRODUCTNAME, S.SUPPLIERNAME 
FROM PRODUCTS P JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID

--Using Departments, Employees table Get all combinations of departments and employees.

SELECT E.NAME, D.DEPARTMENTNAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENTID = D.DEPARTMENTID

--Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. 
--Return supplier name and product name

SELECT P.PRODUCTNAME, S.SUPPLIERNAME
FROM PRODUCTS P JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID

--Using Orders, Customers table List customer names and their orders ID.

SELECT C.FIRSTNAME, C.LASTNAME, O.ORDERID
FROM CUSTOMERS C JOIN ORDERS O
ON C.CUSTOMERID = O.CUSTOMERID

--Using Courses, Students table Get all combinations of students and courses.

SELECT C.COURSENAME, S.NAME FROM COURSES C
CROSS JOIN STUDENTS S

--Using Products, Orders table Get product names and orders where product IDs match.

SELECT P.PRODUCTNAME, O.ORDERID
FROM PRODUCTS P JOIN ORDERS O 
ON P.PRODUCTID = O.PRODUCTID

--Using Departments, Employees table List employees whose DepartmentID matches the department.

SELECT E.EMPLOYEEID, E.NAME, D.DEPARTMENTNAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENTID = D.DEPARTMENTID

--Using Students, Enrollments table List student names and their enrolled course IDs.

SELECT S.NAME, E.COURSEID
FROM STUDENTS S JOIN ENROLLMENTS E
ON S.STUDENTID = E.STUDENTID 

--Using Payments, Orders table List all orders that have matching payments.

SELECT P.PAYMENTID, O.ORDERID
FROM PAYMENTS P JOIN ORDERS O 
ON P.ORDERID = O.ORDERID

--Using Orders, Products table Show orders where product price is more than 100.

SELECT P.PRODUCTNAME, P.PRICE, O.ORDERID
FROM PRODUCTS P JOIN ORDERS O
ON P.PRODUCTID = O.PRODUCTID
WHERE P.PRICE > 100

--Medium (10 puzzles)

--Using Employees, Departments table List employee names and department names where department IDs are not equal. 
--It means: Show all mismatched employee-department combinations.

SELECT E.NAME, D.DEPARTMENTNAME 
FROM EMPLOYEES E CROSS JOIN DEPARTMENTS D
WHERE E.DEPARTMENTID <> D.DEPARTMENTID

--Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.

SELECT O.ORDERID, O.QUANTITY, P.PRODUCTID, P.STOCKQUANTITY
FROM Orders O JOIN Products P 
  ON O.ProductID = P.ProductID
WHERE O.QUANTITY > P.STOCKQUANTITY;

--Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.

SELECT C.FIRSTNAME, C.LASTNAME, S.PRODUCTID
FROM CUSTOMERS C JOIN SALES S
ON C.CUSTOMERID = S.CUSTOMERID
WHERE S.SALEAMOUNT > 500

--Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.

SELECT S.NAME, C.COURSENAME
FROM STUDENTS AS S
JOIN ENROLLMENTS E ON S.STUDENTID = E.STUDENTID
JOIN COURSES C ON E.COURSEID = C.COURSEID

--Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.

SELECT P.PRODUCTNAME, S.SUPPLIERNAME
FROM PRODUCTS P
JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID
WHERE SUPPLIERNAME = 'TECH'

--Using Orders, Payments table Show orders where payment amount is less than total amount.


SELECT O.ORDERID, P.AMOUNT
FROM ORDERS O JOIN PAYMENTS P
ON O.ORDERID = P.ORDERID
WHERE P.AMOUNT > O.TOTALAMOUNT

--Using Employees and Departments tables, get the Department Name for each employee.

SELECT E.NAME, D.DEPARTMENTNAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENTID = D.DEPARTMENTID
ORDER BY D.DEPARTMENTNAME DESC

--Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.

SELECT P.PRODUCTNAME, C.CATEGORYNAME
FROM PRODUCTS P JOIN CATEGORIES C
ON P.CATEGORY = C.CATEGORYID
WHERE C.CATEGORYNAME = 'ELECTRONICS' OR C.CATEGORYNAME = 'FURNITURE'

--Using Sales, Customers table Show all sales from customers who are from 'USA'.


SELECT C.FIRSTNAME, C.LASTNAME, C.COUNTRY, S.SALEID
FROM CUSTOMERS C
JOIN SALES S
ON C.CUSTOMERID = S.CUSTOMERID
WHERE C.COUNTRY = 'USA'

--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.

SELECT O.ORDERID, C.FIRSTNAME, C.COUNTRY, O.TOTALAMOUNT
FROM ORDERS O JOIN CUSTOMERS C
ON O.CUSTOMERID = C.CUSTOMERID
WHERE C.COUNTRY = 'GERMANY' AND O.TOTALAMOUNT > 100

--Hard (5 puzzles)(Do some research for the tasks below)


--Using Employees table List all pairs of employees from different departments.

SELECT * FROM EMPLOYEES
SELECT * FROM DEPARTMENTS

SELECT E1.NAME, E2.NAME
FROM EMPLOYEES E1 JOIN EMPLOYEES E2
ON E1.DEPARTMENTID <> E2.DEPARTMENTID
WHERE E1.DEPARTMENTID < E2.DEPARTMENTID

--Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).

SELECT P.PaymentID, P.Amount AS PaidAmount, (O.Quantity * PP.Price) AS ExpectedAmount
FROM Payments P
JOIN Orders O ON P.OrderID = O.OrderID
JOIN Products PP ON O.ProductID = PP.ProductID
WHERE P.Amount <> (O.Quantity * PP.Price);

--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.


SELECT S.StudentID, S.Name
FROM Students S
LEFT JOIN Enrollments E 
    ON S.StudentID = E.StudentID
WHERE E.EnrollmentID IS NULL;

--Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.

SELECT 
    E1.EmployeeID AS ManagerID,
    E1.Name AS ManagerName,
    E1.Salary AS ManagerSalary,
    E2.EmployeeID AS EmployeeID,
    E2.Name AS EmployeeName,
    E2.Salary AS EmployeeSalary
FROM Employees E1
JOIN Employees E2
    ON E1.EmployeeID = E2.ManagerID
WHERE E1.Salary <= E2.Salary;

--Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

SELECT C.FIRSTNAME, C.LASTNAME, C.CUSTOMERID, O.ORDERID, P.PAYMENTID
FROM ORDERS O
JOIN CUSTOMERS C  ON C.CUSTOMERID = O.CUSTOMERID
LEFT JOIN PAYMENTS P ON O.ORDERID = P.ORDERID
WHERE P.ORDERID IS NULL

