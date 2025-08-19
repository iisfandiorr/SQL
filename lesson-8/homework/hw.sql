													-- HW 8 --

										-- Easy-Level Tasks --
1. Using Products table, find the total number of products available in each category.

select category, sum(stockquantity) from products
group by category

2. Using Products table, get the average price of products in the 'Electronics' category.

select category, avg(Price) from Products 
group by category
having category = 'electronics'

3. Using Customers table, list all customers from cities that start with 'L'.

select * from customers where city like 'l%'

4. Using Products table, get all product names that end with 'er'.

select * from products where productname like '%er'

5. Using Customers table, list all customers from countries ending in 'A'.

select * from customers where country like '%a'

6. Using Products table, show the highest price among all products.

select top 1 * from products
order by price desc

7. Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.

select *,
case
when stockquantity < 30 then 'low stock'
else 'sufficient'
end as stocklevel from products

8. Using Customers table, find the total number of customers in each country.

select country, count(Customerid) as numberincountry from  Customers
group by country
order by numberincountry desc 

9. Using Orders table, find the minimum and maximum quantity ordered.

select min(Quantity) as minimum, max(quantity) as maximum from orders

												-- Medium-Level Tasks --
10. Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January 
to find those who did not have invoices.


select orders.orderdate, Invoices.invoiceid
from orders left join invoices
on orders.customerid = invoices.customerid
where year(orderdate) = 2023 and month(orderdate) = 01 and invoices.invoiceid is null

11. Using Products and Products_Discounted table, 
Combine all product names from Products and Products_Discounted including duplicates.

select ProductName from products 
union all
select productname from Products_Discounted

12. Using Products and Products_Discounted table, 
Combine all product names from Products and Products_Discounted without duplicates.

select ProductName from products 
union 
select productname from Products_Discounted

13. Using Orders table, find the average order amount by year.

select year(orderdate), avg(totalamount) from orders
group by year(orderdate)
order by avg(totalamount) desc

14. Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). 
Return productname and pricegroup.


select productname, price,
case 
when price < 100 then 'low'
when price between 100 and 500 then 'mid'
else 'high'
end as price_level 
from products
order by price asc

15. Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) 
and copy results to a new Population_Each_Year table.

select district_id, district_name, [2012], [2013] into Population_Each_Year from city_population
pivot
(
sum(population) for year in ([2012],[2013])
) as pivot_table

select * from Population_Each_Year

16. Using Sales table, find total sales per product Id.

select productid, sum(saleamount) as totalsales from sales
group by productid

17. Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.

select * from Products
where productname like '%oo%'

18. Using City_Population table,
use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) 
and copy results to a new Population_Each_City table.

select district_id, year, [Chilonzor], [Yakkasaroy], [Mirobod], [Yashnaobod], [Bektemir] into Population_Each_City from city_population
pivot (
sum(population) for district_name in ([Chilonzor], [Yakkasaroy], [Mirobod], [Yashnaobod], [Bektemir])
) as pivotedtable

select * from Population_Each_City


												-- Hard-Level Tasks --
19. Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.

select * from invoices

select top 3 customerid, sum(totalamount) as highesttotal from invoices
group by customerid
order by sum(totalamount) desc

20. Transform Population_Each_Year table to its original format (City_Population).

select * from Population_Each_Year
select district_id, district_name, newsalesyear, newpopulation from Population_Each_Year
unpivot
(
newsalesyear for newpopulation in ([2012], [2013])
) as unpivotedtable

21. Using Products and Sales tables, 
list product names and the number of times each has been sold. (Research for Joins)

select products.productname, count(sales.productid) as totalsold
from products join sales
on Products.productid = sales.ProductID
group by products.productname


22. Transform Population_Each_City table to its original format (City_Population).

select * from Population_Each_city
select district_id, year, newdistrict, newpopulation from Population_Each_city
unpivot
(
newdistrict for newpopulation in ([Chilonzor], [Yakkasaroy], [Mirobod], [Yashnaobod], [Bektemir])
) as unpivotedtable
