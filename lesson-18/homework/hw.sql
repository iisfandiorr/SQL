1. Create a temporary table named MonthlySales to store the total quantity sold and 
total revenue for each product in the current month.
Return: ProductID, TotalQuantity, TotalRevenue

select p.productid, sum(s.quantity) as totalquantity, sum(p.price * s.quantity) as totalrevenue
into #MonthlySales
from products p join sales s 
on p.productid = s.productid
group by p.productid, month(s.saledate)
having month(s.saledate) = 04

select * from #MonthlySales

2. Create a view named c that returns product info 
along with total sales quantity across all time.
Return: ProductID, ProductName, Category, TotalQuantitySold

create view vw_c 
as
select p.productid, p.productname, p.category, sum(s.quantity) as TotalQuantitySold
from products p join sales s 
on p.productid = s.productid
group by p.productid, p.productname, p.category

select * from vw_c

3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
Return: total revenue for the given product ID

create function fn_GetTotalRevenueForProduct(@ProductID INT)
returns decimal(18,2)
as
begin

	declare @totalrevenue decimal (18,2);
	SELECT @TotalRevenue = SUM(s.quantity * p.price)
    FROM products p
    JOIN sales s ON p.productid = s.productid
    WHERE p.productid = @ProductID;
	RETURN ISNULL(@TotalRevenue, 0);
end;

SELECT dbo.fn_GetTotalRevenueForProduct(3) AS TotalRevenue;


4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(SELECT p.productname, SUM(s.quantity) AS TotalQuantity, SUM(p.price * s.quantity) AS TotalRevenue
    FROM products p
    JOIN sales s ON p.productid = s.productid
    WHERE p.category = @Category
    GROUP BY p.productname
);


SELECT * FROM dbo.fn_GetSalesByCategory('electronics');

5. You have to create a function that get one argument as input from user 
and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. 
You can start it like this:

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @i INT = 2;
    IF @Number < 2
        RETURN 'No';

    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i += 1;
    END

    RETURN 'Yes';
END;

SELECT dbo.fn_IsPrime(7)  AS Result1, 
       dbo.fn_IsPrime(10) AS Result2,  
       dbo.fn_IsPrime(1)  AS Result3;  

6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
@Start INT
@End INT
CREATE FUNCTION dbo.fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Result TABLE (Number INT)
AS
BEGIN
    ;WITH Numbers AS (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM Numbers
        WHERE Number < @End
    )
    INSERT INTO @Result
    SELECT Number FROM Numbers
    OPTION (MAXRECURSION 0);

    RETURN;
END;
SELECT * FROM dbo.fn_GetNumbersBetween(20, 45);


7. Write a SQL query to return the Nth highest distinct salary from the Employee table.
If there are fewer than N distinct salaries, return NULL.

CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET (@N - 1) ROWS
        FETCH NEXT 1 ROWS ONLY
    );
END;

SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;

8. Write a SQL query to find the person who has the most friends.
Return: Their id, The total number of friends they have

SELECT TOP 1
    id,
    COUNT(DISTINCT friend_id) AS num
FROM (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC;

9. Create a View for Customer Order Summary.

CREATE view vw_CustomerOrderSummary
AS
SELECT C.CUSTOMER_ID, C.NAME, COUNT(O.ORDER_ID) AS TOTALORDERS, SUM(O.AMOUNT) AS TOTALAMOUNT,
MAX(O.ORDER_DATE) AS LASTORDERDATE FROM ORDERS O JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.NAME

SELECT * FROM vw_CustomerOrderSummary

10. Write an SQL statement to fill in the missing gaps.
You have to write only select statement, no need to modify the table.

SELECT 
    RowNumber,
    MAX(Workflow) OVER (
        ORDER BY RowNumber 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Workflow
FROM Workflows;


