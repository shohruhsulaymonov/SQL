---Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output.

select *,
	format(Dt, 'MM') as MonthPrefixedWithZero  
from Dates

--Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals columns for each Id and RId. For more details please see the sample input and expected output.
with CTEUnique as(
select distinct
	id,
	rid,
	max(Vals) over (partition by id) Max
from MyTabel
)
select 
	count(id) Distinct_Ids ,
	max(rid) Rid,
	sum(max) TotalOfMaxVals 
from CTEUnique

--Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. Please see the sample input and expected output.

select *
from TestFixLengths
where len(Vals) between 6 and 10

--Puzzle 4: In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. The Challenge is to do that in a SINGLE SELECT. Please check out sample input and expected output.



--Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the sample input and the expected output.

CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

select
	*,
	case when cast(a - b as varchar) = 0 then '' 
	else cast(a - b as varchar)
	end as OUTPUT
from TheZeroPuzzle
