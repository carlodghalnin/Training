/*1. Write a SQL statement to find those salesmen with all information who
come from the city either Paris or Rome.*/
SELECT * FROM Salesman WHERE city IN ('Paris','Rome');

/*2. Write a query to filter those salesmen with all information who comes from
any of the cities Paris and Rome.*/
SELECT * FROM Salesman WHERE city NOT IN ('Paris','Rome');

/*3. Write a query to produce a list of salesman_id, name, city and commission
of each salesman who live in cities other than Paris and Rome.*/
SELECT * FROM Salesman WHERE city NOT IN ('Paris','Rome');

/*4. Write a query to sort out those customers with all information whose ID
value is within any of 3007, 3008 and 3009.*/
SELECT * FROM Customers WHERE customer_id IN (3007, 3008, 3009);

/*5. Write a SQL statement to find those salesmen with all information who
gets the commission within a range of 0.12 and 0.14. */
SELECT * FROM Salesman WHERE commission BETWEEN 0.12 AND 0.14;

/*6. Write a query to filter all those orders with all information which purchase
amount value is within the range 500 and 4000 except those orders of
purchase amount value 948.50 and 1983.43. */
SELECT * FROM Orders WHERE purch_amt BETWEEN 500 AND 4000
	AND purch_amt NOT BETWEEN 948.50 AND 1983.43;
	
/*7. Write a SQL statement to find those salesmen with all other information
and name started with any letter within 'A' and 'K'.*/
SELECT * FROM Salesman WHERE name BETWEEN 'A%' AND 'K%';

/*8. Write a SQL statement to find that customer with all information whose
name begin with the letter 'B'.*/
SELECT * FROM Customers WHERE cust_name LIKE 'B%';

/*9. Write a SQL statement to find all those customers with all information
whose names are ending with the letter 'n'.*/
SELECT * FROM Customers WHERE cust_name LIKE 'n%';

/*10. Write a SQL statement to find those rows from the table testtable which
does not contain the character ( % ) in its column 'col1'.*/
SELECT * FROM testtable WHERE col1 NOT LIKE '%\%%' ESCAPE '\';

/*11. Write a SQL statement to find the total purchase amount of all orders.*/
SELECT SUM(purch_amt) FROM Orders;

/*12. Write a SQL statement to find the average purchase amount of all
orders.*/
SELECT AVG(purch_amt) FROM Orders;

/*13. Write a SQL statement to find the number of salesmen currently listing
for all of their customers.*/
SELECT salesman_id, COUNT(customer_id) FROM Orders GROUP BY salesman_id;

/*14. Write a SQL statement know how many customer have listed their
names.*/
SELECT COUNT(cust_name) FROM Customers;

/*15. Write a SQL statement to get the maximum purchase amount of all the
orders.*/
SELECT MAX(purch_amt) FROM Orders;

/*16. Write a SQL statement to get the minimum purchase amount of all the
orders.*/
SELECT MIN(purch_amt) FROM Orders;

/*17. Write a SQL statement which selects the highest grade for each of the
cities of the customers.*/
SELECT city, MAX(grade) FROM Customers GROUP BY city;

/*18. Write a SQL statement to find the highest purchase amount ordered by
the each customer with their ID and highest purchase amount.*/
SELECT customer_id, MAX(purch_amt) FROM Orders GROUP BY customer_id;

/*19. Write a SQL statement to find the highest purchase amount ordered by
the each customer on a particular date with their ID, order date and highest
purchase amount.*/
SELECT customer_id, ord_date, MAX(purch_amt) FROM Orders
	WHERE ord_date = '2012-10-10' GROUP BY customer_id;

/*20. Write a SQL statement to find the highest purchase amount on a date
'2012-08-17' for each salesman with their ID.*/
SELECT salesman_id, MAX(purch_amt) FROM Orders
	WHERE ord_date = '2012-08-17' GROUP BY salesman_id;
	
/*21. Write a SQL statement to find the highest purchase amount with their ID
and order date, for those customers who have a higher purchase amount
in a day is within the range 2000 and 6000.*/
SELECT customer_id, ord_date, MAX(purch_amt) FROM Orders
	WHERE purch_amt BETWEEN 2000 AND 6000 GROUP BY customer_id;
	
/*22. Write a SQL statement to find the highest purchase amount with their ID,
for only those customers whose ID is within the range 3002 and 3007.*/
SELECT customer_id, MAX(purch_amt) FROM Orders
	WHERE customer_id BETWEEN 3002 AND 3007 GROUP BY customer_id;

/*23. Write a SQL statement that counts all orders for a date August 17th,
2012.*/
SELECT COUNT(ord_no) FROM Orders WHERE ord_date = '2012-08-17';

/*24. Write a query that counts the number of salesmen with their order date
and ID registering orders for each day.*/
SELECT COUNT(salesman_id), ord_date, customer_id FROM Orders GROUP BY ord_date;

/*25. Write a SQL query to calculate the average price of all the products.*/
SELECT AVG(pro_price) FROM Products;

/*26.Write a SQL query to find the number of products with a price more
than or equal to Rs.350.*/
SELECT COUNT(pro_id) FROM Products WHERE pro_price >= 350;

/*27.Write a SQL query to display the average price of each company's
products, along with their code.*/
SELECT pro_com, AVG(pro_price) FROM Products GROUP BY pro_com;

/*28. Write a query in SQL to find the number of employees in each department
along with the department code.*/
SELECT emp_dept, COUNT(emp_idno) FROM Employees GROUP BY emp_dept;