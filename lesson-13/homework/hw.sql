Lesson 13 ----Practice: String Functions, Mathematical Functions

Easy Tasks
1. You need to write a query that outputs "100-Steven King", 
meaning emp_id + first_name + last_name in that format using employees table.

select concat(employee_id,'-', first_name,' ', last_name) as result from employees

2. Update the portion of the phone_number in the employees table, 
within the phone number the substring '124' will be replaced by '999'

select replace(phone_number, '124', '999') as result from employees  -- this code for display only

update employees
set phone_number = replace(phone_number, '124', '999'); -- it is for change in the table

3. That displays the first name 
and the length of the first name for all employees 
whose name starts with the letters 'A', 'J' or 'M'. 
Give each column an appropriate label. 
Sort the results by the employees first names.(Employees)

select first_name, len(first_name) as namelength
from employees where first_name like 'a%' or first_name like 'j%' or first_name like 'm%'

4. Write an SQL query to find the total salary for each manager ID.(Employees table)

select p.manager_id, p.first_name, sum(e.salary) as totalsalary
from employees e join employees p
on e.manager_id = p.manager_id
group by p.manager_id, p.first_name

5. Write a query to retrieve the year and 
the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table

SELECT year1,
       CASE 
            WHEN max1 >= max2 AND max1 >= max3 THEN max1
            WHEN max2 >= max1 AND max2 >= max3 THEN max2
            ELSE max3
       END AS highest_value
FROM testmax;

6. Find me odd numbered movies and description is not boring.(cinema)

select * from cinema
where id % 2 = 1 and description <> 'boring'

7. You have to sort data based on the Id but Id with 0 should always be the last row. 
Now the question is can you do that with a single order by column.(SingleOrder)

SELECT * FROM singleorder
ORDER BY CASE WHEN id = 0 THEN 1 ELSE 0 END, id;

8. Write an SQL query to select the first non-null value from a set of columns. 
If the first column is null, move to the next, and so on. If all columns are null, 
return null.(person)

SELECT id,
       COALESCE(ssn, passportid, itin) AS first_non_null
FROM person;

Medium Tasks

9. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)

SELECT 
    LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS Firstname,
    SUBSTRING(FullName,
              CHARINDEX(' ', FullName) + 1,
              CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1) AS Middlename,
    RIGHT(FullName, LEN(FullName) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1)) AS Lastname
FROM Students;


10. For every customer that had a delivery to California, 
provide a result set of the customer orders that were delivered to Texas. (Orders Table)

select o.customerid
from orders o 
where o.deliverystate = 'tx'
and o.customerid in (select customerid from orders where deliverystate = 'ca')

11. Write an SQL statement that can group concatenate the following values.(DMLTable)

select string_agg(string, ' ') as groupconcatenate from dmltable 

--result: SELECT Product, UnitPrice, EffectiveDate FROM Products WHERE UnitPrice > 100

12. Find all employees whose names (concatenated first and last) 
contain the letter "a" at least 3 times.

select * from employees
SELECT employee_id,first_name + ' ' + last_name as fullname
FROM employees
WHERE LEN(CONCAT(first_name, last_name)) - LEN(REPLACE(CONCAT(first_name, last_name), 'a', '')) >= 3;

13. The total number of employees in each department and 
the percentage of those employees 
who have been with the company for more than 3 years(Employees)

select count(employee_id) as numberofemp, department_id, 
100.0 * sum(case when datediff(year, hire_date, getdate()) > 3 then 1 else 0 end) / count(employee_id) as percenatge
from employees
group by department_id

14. Write an SQL statement that determines the most and 
least experienced Spaceman ID by their job description.(Personal)

SELECT p.jobdescription,
       p.spacemanid,
       p.missioncount,
       CASE 
            WHEN p.missioncount = x.max_missions THEN 'Most Experienced'
            WHEN p.missioncount = x.min_missions THEN 'Least Experienced'
       END AS experience_level
FROM personal p
JOIN (
    SELECT jobdescription,
           MAX(missioncount) AS max_missions,
           MIN(missioncount) AS min_missions
    FROM personal
    GROUP BY jobdescription
) x
  ON p.jobdescription = x.jobdescription
 AND (p.missioncount = x.max_missions OR p.missioncount = x.min_missions);


Difficult Tasks

15. Write an SQL query that separates the uppercase letters, 
lowercase letters, numbers, and other characters 
from the given string 'tf56sd#%OqH' into separate columns.

DECLARE @s VARCHAR(50) = 'tf56sd#%OqH';

SELECT 
    @s AS original_string,
    UPPER(REPLACE(REPLACE(REPLACE(REPLACE(@s, 't',''), 'f',''), 's',''), 'd','')) AS uppercase_letters,
    LOWER(REPLACE(REPLACE(REPLACE(REPLACE(@s, 'O',''), 'H',''), '5',''), '6','')) AS lowercase_letters,
    REPLACE(REPLACE(@s, 't',''), 'f','') AS numbers -- (примерно, но для полной задачи лучше писать через STRING_AGG + WHERE)


16. Write an SQL query that replaces each row with the sum of its value and 
the previous rows value. (Students table)

SELECT studentid,
       grade + ISNULL(LAG(grade) OVER (ORDER BY studentid), 0) AS new_value
FROM Students;

17. You are given the following table, which contains a VARCHAR column 
that contains mathematical equations. Sum the equations and 
provide the answers in the output.(Equations)

DECLARE @eq VARCHAR(100) = '5+7-2';
EXEC('SELECT ' + @eq);

18. Given the following dataset, 
find the students that share the same birthday.(Student Table)

select * from students
SELECT s1.student_id, s1.name, s1.birthdate
FROM Student s1
JOIN (
    SELECT birthdate
    FROM Student
    GROUP BY birthdate
    HAVING COUNT(*) > 1
) s2 ON s1.birthdate = s2.birthdate
ORDER BY s1.birthdate;


19. You have a table with two players (Player A and Player B) and 
their scores. If a pair of players have multiple entries, 
aggregate their scores into a single row for each unique pair of players. 
Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

SELECT 
    CASE WHEN playerA < playerB THEN playerA ELSE playerB END AS player1,
    CASE WHEN playerA < playerB THEN playerB ELSE playerA END AS player2,
    SUM(score) AS total_score
FROM PlayerScores
GROUP BY 
    CASE WHEN playerA < playerB THEN playerA ELSE playerB END,
    CASE WHEN playerA < playerB THEN playerB ELSE playerA END;
