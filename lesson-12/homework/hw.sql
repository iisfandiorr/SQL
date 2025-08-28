

1. select p.firstname, p.lastname, isnull(a.city, 'no city') as city, isnull(a.state, 'no state') as state
from person p left join address a
on p.personid = a.personid

2. SELECT e.name AS Employee
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
WHERE e.salary > m.salary;

3. SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

4. DELETE p
FROM Person p
JOIN (
    SELECT email, MIN(id) AS min_id
    FROM Person
    GROUP BY email
) t
ON p.email = t.email
WHERE p.id > t.min_id;

5. select distinct g.parentname from girls g
left join boys b 
on b.parentname = g.parentname
where b.parentname is null
  
6. SELECT 
    custid, 
    CAST(SUM(
        CASE 
            WHEN freight < 50 THEN 0 
            ELSE unitprice * qty * (1 - discount) 
        END
    ) AS DECIMAL(10,2)) AS totalSales,
    MIN(freight) AS min_weight
FROM [Sales].[Orders] s 
JOIN [Sales].[OrderDetails] o  
    ON s.orderid = o.orderid 
GROUP BY custid; 

7. SELECT c.item AS ItemCart1, b.item AS ItemCart2
FROM cart1 c
FULL OUTER JOIN cart2 b
ON c.item = b.item
ORDER BY COALESCE(c.item, b.item);

8. select c.name, o.id from customers c
left join orders o
on c.id = o.customerid
where o.id is null

9. SELECT 
    s.student_id,
    s.student_name,
    c.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM students s
CROSS JOIN subjects c
LEFT JOIN examinations e
    ON s.student_id = e.student_id
   AND c.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, c.subject_name
ORDER BY s.student_id, c.subject_name;



