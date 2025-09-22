1. Write a query to assign a row number to each sale based on the SaleDate.

select *,
		rank() over(order by saledate) as rnk
from productsales

2. Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.

select *,
		dense_rank() over(order by saleamount desc) as rnk
from productsales

3. Write a query to identify the top sale for each customer based on the SaleAmount.

select *,
		rank() over(partition by customerid order by saleamount desc) as rnk
from productsales

4. Write a query to display each sales amount along with the next sale amount in the order of SaleDate.


select day(saledate) as days, datename(month,saledate) as monthes, sum(saleamount) as totalday,
		lead(sum(saleamount), 1, 0) over(order by day(saledate)) as nextday
from productsales
group by day(saledate), datename(month, saledate)
order by day(saledate) asc


5. Write a query to display each sales amount along with the previous sale amount in the order of SaleDate.

select day(saledate) as days, datename(month,saledate) as monthes, sum(saleamount) as totalday,
		lag(sum(saleamount), 1, 0) over(order by day(saledate)) as previousday
from productsales
group by day(saledate), datename(month, saledate)
order by day(saledate) asc

6. Write a query to identify sales amounts that are greater than the previous sales amount

;with cte as 
(select day(saledate) as days, datename(month,saledate) as monthes, sum(saleamount) as totalday,
		lag(sum(saleamount), 1, 0) over(order by day(saledate)) as previousday
from productsales
group by day(saledate), datename(month, saledate)
)
select * from cte
where totalday > previousday

7. Write a query to calculate the difference in sale amount from the previous sale for every product

;with cte as 
(select day(saledate) as days, datename(month,saledate) as monthes, sum(saleamount) as totalday,
		lag(sum(saleamount), 1, 0) over(order by day(saledate)) as previousday
from productsales
group by day(saledate), datename(month, saledate)
)
SELECT 
    days,
    monthes,
    totalday,
    previousday,
    totalday - previousday AS difference
FROM cte

8.  Write a query to compare the current sale amount with the next sale amount in terms of percentage change.

;with cte as 
(select day(saledate) as days, datename(month,saledate) as monthes, sum(saleamount) as totalday,
		lag(sum(saleamount), 1, 0) over(order by day(saledate)) as previousday
from productsales
group by day(saledate), datename(month, saledate)
)
SELECT 
    days,
    monthes,
    totalday,
    previousday,
    totalday - previousday AS difference,
    CASE 
WHEN previousday = 0 THEN NULL
        ELSE (totalday - previousday) * 100.0 / previousday
    END AS percentage_change
FROM cte

9. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
Напишите запрос, чтобы вычислить отношение текущей суммы продажи к предыдущей сумме продажи для одного и того же продукта.

;WITH daily AS (
    SELECT 
        DAY(saledate) AS days,
        DATENAME(month, saledate) AS monthes,
        SUM(saleamount) AS totalday
    FROM productsales
    GROUP BY DAY(saledate), DATENAME(month, saledate)
),
cte AS (
    SELECT 
        days,
        monthes,
        totalday,
        LAG(totalday, 1, 0) OVER (ORDER BY days) AS previousday
    FROM daily
)
SELECT 
    days,
    monthes,
    totalday,
    previousday,
    CASE 
        WHEN previousday = 0 THEN NULL
        ELSE cast(CAST(totalday AS DECIMAL(10,2)) / previousday AS DECIMAL (10,2))
    END AS ratio
FROM cte
WHERE totalday > previousday;


10. Write a query to calculate the difference in sale amount from the very first sale of that product.
Напишите запрос, чтобы вычислить разницу в сумме продажи по сравнению с самой первой продажей данного продукта.


;with cte as (
select *,
first_value(saleamount) over (partition by productname order by productname) as firstsale
from productsales
)
select *, saleamount - firstsale as diff
from cte


11. Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
Напишите запрос, чтобы найти продажи, которые непрерывно увеличиваются для продукта (т.е. каждая сумма продажи больше предыдущей суммы продажи этого продукта).

;with cte as (
select *,
first_value(saleamount) over (partition by productname order by productname) as firstsale
from productsales
)
select *, saleamount - firstsale as diff
from cte
where saleamount - firstsale > 0

12. Write a query to calculate a "closing balance" (running total) for sales amounts which adds the current sale amount to a running total of previous sales.
Напишите запрос, чтобы вычислить «закрытый баланс» (накопительный итог) для сумм продаж, который добавляет текущую сумму продажи к накопленному итогу предыдущих продаж.

select *, 
		sum(saleamount) over (partition by productname order by saledate) as closing
from productsales

13. Write a query to calculate the moving average of sales amounts over the last 3 sales.
Напишите запрос, чтобы вычислить скользящее среднее по суммам продаж за последние 3 продажи.

select *, 
		avg(saleamount) over (partition by productname order by saledate rows between 2 preceding and current row ) as avgthreelast
from productsales

14. Write a query to show the difference between each sale amount and the average sale amount.
Напишите запрос, чтобы показать разницу между каждой суммой продажи и средней суммой продажи.

;with cte as (
select *, 
		avg(saleamount) over (partition by productname order by saledate) as average
from productsales
)
select *, saleamount - average as avgdiff
from cte
15. Find Employees Who Have the Same Salary Rank

;with cte as (
select *,
		dense_rank() over (order by employeeid) as rnk
from employees1 e )
select * from cte c
 WHERE rnk IN (
    SELECT rnk
    FROM cte
    GROUP BY rnk
    HAVING COUNT(*) > 1   -- выбираем только те ранги, которые встречаются у нескольких сотрудников
)
ORDER BY rnk, employeeid;


16. Identify the Top 2 Highest Salaries in Each Department

;with cte as (
select *, 
		DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS RNK
from employees1
)
select * 
from cte
WHERE RNK IN (1, 2)

17. Find the Lowest-Paid Employee in Each Department

;with cte as (
select *, 
		DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY ASC) AS RNK
from employees1
)
select * 
from cte
WHERE RNK = 1

18. Calculate the Running Total of Salaries in Each Department

;WITH CTE AS (
SELECT *,
		SUM(SALARY) OVER (PARTITION BY DEPARTMENT ORDER BY EMPLOYEEID) AS RUNNINGT
FROM EMPLOYEES1)
SELECT * FROM CTE

19. Find the Total Salary of Each Department Without GROUP BY

;WITH CTE AS (
SELECT *,
		SUM(SALARY) OVER (PARTITION BY DEPARTMENT) AS RUNNINGT
FROM EMPLOYEES1)
SELECT DISTINCT DEPARTMENT, RUNNINGT
FROM CTE

20. Calculate the Average Salary in Each Department Without GROUP BY

;WITH CTE AS (
SELECT *,
		AVG(SALARY) OVER (PARTITION BY DEPARTMENT) AS AVGT
FROM EMPLOYEES1)
SELECT DISTINCT DEPARTMENT, AVGT
FROM CTE

21. Find the Difference Between an Employee’s Salary and Their Department’s Average

;WITH CTE AS (
SELECT *,
		AVG(SALARY) OVER (PARTITION BY DEPARTMENT) AS AVGT
FROM EMPLOYEES1)
SELECT *, SALARY - AVGT AS DIFF
FROM CTE

22. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT *,
		AVG(SALARY) OVER (PARTITION BY DEPARTMENT ORDER BY (SELECT NULL) ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS AVGT
FROM EMPLOYEES1

23. Find the Sum of Salaries for the Last 3 Hired Employees

SELECT SUM(salary) AS total_last3
FROM (
    SELECT TOP 3 salary
    FROM employees1
    ORDER BY hiredate DESC   -- последние по дате найма
) t;
