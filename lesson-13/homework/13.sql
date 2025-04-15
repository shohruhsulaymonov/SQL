--1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
select Concat(Employee_id, '-',first_name, last_name) Name, phone_number, hire_date, Job_id, salary, commission_pct, manager_id, department_id from employees
--2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
select Concat(Employee_id, '-',first_name, last_name) Name, replace(phone_number, '124', '999') phone_number, hire_date, Job_id, salary, commission_pct, manager_id, department_id from employees
--3.That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
select first_name, len(first_name) Length from Employees where FIRST_NAME like '[AJM]%' order by FIRST_NAME
--4.Write an SQL query to find the total salary for each manager ID.(Employees table)
select MANAGER_ID, sum(salary) Total_Salary from Employees group by MANAGER_ID
--5.Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
select year1, GREATEST(max1, max2, max3) MaxValue from TestMax
--6.Find me odd numbered movies description is not boring.(cinema)
select * from cinema where id % 2 <> 0 and description <> 'boring'
--7.You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
select * from SingleOrder order by case when id = 0 then 1 else 0 end, id
--8.Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
select id, coalesce(ssn, passportid, itin, null) [Column] from person
--9.Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)
select Employee_ID, First_Name, Last_Name, Hire_Date, datediff(year, hire_date, getdate()) as Years from Employees where HIRE_DATE < dateadd(year, -10, getdate()) and HIRE_DATE > dateadd(year, -15, getdate())
--10.Find the employees who have a salary greater than the average salary of their respective department.(Employees)
select 
	FIRST_NAME, 
	LAST_NAME, 
	e1.SALARY, 
	e2.salary 
from Employees e1 
join (
	select 
		Department_id, 
		avg(salary) salary 
	from Employees 
	group by DEPARTMENT_ID) e2 
on e1.DEPARTMENT_ID = e2.department_id 
where e1.SALARY > e2.salary

--Medium Tasks 
--1.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.

		WITH SplitChars AS (
    SELECT 
        1 AS pos,
        SUBSTRING('tf56sd#%OqH', 1, 1) AS ch,
        LEN('tf56sd#%OqH') AS total_len
    UNION ALL
    SELECT 
        pos + 1,
        SUBSTRING('tf56sd#%OqH', pos + 1, 1),
        total_len
    FROM SplitChars
    WHERE pos < total_len
),
Classified AS (
    SELECT
        ch,
        CASE 
            WHEN ASCII(ch) BETWEEN 65 AND 90 THEN 'uppercase'
            WHEN ASCII(ch) BETWEEN 97 AND 122 THEN 'lowercase'
            WHEN ASCII(ch) BETWEEN 48 AND 57 THEN 'number'
            ELSE 'other'
        END AS char_type
    FROM SplitChars
)
SELECT
    STRING_AGG(CASE WHEN char_type = 'uppercase' THEN ch END, '') AS uppercase_letters,
    STRING_AGG(CASE WHEN char_type = 'lowercase' THEN ch END, '') AS lowercase_letters,
    STRING_AGG(CASE WHEN char_type = 'number' THEN ch END, '') AS numbers,
    STRING_AGG(CASE WHEN char_type = 'other' THEN ch END, '') AS other_characters
FROM Classified;




--2. split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select 
	left(
			fullname, 
			CHARINDEX(' ', fullname)-1
	) as FirstName, 
			
	SUBSTRING(
			fullname, CHARINDEX(' ', fullname)+1, 
					  charindex(' ', fullname, CHARINDEX(' ', fullname)+1)-CHARINDEX(' ', fullname)
	) as MiddleName, 
	
	right(fullname, 
		  len(fullname)-(CHARINDEX(' ', fullname, CHARINDEX(' ', fullname)+1))
	) as LastName 
from 
	Students

--3.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)


select * from Orders
where CustomerID in (
select CustomerID from Orders
where DeliveryState = 'CA') and DeliveryState = 'TX'


--4.Write an SQL query to transform a table where each product has a total quantity into a new table where each row represents a single unit of that product.For example, if A and B, it should be A,B and B,A.(Ungroup)
with cteRec as (
select 1 as pos, ProductDescription , Quantity  from Ungroup
union all
select pos + 1  ,ProductDescription, quantity from cteRec
where quantity > pos
)
select * from cteRec

select ManagerID,  STRING_AGG(JobTitle, ' - ') from Employee
group by ManagerID

--5.Write an SQL statement that can group concatenate the following values.(DMLTable)
select * from DMLTable
select STRING_AGG(string, ' ') from DMLTable
--6.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
select 
	*, 
	case
		when datediff(year, HIRE_DATE, GETDATE()) < 1 then 'New Hire'
		when datediff(year, HIRE_DATE, GETDATE()) < 5 then 'Junior'
		when datediff(year, HIRE_DATE, GETDATE()) < 10 then 'Mid-Level'
		when datediff(year, HIRE_DATE, GETDATE()) < 20 then 'Senior'
		else 'Veteran'
	end
from Employees

--7.Find the employees who have a salary greater than the average salary of their respective department(Employees)
select 
	FIRST_NAME, 
	LAST_NAME, 
	e1.SALARY, 
	e2.salary 
from Employees e1 
join (
	select 
		Department_id, 
		avg(salary) salary 
	from Employees 
	group by DEPARTMENT_ID) e2 
on e1.DEPARTMENT_ID = e2.department_id 
where e1.SALARY > e2.salary
select concat(FIRST_NAME, ' ', LAST_NAME) Name, SALARY from Employees where concat(FIRST_NAME, ' ', LAST_NAME) like '%a%'
--9.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
select e1.department_id, count(*) [Count Of Employees], (count(*)/e2.cnt)*100 [Percentage of year>3] from Employees e1 full join (select department_id, count(*) cnt from employees where datediff(year, HIRE_DATE, GETDATE()) > 3 group by DEPARTMENT_ID) e2 on e1.DEPARTMENT_ID = e2.DEPARTMENT_ID group by e1.DEPARTMENT_ID, cnt
--10.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)

select p.JobDescription, p1.SpacemanID as MaximumExperienced, p2.SpacemanID as LeastExperienced from (select JobDescription, max(missioncount) MaxExp, min(MissionCount) MinExp from Personal p88 group by p88.JobDescription) p
join Personal p1 on p.MaxExp = p1.MissionCount
join Personal p2  on p.MinExp = p2.MissionCount 


----Difficult Tasks 
--1.Write an SQL query that replaces each row with the sum of its value and the previous row's value. (Students table)
select StudentID, (select sum(grade) from Students i where i.StudentID <= o.StudentID ) RunningGrade from Students o
--2.Given the following hierarchical table, write an SQL statement that determines the level of depth each employee has from the president. (Employee table)
go
with cte as(
	select 
		EmployeeID, 
		ManagerID,
		JobTitle, 
		1 as depth
	from Employee 
	where EmployeeID = 5005
	union all
	select 
		cte.EmployeeID, 
		e.ManagerID,
		e.JobTitle, 
		depth+1 
	from Employee e 
	join cte 
	on cte.ManagerID = e.EmployeeID
)
select * from cte
--3.You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
select * from Equations
--4.Given the following dataset, find the students that share the same birthday.(Student Table)
select * from Student
where Birthday in (

Select Birthday from Student group by Birthday having count(*) > 1)

select Birthday, string_agg(StudentName, ', ') Students from Student group by Birthday
--5.You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;


select * from PlayerScores
