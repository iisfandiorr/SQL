1. Find Employees with Minimum Salary
Task: Retrieve employees who earn the minimum salary in the company. 
Tables: employees (columns: id, name, salary)

select * from employees
where salary = (select min(salary) from employees)

2. Find Products Above Average Price
Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

select * from products
where price > (select avg(price) from products)

3. Find Employees in Sales Department 
Task: Retrieve employees who work in the "Sales" department. 
Tables: employees (columns: id, name, department_id), 
departments (columns: id, department_name)

select * from employees e
where exists (
select 1 from departments d
where d.id = e.department_id and d.department_name = 'sales')

4. Find Customers with No Orders
Task: Retrieve customers who have not placed any orders. 
Tables: customers (columns: customer_id, name), 
orders (columns: order_id, customer_id)

select c.customer_id, c.name
from customers c
where exists (
select 1 from orders o
where o.customer_id = c.customer_id)

5. Find Products with Max Price in Each Category
Task: Retrieve products with the highest price in each category. 
Tables: products (columns: id, product_name, price, category_id)

SELECT * FROM products p
WHERE price = 
(SELECT MAX(price) FROM products WHERE category_id = p.category_id
);

6. Find Employees in Department with Highest Average Salary
Task: Retrieve employees working in the department with the highest average salary.
Tables: employees (columns: id, name, salary, department_id), 
departments (columns: id, department_name)

SELECT * FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

7. Find Employees Earning Above Department Average
Task: Retrieve employees earning more than the average salary in their department. 
Tables: employees (columns: id, name, salary, department_id)

SELECT * FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

Task: Retrieve students who received the highest grade in each course.
Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

SELECT s.student_id, s.name, g.course_id, g.grade
FROM students s
JOIN grades g 
    ON s.student_id = g.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);

9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
Tables: products (columns: id, product_name, price, category_id)

SELECT *
FROM products p
WHERE price = (
    SELECT DISTINCT price
    FROM products
    WHERE category_id = p.category_id
    ORDER BY price DESC
    OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY
);

10. Find Employees whose Salary Between Company Average and Department Max Salary
Task: Retrieve employees with salaries above the company average but below the maximum in their department. 
Tables: employees (columns: id, name, salary, department_id)

select * from employees t
where t.salary > (select avg(d.salary) from employees d)
and
t.salary < (select max(e.salary) from employees e where e.department_id = t.department_id)


