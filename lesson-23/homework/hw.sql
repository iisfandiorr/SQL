Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. 
Please check out sample input and expected output.

SELECT *,
       RIGHT('0' + CAST(DAY(dt) AS VARCHAR(2)), 2) AS monthprefixedwithzero
FROM dates;

Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. 
You also have to find out the SUM of Max values of vals columns for each Id and RId. 
For more details please see the sample input and expected output.

;WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY id, rid ORDER BY vals DESC) AS rn
    FROM mytabel
)
SELECT count(distinct id) AS DISTINCT_IDS , rid, SUM(vals) AS total_max_vals
FROM cte
WHERE rn = 1
GROUP BY rid;


Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. 
Please see the sample input and expected output.

SELECT * FROM TestFixLengths
WHERE LEN(VALS) BETWEEN 6 AND 10

Puzzle 4: In this puzzle you have to find the maximum value for each Id 
and then get the Item for that Id and Maximum value. 
Please check out sample input and expected output.

;WITH CTE AS(
select *,
		DENSE_RANK() OVER(PARTITION BY ID ORDER BY VALS DESC) AS VALSS
FROM TESTMAXIMUM)
SELECT ID, ITEM, VALS FROM CTE
WHERE VALSS = 1

Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, 
and then Sum the data using Id only. Please check out sample input and expected output.

;with cte as(
SELECT *,
		dense_rank() over (partition by detailednumber order by vals desc) as rnk
from sumofmax)
select id, sum(vals) as sumofmax
from cte
group by id, rnk
having rnk = 1


Puzzle 6: In this puzzle you have to find difference 
between a and b column between each row and if the difference is not equal to 0 
then show the difference i.e. a – b otherwise 0. 
Now you need to replace this zero with blank.
Please check the sample input and the expected output.

;WITH cte AS (
    SELECT *,
           a - b AS output
    FROM TheZeroPuzzle
)
SELECT id, a,b,
       CASE 
           WHEN output = 0 THEN ''
           ELSE CAST(output AS VARCHAR(10))
       END AS outputt
FROM cte;

select * from sales

7. What is the total revenue generated from all sales?  

select sum(quantitysold * unitprice) as total from sales

8. What is the average unit price of products?  

select avg(unitprice) as avg from sales

9. How many sales transactions were recorded?  

select count(saleid) as saletransc from sales

10. What is the highest number of units sold in a single transaction?  

select * from sales
where quantitysold = (select max(quantitysold) from sales)

11. How many products were sold in each category?  

select category, count(quantitysold) as countp from sales
group by category

12. What is the total revenue for each region?  

select region, sum(quantitysold * unitprice) as total
from sales
group by region

13. Which product generated the highest total revenue?  

select top 1 product, sum(quantitysold * unitprice) as total
from sales
group by product
order by sum(quantitysold * unitprice) desc

14. Compute the running total of revenue ordered by sale date.  

select *,
		sum(quantitysold * unitprice) over(order by saledate) as runningtotal
from sales

15. How much does each category contribute to total sales revenue?  


SELECT 
    category,
    sum(quantitysold * unitprice) AS category_sales,
    sum(quantitysold * unitprice) * 100.0 / SUM(sum(quantitysold * unitprice)) OVER() AS pct_of_total
FROM sales
GROUP BY category;


---

select * from Customers
select * from sales


17. Show all sales along with the corresponding customer names  

select c.* , s.*
from sales s
join customers c
on c.customerid = s.customerid

18. List customers who have not made any purchases  


select c.* , s.*
from customers c
left join sales s
on c.customerid = s.customerid
where saleid is null

19. Compute total revenue generated from each customer  

SELECT 
    c.customerid,
    c.customername,
    SUM(s.quantitysold * s.unitprice) AS total_revenue
FROM customers c
JOIN sales s
    ON c.customerid = s.customerid
GROUP BY c.customerid, c.customername
ORDER BY total_revenue DESC;


20. Find the customer who has contributed the most revenue  

SELECT top 1
    c.customerid,
    c.customername,
    SUM(s.quantitysold * s.unitprice) AS total_revenue
FROM customers c
JOIN sales s
    ON c.customerid = s.customerid
GROUP BY c.customerid, c.customername
ORDER BY total_revenue DESC;


21. Calculate the total sales per customer

SELECT 
    c.customerid,
    c.customername,
    SUM(s.quantitysold) AS total_sales
FROM customers c
 JOIN sales s
    ON c.customerid = s.customerid
GROUP BY c.customerid, c.customername;



---

select * from Products
select * from sales

22. List all products that have been sold at least once  

select p.* from products p
join sales s
on p.productname = s.product

23. Find the most expensive product in the Products table  

select top 1 * from products
order by sellingprice desc

24. Find all products where the selling price is higher than the average selling price in their category

select * from products
where sellingprice > (select avg(sellingprice) from products)
