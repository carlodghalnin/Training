--1. Write a SQL statement to display all the information of all salesmen.
--SELECT * FROM Salesman;

--2. Write a SQL statement to display specific columns like name and
--commission for all the salesmen.
--SELECT name, commission FROM Salesman;

--3.  Write a query to display the columns in a specific order like order date,
--salesman id, order number and purchase amount from for all the orders.
--SELECT ord_date, salesman_id, ord_no, purch_amt FROM Orders;

--4. Write a query which will retrieve the value of salesman id of all salesmen,
--getting orders from the customers in orders table without any repeats.
--SELECT salesman_id;

--5. Write a SQL statement to display all the information for those customers
--with a grade of 200.
--SELECT * FROM Customers WHERE grade = 200;

--6. Write a SQL query to display the order number followed by order date and
--the purchase amount for each order which will be delivered by the
--salesman who is holding the ID 5001.
--SELECT ord_no, ord_date, purch_amt FROM Orders WHERE salesman_id = 5001;

--7. Write a SQL query to display the Nobel prizes for 1970
--SELECT * FROM Nobels WHERE year = 1970;

--8. Write a SQL query to display the year and subject that won 'Dennis Gabor';
--his prize.
--SELECT year, subject FROM Nobels WHERE winner = 'Dennis Gabor';

--9. Write a SQL query to give the name of the 'Physics' winners since the year
--1950.
--SELECT winner FROM Nobels WHERE year >= 1950;

--10. Write a SQL query to Show all the details (year, subject, winner,
--country ) of the Chemistry prize winners between the year 1965 to 1975
--inclusive.
--SELECT * FROM Nobels WHERE subject = 'Chemistry' AND year BETWEEN 1965 AND 1975;

--11. Write a SQL query to show all details of the Prime Ministerial
--winners after 1972 of Menachem Begin and Yitzhak Rabin.
--SELECT * FROM Nobels WHERE year > 1972 AND category = 'Prime Minister'; 

--12. Write a SQL query to show all the details of the winners with first
--name Louis.
--SELECT * FROM Nobels WHERE winner LIKE 'Louis%';

--13. Write a SQL query to show all the winners in Physics for 1970
--together with the winner of Economics for 1971.
--SELECT * FROM Nobels WHERE subject = 'Physics' AND year = 1970 
--UNION
--SELECT * FROM Nobels WHERE subject = 'Economics' AND year = 1971;

--14. Write a SQL query to show all the winners of nobel prize in the year
--1970 except the subject Physiology and Economics.
--SELECT * FROM Nobels WHERE subject NOT IN ('Physiology', 'Economics');

--15. Write a SQL query to show the winners of a 'Physiology' prize in an
--early year before 1971 together with winners of a 'Peace' prize in a later
--year on and after the 1974.
--SELECT * FROM Nobels WHERE subject = 'Physiology' AND year < 1971 
--UNION
--SELECT * FROM Nobels WHERE subject = 'Peace' AND year > 1974;

--16. Write a SQL query to find all the details of the nobel winners for the
--subject not started with the letter 'P' and arranged the list as the most
--recent comes first, then by name in order.
--SELECT * FROM Nobels WHERE subject NOT LIKE 'P%'
--ORDER BY year DESC, winner;

--17. Write a SQL query to find all the details of 1970 winners by the
--ordered to subject and winner name; but the list contain the subject
--Economics and Chemistry at last.
--SELECT * FROM Nobels WHERE year = 1970
--ORDER BY subject DESC, winner;

--18. Write a SQL query to calculate the average price of all products of
--the manufacturer which code is 16.
--SELECT AVG(pro_price) FROM Products WHERE pro_com = 16;

--19. Write a SQL query to find all the products with a price between
--Rs.200 and Rs.600.
--SELECT * FROM Products WHERE pro_price BETWEEN 200 and 600;

--20. Write a SQL query to display the name and price of all the items with
--a price is equal or more than Rs.250, and the list contain the larger price
--first and then by name in ascending order.
--SELECT pro_name, pro_price FROM Products WHERE pro_price >= 250
--ORDER BY pro_price DESC, pro_name;

--21. Write a SQL query to display the average price of the items for each
--company, showing only the company code.
--SELECT AVG(pro_price), pro_com FROM Products GROUP BY pro_com;

--22. Write a SQL query to find the name and price of the cheapest
--item(s).
--SELECT pro_name, pro_price FROM Products ORDER BY pro_price;

--23. Write a query in SQL to find the last name of all employees, without
--duplicates.
--SELECT DISTINCT emp_lname FROM Employees;

--24. Write a query in SQL to find the data of employees whose last name is
--'Snares';
--SELECT * FROM Employees WHERE emp_lname = 'Snares';

--25. Write a query in SQL to display all the data of employees that work in the
--department 57.
SELECT * FROM Employees WHERE emp_dept = 57;
