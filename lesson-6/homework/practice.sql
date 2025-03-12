--Puzzle 1
--Solution1
select * from Testmultiplezero order by a desc, b desc, c desc, d desc offset 0 rows fetch next 5 rows only
--Solution2
select * from Testmultiplezero where a+b+c+d <> 0
--Solution3
select * from Testmultiplezero
where not (A=0 and B=0 and C=0 and D=0)
--Solution4
select * from Testmultiplezero
where A <> 0 or B <> 0 or C <> 0 or D <> 0

-- Puzzle 2

select name, 
		sum(case fruit
	when 'APPLE' then 1 else null end) as APPLE,
		sum(case fruit
	when 'Mango' then 1 else null end) as Mango,
		sum(case fruit					 
	when 'Lichi' then 1 else null end) as Lichi,
		sum(case fruit
	when 'Orange' then 1 else null end) as Orange
from fruitcount
group by name

-- Puzzle 3

select
	case 
		when number % 15 = 0 then 'FizzBuzz'
		when number % 3 = 0 then 'Fizz'
		when number % 5 = 0 then 'Buzz'
		else cast(number as varchar)
	end
from numbers


select distinct EmpName, count(empname) as occurence from TESTDuplicateColumn where (select count(empname) from TESTDuplicateColumn group by emplname) > 1 group by empname

--Puzzle 4: Finding Distinct Values
--Question: Explain at least two ways to find distinct values based on two columns.

select * from InputTbl
select distinct col1 from InputTbl where col1 <> (select distinct col2 from InputTbl)

--Puzzle 5: Counting 'a' for Different Types
--Question: Count occurrences of 'a' in columns Value1, Value2, and Value3 for different Typs.

SELECT DISTINCT LEAST(col1, col2), GREATEST(col1, col2) FROM InputTbl

--Method1
select typ, sum(iif(value1 = 'a', 1, 0)) + sum(iif(value2 = 'a', 1, 0)) + sum(iif(value3 = 'a', 1, 0)) from GroupbyMultipleColumns group by typ
--Method2
select typ, 
	sum(case
	when value1 = 'a' then 1 else 0
	end) + 
	sum(case
	when value2 = 'a' then 1 else 0 
	end) +
	sum(case
	when value3 = 'a' then 1 else 0
	end) as Total
from GroupbyMultipleColumns
group by typ
--DONE

--Puzzle 6: Finding Duplicate Values
--Question: Find values that appear more than once in the table.

select EmpName, count(empname) as occurence 
from TESTDuplicateCount group by empname having count(empname) > 1
--DONE
