# 1. Find customers who purchased at least one item in March 2024 using EXISTS

select distinct c.customername
from #sales c
where exists (
select 1 from #sales s
where c.customername = s.customername
and year(saledate) = 2024 and month(saledate) = 03)

# 2. Find the product with the highest total sales revenue using a subquery.

select product from #sales
where price * quantity = (select top 1 price * quantity from #sales)

# 3. Find the second highest sale amount using a subquery

select top 1 product from #sales
where price * quantity < (select top 1 price * quantity from #sales)

# 4. Find the total quantity of products sold per month using a subquery

SELECT DISTINCT DATENAME(month, s.saledate) AS MonthName,
       (SELECT SUM(quantity)
        FROM #sales t
        WHERE DATENAME(month, t.saledate) = DATENAME(month, s.saledate)
          AND YEAR(t.saledate) = YEAR(s.saledate)) AS TotalQuantity
FROM #sales s;


# 5. Find customers who bought same products as another customer using EXISTS

select distinct c.customername
from #sales c
where exists(
select 1 from #sales s
where c.product = s.product
and c.customername <> s.customername
)

# 6. Return how many fruits does each person have in individual fruit level

select * from Fruits

EO
+-----------+-------+--------+--------+
| Name      | Apple | Orange | Banana |
+-----------+-------+--------+--------+
| Francesko |   3   |   2    |   1    |
| Li        |   2   |   1    |   1    |
| Mario     |   3   |   1    |   2    |
+-----------+-------+--------+--------+

SELECT name, [Apple], [Orange], [Banana]
FROM (
    SELECT name, fruit
    FROM fruits
) AS src
PIVOT (
    COUNT(fruit)       
    FOR fruit IN ([Apple], [Orange], [Banana])
) AS pvt;


# 7. Return older people in the family with younger ones

WITH FamilyHierarchy AS (
    SELECT parentid AS pid, childid AS chid
    FROM family
    UNION ALL
    SELECT f.parentid, fh.chid
    FROM family f
    JOIN FamilyHierarchy fh
      ON f.childid = fh.pid
)
SELECT DISTINCT pid, chid
FROM FamilyHierarchy
ORDER BY pid, chid;

# 8. Write an SQL statement given the following requirements. 
For every customer that had a delivery to California, 
provide a result set of the customer orders that were delivered to Texas

SELECT o.customerid, o.deliverystate
FROM #orders o
WHERE o.deliverystate = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #orders od
      WHERE od.customerid = o.customerid
        AND od.deliverystate = 'CA'
  );

# 9. Insert the names of residents if they are missing

SELECT *
FROM #residents
WHERE fullname IS NULL
  AND CHARINDEX('name', address) > 0;

# 10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes

;WITH Paths AS (
    SELECT departurecity, arrivalcity, cost,
           CAST(departurecity + ' - ' + arrivalcity AS VARCHAR(MAX)) AS route
    FROM #routes
    WHERE departurecity = 'Tashkent'

    UNION ALL

    SELECT p.departurecity, r.arrivalcity, p.cost + r.cost,
           p.route + ' - ' + r.arrivalcity
    FROM Paths p
    JOIN #routes r ON p.arrivalcity = r.departurecity
    WHERE CHARINDEX(r.arrivalcity, p.route) = 0
),
Ranked AS (
    SELECT route,
           cost,
           RANK() OVER (ORDER BY cost ASC) AS rnk
    FROM Paths
    WHERE arrivalcity = 'Khorezm'
)
SELECT route, cost, rnk
FROM Ranked
WHERE rnk IN (1, 4)
ORDER BY rnk;

# 11. Rank products based on their order of insertion.

select *,
		dense_rank() over(order by id) as rnk
from #RankingPuzzle

# 12. Find employees whose sales were higher than the average sales in their department

select * from #EmployeeSales 

select employeename, salesamount
from #EmployeeSales
where salesamount > (select avg(salesamount) from #EmployeeSales)
order by salesamount desc

# 13. Find employees who had the highest sales in any given month using EXISTS

select * from #EmployeeSales

select * from #EmployeeSales e
where salesmonth = 1 
and exists(
select 1 from #EmployeeSales ee
where e.employeeid = ee.employeeid
)
order by salesamount desc

# 14. Find employees who made sales in every month using NOT EXISTS

SELECT DISTINCT e.employeeid
FROM #EmployeeSales e
WHERE NOT EXISTS (

    SELECT 1
    FROM (SELECT DISTINCT salesmonth FROM #EmployeeSales) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es
        WHERE es.employeeid = e.employeeid
          AND es.salesmonth = m.salesmonth)

);
   
# 15. Retrieve the names of products that are more expensive than the average price of all products.

select * from products
where price > (select avg(price) from products)

# 16. Find the products that have a stock count lower than the highest stock count.

SELECT * FROM products
WHERE stock < (SELECT MAX(stock) FROM products);

# 17. Get the names of products that belong to the same category as 'Laptop'.

select * from products
where category = (SELECT category FROM products WHERE name = 'Laptop')

# 18. Retrieve products whose price is greater than the lowest price in the Electronics category.

select * from products
where price > (select min(price) from products where category = 'electronics')

# 19. Find the products that have a higher price than the average price of their respective category.

SELECT p.*
FROM products p
WHERE p.price > (
    SELECT AVG(price)
    FROM products s
    WHERE s.category = p.category
);

select * from orders

# 20. Find the products that have been ordered at least once.

select * from orders o
where exists(
select 1 from orders d
where d.orderid = o.orderid
)

# 21. Retrieve the names of products that have been ordered more than the average quantity ordered.

WITH ProductTotals AS (
    SELECT productid,
           SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY productid
)
SELECT productid, total_quantity
FROM ProductTotals
WHERE total_quantity > (SELECT AVG(total_quantity) FROM ProductTotals);

# 22. Find the products that have never been ordered.

SELECT p.*
FROM products p
LEFT JOIN orders o
  ON p.productid = o.productid
WHERE o.productid IS NULL;


# 23. Retrieve the product with the highest total quantity ordered.

WITH ProductTotals AS (
    SELECT productid,
           SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY productid
)
SELECT top 1 productid, total_quantity
FROM ProductTotals
order by total_quantity desc
