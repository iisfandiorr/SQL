PUZZLE 1 

SELECT MIN(col1) AS col1, MAX(col2) AS col2
FROM InputTbl
GROUP BY LEAST(col1, col2), GREATEST(col1, col2);
  
PUZZLE 2

	select * from TestMultipleZero
	where A <> 0 or B <> 0 or C <> 0 or D <> 0 
  
PUZZLE 3

  select * from section1
	   where id % 2 = 1
  
PUZZLE 4

   select * from section1
	   where id = (select min(id) from section1)
  
PUZZLE 5

  select * from section1
	   where id = (select max(id) from section1)
  
PUZZLE 6

   select * from section1
	   where name like 'b%'
  
PUZZLE 7 

select * from ProductCodes
where code like '%[_]%'

