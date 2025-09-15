
### 1. You must provide a report of all distributors and their sales by region.  
If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
Assume there is at least one sale for each region

;WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT 
    r.Region,
    d.Distributor,
    COALESCE(rs.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales rs
    ON rs.Region = r.Region
   AND rs.Distributor = d.Distributor
ORDER BY r.Region, d.Distributor;

### 2. Find managers with at least five direct reports

select e.name from employee e
join employee d on e.id = d.managerid
group by e.name
having count(d.name) > = 5

### 3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

SELECT p.product_name, sum(o.unit) as unit
FROM products p
JOIN orders o 
  ON p.product_id = o.product_id
WHERE YEAR(o.order_date) = 2020
  AND MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100
order by sum(o.unit) desc;

### 4. Write an SQL statement that returns the vendor from which each customer has placed the most orders

WITH VendorCounts AS (
    SELECT CustomerID,
           Vendor,
           COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
Ranked AS (
    SELECT vc.*,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderCount DESC) AS rn
    FROM VendorCounts vc
)
SELECT CustomerID, Vendor
FROM Ranked
WHERE rn = 1;

### 5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else return 'This number is not prime'

DECLARE @Check_Prime INT = 29;  -- число для проверки
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

IF @Check_Prime < 2
    SET @isPrime = 0;
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i += 1;
    END
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

### 6. Write an SQL query to return the number of locations,in which location most signals sent, 
and total number of signal for each device from the given table.

;WITH LocationCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
Ranked AS (
    SELECT 
        Device_id,
        Locations,
        SignalCount,
        RANK() OVER (PARTITION BY Device_id ORDER BY SignalCount DESC) AS rnk
    FROM LocationCounts
),
Summary AS (
    SELECT 
        Device_id,
        COUNT(DISTINCT Locations) AS Num_Locations,
        SUM(SignalCount) AS Total_Signals
    FROM LocationCounts
    GROUP BY Device_id
)
SELECT 
    s.Device_id,
    s.Num_Locations,
    r.Locations AS Top_Location,
    s.Total_Signals
FROM Summary s
JOIN Ranked r 
  ON s.Device_id = r.Device_id
 AND r.rnk = 1;

### 7. Write a SQL  to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output

WITH DeptAvg AS (
    SELECT deptid, AVG(salary) AS avg_salary
    FROM employee
    GROUP BY deptid
)
SELECT e.empid, e.empname, e.salary
FROM employee e
JOIN DeptAvg d
  ON e.deptid = d.deptid
WHERE e.salary > d.avg_salary;

### 8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. 

WITH TicketMatches AS (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS TicketNums,              
        COUNT(DISTINCT w.Number) AS MatchCount               
    FROM Tickets t
    LEFT JOIN Numbers w 
           ON t.Number = w.Number
    GROUP BY t.TicketID
),
TicketWinnings AS (
    SELECT 
        TicketID,
        CASE 
            WHEN MatchCount = (SELECT COUNT(*) FROM Numbers) 
                 THEN 100          
            WHEN MatchCount > 0 
                 THEN 10           
            ELSE 0                  
        END AS Prize
    FROM TicketMatches
)
SELECT SUM(Prize) AS TotalWinnings
FROM TicketWinnings;

 9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.

;WITH user_day AS (
    SELECT 
        spend_date,
        user_id,
        MAX(CASE WHEN platform = 'Mobile' THEN 1 ELSE 0 END) AS has_mobile,
        MAX(CASE WHEN platform = 'Desktop' THEN 1 ELSE 0 END) AS has_desktop,
        SUM(amount) AS total_amount
    FROM spending
    GROUP BY spend_date, user_id
),
categorized AS (
    SELECT 
        spend_date,
        user_id,
        CASE 
            WHEN has_mobile = 1 AND has_desktop = 0 THEN 'Mobile'
            WHEN has_desktop = 1 AND has_mobile = 0 THEN 'Desktop'
            WHEN has_mobile = 1 AND has_desktop = 1 THEN 'Both'
        END AS platform,
        total_amount
    FROM user_day
)
SELECT 
    spend_date,
    platform,
    SUM(total_amount) AS total_amount,
    COUNT(user_id) AS total_users
FROM categorized
GROUP BY spend_date, platform
ORDER BY spend_date,
         CASE platform WHEN 'Mobile' THEN 1 WHEN 'Desktop' THEN 2 WHEN 'Both' THEN 3 END;



### 10. Write an SQL Statement to de-group the following data.

;WITH MaxQ AS (
    SELECT MAX(Quantity) AS max_qty
    FROM Grouped
),
Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers, MaxQ
    WHERE n < MaxQ.max_qty
)
SELECT 
    g.Product,
    1 AS Quantity
FROM Grouped g
JOIN Numbers n
    ON n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
































