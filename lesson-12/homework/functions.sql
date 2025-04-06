--1. What is the result of Ascii('A') in SQL?
--65
--2. Write a SQL query to get the length of the string 'Hello World' using Len().
select len('Hello World')
--3. How do you reverse a string 'OpenAI' using SQL?
--By using the REVERSE() function
select REVERSE('OpenAI')
--4. What function would you use to add 5 spaces before a string in SQL?
select concat('     ', 'string')
--5. How can you remove leading spaces from the string ' SQL Server'?
--by using ltrim()
select ltrim(' SQL Server')
--6. Write a query that converts the string 'sql' to uppercase.
select upper('sql')
--7. What function would you use to extract the first 3 characters of the string 'Database'?
--I'd ue the function left()
select left('Database', 3)
--8. How can you get the last 4 characters from the string 'Technology'?
--By using right() function
select right('Technology', 4)
--9. Use Substring() to get characters from position 3 to position 6 in the string 'Programming'.
select substring('Programming', 3, 6)
--10. Write a query to concatenate the strings 'SQL' and 'Server' using Concat().
select concat('SQL', 'Server')
--11. How can you replace all occurrences of 'apple' with c in the string 'apple pie'?
--by using replace() function
select replace('apple pie', 'apple', 'orange')
--12. Write a query to find the position of the first occurrence of the word 'learn' in the string 'Learn SQL with LearnSQL'.
select charindex('learn', 'Learn SQL with LearnSQL')
--13. What function can you use to check if the string 'Server' contains 'er' using SQL?
--charindex()
select charindex('er', 'Server')
--14. How can you split the string 'apple,orange,banana' into individual words using String_split()?
select value from string_split('apple,orange,banana', ',')
--15. What is the result of the expression Power(2, 3)?
--8
--16. Write a query that calculates the square root of 16 using SQL.
select sqrt(16)
--17. How do you get the current date and time in SQL?
--With the help of GETDATE()
select getdate()
--18. What SQL function would you use to get the current UTC date and time?
--by using getutcdate()
select getutcdate()
--19. How can you get the day of the month from the date '2025-02-03'?
select datepart(day, '2025-02-03')
--20. Write a query to add 10 days to the date '2025-02-03' using Dateadd().
select dateadd(day, 10, '2025-02-03')
--1. Use Char() to convert the ASCII value 65 to a character. 
select char(65)
--2. What is the difference between Ltrim() and Rtrim() in SQL? 
--Ltrim() removes all the spaces from the left side of the string, 
--while Rtrim() does the same thing, but from the right side of the string
--3. Write a query to find the position of the substring 'SQL' in the string 'Learn SQL basics'. 
select charindex('SQL', 'Learn SQL basics')
--4. Use Concat_ws() to join 'SQL' and 'Server' with a comma between them. 
select CONCAT_WS(',', 'SQL', 'Server')
--5. How would you replace the substring 'test' with 'exam' using Stuff()?
select stuff('exam',1 , 4, 'test')
--6. Write a SQL query to get the square of 7 using Square().
select square(7)
--7. How do you get the first 5 characters from the string 'International'? 
select left('International', 5)
--8. Write a query to get the last 2 characters of the string 'Database'. 
select right('Database', 2)
--9. What is the result of Patindex('%n%', 'Learn SQL')? 
--5
--10. How do you calculate the difference in days between '2025-01-01' and '2025-02-03' using Datediff()? 
select DATEDIFF(day, '2025-01-01', '2025-02-03')
--11. Write a query to return the month from the date '2025-02-03' using Month().
select month('2025-02-03')
--12. Use DatePart() to extract the year from the date '2025-02-03'.
select DATEPART(year, '2025-02-03')
--13. How can you get the current system time without the date part in SQL?
select sysdatetime()
--14. What does the function Sysdatetime() return in SQL? 
--It returns current system time
--15. How would you find the next occurrence of 'Wednesday' from today's date using Dateadd()? 
SELECT DATEADD(DAY, (4 - DATEPART(WEEKDAY, GETDATE()) + 7) % 7, GETDATE()) AS NextWednesday;
--16. What is the difference between Getdate() and Getutcdate()? 
--getdate() returns the date and time of the country from where the function was executed, while getutcdat() returns coordinated universal time
--17. Use Abs() to get the absolute value of -15 in SQL.
select abs(-15)
--18. How would you round the number 4.57 to the nearest whole number using Ceiling()?
select ceiling(4.57)
--19. Write a SQL query to get the current time using Current_Timestamp.
select CURRENT_TIMESTAMP
--20. Use DateName() to return the day name for the date '2025-02-03'.
select DATENAME(WEEKDAY,'2025-02-03')
--1. Write a query to reverse the string 'SQL Server' and then remove the spaces.
select trim(reverse('SQL Server'))
--2. Write a query that uses String_agg() to concatenate all the values in the 'City' column of a table into a single string, separated by commas. 
select STRING_AGG(City, ',') from Customers
--3. Write a SQL query that checks if a string contains both 'SQL' and 'Server' using Charindex().
select charindex('SQL', 'Welcome to SQL Server')*charindex('Server', 'Welcome to SQL Server')
-- if both are present returns a non_zero number, otherwise it returns 0
--4. How would you use Power() to calculate the cube of 5?
select power(5,3)
--5. Write a query that splits a string 'apple;orange;banana' by the semicolon and returns each word as a separate row. 
select value from string_split('apple;orange;banana', ';')
--6. Use Trim() to remove both leading and trailing spaces from the string 'SQL'.
select trim('SQL')
--7. Write a SQL query to calculate the difference in hours between two timestamps using Datediff(). 
select Datediff(hour, '2020-01-01 12:32:42','2025-01-01 11:43:50')
--8. How would you calculate the number of months between '2023-05-01' and '2025-02-03' using datediff()? 
select datediff(month, '2023-05-01', '2025-02-03')
--9. Write a query to find the position of the substring 'SQL' from the end of the string 'Learn SQL Server' using Reverse() and Charindex(). 
select CHARINDEX(reverse('SQL'), reverse('Learn SQL Server'))
--10. Use String_split() to split a comma-separated string 'apple, orange, banana' and return each word in a separate row. 
select value from string_split('apple, orange, banana', ',')
--11. How would you find the number of days from '2025-01-01' to the current date using Datediff()?
select datediff(day, '2025-01-01', getdate())
--12. Write a SQL query that returns the first 4 characters of the string 'Data Science' using Left().
select left('Data Science', 4)
--13. How can you calculate the square root of 225 and round it to the nearest whole number using Sqrt() and Ceiling()? 
select ceiling(sqrt(225))
--14. Write a query that concatenates two strings with a pipe ('|') separator using Concat_ws(). 
select CONCAT_WS('|', 'To be', 'not to be')
--15. Use Patindex() to find the position of the first occurrence of any digit in the string 'abc123xyz'. 
select PATINDEX('%[0-9]%', 'abc123xyz')
--16. How would you find the second occurrence of the substring 'SQL' in the string 'SQL Server SQL' using Charindex()? 
select CHARINDEX(' SQL', 'SQL Server SQL') + 1
--17. Write a SQL query to get the year from the current date using DatePart().
select DATEPART(year, getdate())
--18. How do you subtract 100 days from the current date using Dateadd()?
select DATEADD(day, -100, GETDATE())
--19. Use DateName() to extract the day of the week from the date '2025-02-03'. 
select DATENAME(WEEKDAY, '2025-02-03')
--20. Write a query to get the square of a number using the Power() function and return it in the result set.
select power(9, 2)
