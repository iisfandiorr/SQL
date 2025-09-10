1. Create a numbers table using a recursive query from 1 to 1000.
  
;with numbers as (
select 1 as n
union all
select n + 1
from numbers where n < 1000
) select * from numbers 

2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)

select employeeid, sum(salesamount) as totalsale
from ( select s.salesamount, e.employeeid
from sales s join employees e
on s.employeeid = e.employeeid
) as employeesales group by employeeid

3. Create a CTE to find the average salary of employees.(Employees)

;with cte_avgsalary as(
select avg(salary) as avgsalary
from employees
) select avgsalary from cte_avgsalary

4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)

select productid, max(salesamount) as maxsale
from (  select s.salesamount, p.productid
from sales s join products p 
on s.productid = p.productid) as productmaxsale group by productid

5. Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.

;with numbers as (
select 1 as n
union all
select n * 2
from numbers where n < 1000000
) select * from numbers 

6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
Использовать CTE, чтобы получить имена сотрудников, совершивших более 5 продаж (Sales, Employees).

;with cte_sales as(
select e.employeeid, count(s.salesid) as salesamount
from employees e join sales s
on e.employeeid = s.employeeid
group by e.employeeid)
select employeeid, salesamount from cte_sales 
where salesamount > 5

7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
  
;with cte_sales as (
select sum(s.salesamount) saleamount, p.productid
from sales s join products p
on p.productid = s.productid
group by p.productid)
select productid, saleamount from cte_sales
where saleamount > 500

8. Create a CTE to find employees with salaries above the average salary.(Employees)

;with cte_avgsalary as (
select avg(salary) as avgsalary from employees
) select e.employeeid, e.salary from employees e 
cross join cte_avgsalary s
where e.salary > s.avgsalary

9. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)

select employeeid, count(salesid) as totalsale
from ( select e.employeeid, s.salesid 
from employees e join sales s
on s.employeeid = e.employeeid) as employeesales
group by employeeid
order by totalsale desc
offset 0 rows fetch next 5 rows only
-- or --
select top 5 employeeid, count(salesid) as totalsale
from ( select e.employeeid, s.salesid 
from employees e join sales s
on s.employeeid = e.employeeid) as employeesales
group by employeeid
order by totalsale desc

10. Write a query using a derived table to find the sales per product category.(Sales, Products)

select categoryid , sum(salesamount) as totalsales
from ( select p.categoryid, s.salesamount
from products p join sales s
on p.productid = s.productid ) as salessamount
group by categoryid

11. Write a script to return the factorial of each value next to it.(Numbers1)

  ;WITH FactorialCTE AS (
    SELECT Number, CAST(1 AS BIGINT) AS Factorial, 1 AS Counter
    FROM Numbers1
    WHERE Number >= 1

    UNION ALL

    SELECT f.Number, f.Factorial * (f.Counter + 1), f.Counter + 1
    FROM FactorialCTE f
    WHERE f.Counter + 1 <= f.Number
)
SELECT Number, MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number
OPTION (MAXRECURSION 0);


12. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

;WITH RecursiveSplit AS (
    SELECT
        Id,
        String,
        SUBSTRING(String, 1, 1) AS Character,
        1 AS Position
    FROM
        example
    UNION ALL
    SELECT
        T.Id,
        T.String,
        SUBSTRING(T.String, T.Position + 1, 1) AS Character,
        T.Position + 1 AS Position
    FROM
        RecursiveSplit AS T
    WHERE
        T.Position < LEN(T.String)
)
SELECT
    Id,
    Position,
    Character
FROM
    RecursiveSplit
ORDER BY
    Id, Position;

13. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)

;WITH cte_sales AS (
    SELECT 
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        DATENAME(month, SaleDate) AS MonthName,
        SUM(SalesAmount) AS TotalSale
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate), DATENAME(month, SaleDate)
)
SELECT 
    SaleYear,
    SaleMonth,
    MonthName,
    TotalSale,
    TotalSale - LAG(TotalSale) OVER (ORDER BY SaleYear, SaleMonth) AS SalesDifference
FROM cte_sales
ORDER BY SaleYear, SaleMonth

14. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)

SELECT EmployeeID, 
       DATEPART(QUARTER, SaleDate) AS QuarterNum,
       SUM(SalesAmount) AS TotalSales
FROM (
    SELECT e.EmployeeID, s.SalesAmount, s.SaleDate
    FROM Employees e
    JOIN Sales s 
        ON s.EmployeeID = e.EmployeeID
) AS SaleQuarter
GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
HAVING SUM(SalesAmount) > 45000
ORDER BY EmployeeID, QuarterNum;

15. This script uses recursion to calculate Fibonacci numbers
  
;WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS FibPrev, 1 AS FibCurr
    UNION ALL
    SELECT n + 1, FibCurr, FibPrev + FibCurr
    FROM Fibonacci
    WHERE n < 20 
)
SELECT n, FibCurr AS FibonacciNumber
FROM Fibonacci
OPTION (MAXRECURSION 0);

16. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

SELECT vals
FROM FindSameCharacters
WHERE LEN(vals) > 1
  AND LEN(REPLACE(vals, LEFT(vals, 1), '')) = 0;

17. Create a numbers table that shows all numbers 1 through n 
and their order gradually increasing by the next number in the sequence.
(Example:n=5 | 1, 12, 123, 1234, 12345)

;WITH Numbers AS (
    SELECT 1 AS Num, CAST('1' AS VARCHAR(MAX)) AS Seq
    UNION ALL
    SELECT Num + 1,
           Seq + CAST(Num + 1 AS VARCHAR)
    FROM Numbers
    WHERE Num < 9
)
SELECT Seq
FROM Numbers
OPTION (MAXRECURSION 0);

18. Write a query using a derived table to find the employees 
who have made the most sales in the last 6 months.(Employees, Sales)

SELECT TOP 1
       EmployeeID,
       SUM(SalesAmount) AS TotalSales
FROM (
    SELECT e.EmployeeID, s.SalesAmount, s.SaleDate
    FROM Sales s
    JOIN Employees e ON e.EmployeeID = s.EmployeeID
    WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
) AS LastSixMonths
GROUP BY EmployeeID
ORDER BY TotalSales DESC;

19. Write a T-SQL query to remove the duplicate integer values present in the string column. 
Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

;WITH Extracted AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        RIGHT(Pawan_slug_name, CHARINDEX('-', REVERSE(Pawan_slug_name)) - 1) AS NumPart,
        LEFT(Pawan_slug_name, LEN(Pawan_slug_name) - (CHARINDEX('-', REVERSE(Pawan_slug_name)))) AS NamePart
    FROM RemoveDuplicateIntsFromNames
),
Filtered AS (
    SELECT DISTINCT 
        PawanName,
        NamePart,
        NumPart
    FROM Extracted
    WHERE LEN(NumPart) > 1  
)
SELECT 
    PawanName,
    NamePart + '-' + NumPart AS CleanedSlug
FROM Filtered;




















