Task 1:
Create a stored procedure that:
- Creates a temp table `#EmployeeBonus`
- Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
  - (BonusAmount = Salary * BonusPercentage / 100)
- Then, selects all data from the temp table.

CREATE PROCEDURE task1sp
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(200),
        Department NVARCHAR(100),
        Salary DECIMAL(18,2),
        BonusAmount DECIMAL(10,2)
    );
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
        e.Department,
        e.Salary,
        CAST((e.Salary * d.BonusPercentage) / 100 AS DECIMAL(10,2)) AS BonusAmount
    FROM employees e
    JOIN departmentbonus d
        ON d.Department = e.Department;
    SELECT * FROM #EmployeeBonus;
END;

exec task1sp




Task 2:

Create a stored procedure that:

- Accepts a department name and an increase percentage as parameters
- Update salary of all employees in the given department by the given percentage
- Returns updated employees from that department.

create procedure increase_salary @Depname varchar(50)
as 
begin
   select * from employees
   where department = @Depname ;

   Select 'Increase salary of employees on this dept' as News;

	update employees
	set salary = salary * 1.1
	where department = @Depname;

	select * from employees
	where department = @Depname
end

exec increase_salary @Depname = 'Sales'


--Part 2: MERGE Tasks

select * from Products_Current
select * from Products_New

Task 3:

Perform a MERGE operation that:

- Updates `ProductName` and `Price` if `ProductID` matches
- Inserts new products if `ProductID` does not exist
- Deletes products from `Products_Current` if they are missing in `Products_New`
- Return the final state of `Products_Current` after the MERGE.

MERGE Products_Current AS target
USING Products_New AS source
ON target.productid = source.productid
WHEN MATCHED THEN
    UPDATE SET target.price = source.price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (productid, productname, price)
    VALUES (source.productid, source.productname, source.price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE; 

select * from Products_Current
select * from Products_New

Task 4:

Tree Node

	SELECT 
    t.id,
    CASE 
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN NOT EXISTS (SELECT 1 FROM tree WHERE p_id = t.id) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM tree t
ORDER BY t.id;

Task 5:

Confirmation Rate

Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.


select * from Confirmations

SELECT user_id, CAST(CAST(SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS DECIMAL(10,2))/ NULLIF(COUNT(user_id), 0) AS DECIMAL(10,2)
    ) AS confirmation_rate
FROM Confirmations
GROUP BY user_id;

Task 6:

Find employees with the lowest salary

select * from employees
where salary = (select min(salary) from employees)

Task 7:
Get Product Sales Summary
Create a stored procedure called `GetProductSalesSummary` that:

create proc GetProductSalesSummary @ProductID int
as 
begin
	select p.productname, sum(s.quantity) as TotalQuantitySold, sum(p.price * s.quantity) as totalsalesamount, 
	min(s.saledate) as firstsaledate, max(s.saledate) as lastsaledate
	from products p left join sales s on s.productid = p.productid
	where p.productid = @ProductID
	group by p.productid, p.productname
end

exec GetProductSalesSummary 9
