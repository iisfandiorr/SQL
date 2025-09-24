
## Easy Questions
1 st questioon 
;WITH cte AS (
    SELECT 
        customer_id,
        customer_name,
        order_date,
        total_amount,
        SUM(total_amount) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total
    FROM sales_data
)
SELECT 
    customer_id, 
    customer_name, 
    order_date, 
    running_total
FROM cte
ORDER BY customer_id, order_date;



2.  Count the Number of Orders per Product Category 

SELECT 
    product_category,
    COUNT(*) AS orders_per_category
FROM sales_data
GROUP BY product_category
ORDER BY product_category;

3.  Find the Maximum Total Amount per Product Category 

;with cte as(
select product_category, Product_name, total_amount,
		dense_rank() over(partition by product_category order by total_amount desc) as amount
from sales_data
) select product_category, Product_name, total_amount
from cte where amount = 1

4.  Find the Minimum Price of Products per Product Category 

;with cte as(
select product_category, Product_name, total_amount,
		dense_rank() over(partition by product_category order by total_amount asc) as amount
from sales_data
) select product_category, Product_name, total_amount
from cte where amount = 1

5.  Compute the Moving Average of Sales of 3 days (prev day, curr day, next day) 

select *,
		avg(total_amount) over (order by order_date rows between 1 preceding and 1 following) as avgthreedays
from sales_data


6.  Find the Total Sales per Region 

select region, sum(total_amount) as totalregion
from sales_data
group by region

7.  Compute the Rank of Customers Based on Their Total Purchase Amount 

select *,
		dense_rank() over(order by total_amount desc) as purchasernk
from sales_data

8.  Calculate the Difference Between Current and Previous Sale Amount per Customer 

SELECT customer_id, customer_name, sale_id, total_amount, 
total_amount - COALESCE(LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY sale_id), 0) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, sale_id;

9.  Find the Top 3 Most Expensive Products in Each Category 

;with cte as(
select product_category, Product_name, total_amount,
		dense_rank() over(partition by product_category order by total_amount asc) as amount
from sales_data)
select * from cte
where amount in (1,2,3)

10.  Compute the Cumulative Sum of Sales Per Region by Order Date 

select region, order_date, 
		sum(total_amount) over (partition by region order by order_date) as totals
from sales_data

## Medium Questions

11.  Compute Cumulative Revenue per Product Category 

select product_category, 
		sum(total_amount) over (partition by product_category order by order_date) as totals
from sales_data

12.  Here you need to find out the sum of previous values. Please go through the sample input and expected output. 

select * ,
		sum(id) over(order by id) as sumprevalues
from sample_table

13.  Sum of Previous Values to Current Value 

select * ,
		sum(value) over (order by value rows between 1 preceding and current row) as [sum of previous]
from onecolumn

14.  Find customers who have purchased items from more than one product_category 

;with cte as(
select customer_name, product_category,
		dense_rank() over(partition by customer_name order by product_category) as category
from sales_data
) select customer_name, sum(category) as totalcat
from cte
group by customer_name
having sum(category) > 2

15.  Find Customers with Above-Average Spending in Their Region 

;with cte as(
select *, 
		avg(total_amount) over (partition by region) as avgspending
from sales_data
) select customer_name, total_amount, avgspending
from cte
where total_amount > avgspending
ORDER BY region, total_amount DESC

16.  Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank. 

select *, 
		dense_rank() over (partition by region order by total_amount desc) as rnk
from sales_data

17.  Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date. 

select *, 
		sum(total_amount) over(partition by customer_name order by order_date) as runningtotal
from sales_data

18.  Calculate the sales growth rate (growth_rate) for each month compared to the previous month. 

;WITH monthly_sales AS (
    SELECT 
        YEAR(order_date) AS year_num,
        MONTH(order_date) AS month_num,
        SUM(total_amount) AS month_sum
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    year_num,
    month_num,
    month_sum,
    LAG(month_sum) OVER (ORDER BY year_num, month_num) AS prev_month_sum,
    CASE 
        WHEN LAG(month_sum) OVER (ORDER BY year_num, month_num) = 0 
             OR LAG(month_sum) OVER (ORDER BY year_num, month_num) IS NULL 
        THEN NULL
        ELSE 
            (month_sum - LAG(month_sum) OVER (ORDER BY year_num, month_num)) * 1.0 
            / LAG(month_sum) OVER (ORDER BY year_num, month_num)
    END AS growth_rate
FROM monthly_sales
ORDER BY year_num, month_num;

19.  Identify customers whose total_amount is higher than their last orders total_amount.(Table sales_data) 

;WITH cte AS (
    SELECT 
        customer_id,
        customer_name,
        order_date,
        total_amount,
        LAG(total_amount) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) AS prev_order_amount
    FROM sales_data
)
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    prev_order_amount
FROM cte
WHERE prev_order_amount IS NOT NULL
  AND total_amount > prev_order_amount
ORDER BY customer_id, order_date;

---

## Hard Questions

20.  Identify Products that prices are above the average product price 

select * from sales_data
where unit_price > (select avg(unit_price) from sales_data)

21.  In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output. 

;with cte as(
select *, 
		rank() over (partition by grp order by id ) as rnk
from mydata)
select id, grp, val1, val2,
	case 
	when rnk = 1 then sum(val1) over(partition by grp) + sum(val2) over(partition by grp)
	else null
	end as total
from cte


22.  Here you have to sum up the value of the cost column based on the values of Id. 
For Quantity if values are different then we have to add those values.
Please go through the sample input and expected output for details. 

SELECT 
    Id,
    SUM(Cost) AS Cost,
    SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY Id
ORDER BY Id;

23.  From following set of integers, write an SQL statement to determine the expected outputs 

;WITH cte AS (
    SELECT 
        seatnumber,
        LAG(seatnumber) OVER (ORDER BY seatnumber) AS prev_seat
    FROM seats
),
gaps AS (
    SELECT 
        CASE 
            WHEN prev_seat IS NOT NULL AND seatnumber - prev_seat > 1 
            THEN prev_seat + 1 
        END AS Gap_Start,
        CASE 
            WHEN prev_seat IS NOT NULL AND seatnumber - prev_seat > 1 
            THEN seatnumber - 1 
        END AS Gap_End
    FROM cte
    WHERE prev_seat IS NOT NULL AND seatnumber - prev_seat > 1
),
first_gap AS (
    SELECT 
        1 AS Gap_Start,
        MIN(seatnumber) - 1 AS Gap_End
    FROM seats
    HAVING MIN(seatnumber) > 1
)
SELECT * FROM first_gap
UNION ALL
SELECT * FROM gaps
ORDER BY Gap_Start;
