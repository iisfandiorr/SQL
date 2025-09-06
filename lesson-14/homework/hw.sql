## Easy Tasks

1. Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname. (TestMultipleColumns)

SELECT 
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS FirstName,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS LastName
FROM TestMultipleColumns;

2. Write a SQL query to find strings from a table where the string itself contains the % character. (TestPercent)

select * from testpercent
where strs like '%[%]%'

3. In this puzzle you will have to split a string based on dot(.). (Splitter)

select ltrim(rtrim(replace(vals, '.', ','))) as splitted from splitter

4. Write a SQL query to replace all integers (digits) in the string with 'X'. (1234ABC123456XYZ1234567890ADS)

select ltrim(rtrim(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace('1234ABC123456XYZ1234567890ADS', '0', 'x'),
'1', 'x'), 
'2', 'x'),
'3', 'x'), 
'4', 'x'), 
'5', 'x'), 
'6', 'x'), 
'7', 'x'), 
'8', 'x'), 
'9', 'x')))
as xxx

5. Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.). (testDots)

select * from testdots
where vals like '%.%.%.%'

6. Write a SQL query to count the spaces present in the string. (CountSpaces)

select len(texts) - len(replace(texts, ' ', '')) as countspace from countspaces

7. Write a SQL query that finds out employees who earn more than their managers. (Employee)

SELECT e.Name AS EmployeeName,
       e.Salary AS EmployeeSalary,
       m.Name AS ManagerName,
       m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;

8. Find the employees who have been with the company for more than 10 years, but less than 15 years.
Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service. (Employees)

select employee_id, first_name, last_name, hire_date, datediff(year, hire_date, getdate()) as years_of_service from employees
where datediff(year, hire_date, getdate()) > = 10 and datediff(year, hire_date, getdate()) < = 15

## Medium Tasks

9. Write a SQL query to separate the integer values and the character values into two different columns. (rtcfvty34redt)

select replace(translate('rtcfvty34redt', '0123456789', replicate (' ', 10)), ' ', '') as onlyletters
select replace(translate('rtcfvty34redt', 'qwertyuiopasdfghjklzxcvbnm', replicate( ' ', 26)), ' ', '') as onlynumbers

10. Write a SQL query to find all dates Ids with higher temperature compared to its previous (yesterdays) dates. (weather)

select w1.id 
from weather w1
join weather w2
on dateadd(day, -1, w1.recorddate) = w2.recorddate 
where w1.temperature > w2.temperature

11. Write an SQL query that reports the first login date for each player. (Activity)

select player_id, min(event_date) as firstentry from activity
group by player_id

12. Your task is to return the third item from that list. (fruits)

SELECT LTRIM(RTRIM(
    SUBSTRING(
        fruit_list,
        CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1,
        CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1)
          - CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - 1
    )
)) AS third_item
FROM fruits;

13. Write a SQL query to create a table where each character from the string will be converted into a row. (sdgfhsdgfhs\@121313131)

-- Входная строка
DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

-- Генерим числа и вытаскиваем символы по одному
SELECT SUBSTRING(@str, n, 1) AS character
FROM (
    SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
) AS numbers;

14. You are given two tables: p1 and p2. Join these tables on the id column. 

SELECT 
    p1.id,
    CASE 
        WHEN p1.code = 0 THEN p2.code
        ELSE p1.code
    END AS final_code
FROM p1
JOIN p2 ON p1.id = p2.id;

15. Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. (Employees)

* `<1 год` → New Hire
* `1–5` → Junior
* `5–10` → Mid-Level
* `10–20` → Senior
* `>20` → Veteran

SELECT first_name, hire_date,
CASE 
  WHEN DATEDIFF(YEAR, hire_date, GETDATE()) < 1 THEN 'New Hire'
  WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
  WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
  WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
  ELSE 'Veteran'
  END AS employee_experience
FROM employees;

16. Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals. (GetIntegers)

SELECT 
    LEFT(vals, PATINDEX('%[^0-9]%', vals + 'a') - 1) AS starting_number
FROM GetIntegers;

Difficult Tasks

17. In this puzzle you have to swap the first two letters of the comma separated string. (MultipleVals)

WITH Splitted AS (
    SELECT value AS part
    FROM MultipleVals
    CROSS APPLY STRING_SPLIT(vals, ',')
)
SELECT STRING_AGG(
           STUFF(part, 1, 2, RIGHT(LEFT(part, 2), 1) + LEFT(part, 1)),
           ','
       ) AS swapped
FROM Splitted;

18. Write a SQL query that reports the device that is first logged in for each player. (Activity)

SELECT player_id, device_id
FROM (
    SELECT 
        player_id,
        device_id,
        event_date,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM Activity
) t
WHERE rn = 1;

19. You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
(WeekPercentagePuzzle)

SELECT 
    Area,
    FinancialWeek,
    Date,
    ISNULL(SalesLocal,0) + ISNULL(SalesRemote,0) AS DaySales,
    SUM(ISNULL(SalesLocal,0) + ISNULL(SalesRemote,0)) 
        OVER (PARTITION BY Area, FinancialWeek) AS WeekSales,
    CAST(100.0 * (ISNULL(SalesLocal,0) + ISNULL(SalesRemote,0)) 
         / NULLIF(SUM(ISNULL(SalesLocal,0) + ISNULL(SalesRemote,0)) 
                  OVER (PARTITION BY Area, FinancialWeek), 0) AS DECIMAL(5,2)) 
         AS PercentOfWeek
FROM WeekPercentagePuzzle
ORDER BY Area, FinancialWeek, Date;

