--Multiple Tables

/*1. Write a query to find those customers with their name and those salesmen
with their name and city who lives in the same city.*/
SELECT Salesman.name, Customers.cust_name, Customers.city FROM Salesman, Customers 
	WHERE Salesman.city = Customers.city;

/*2. Write a SQL statement to find the names of all customers along with the
salesmen who works for them.*/
SELECT Customers.cust_name, Salesman.name, Salesman.city FROM Salesman, Customers 
	WHERE Salesman.salesman_id = Customers.salesman_id;
	
/*3. Write a SQL statement to display all those orders by the customers not
located in the same cities where their salesmen live.*/
SELECT Orders.ord_no, Customers.city, Salesman.city FROM Orders
	INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
	INNER JOIN Salesman ON Orders.salesman_id = Salesman.salesman_id
	WHERE Customers.city <> Salesman.city;

/*4. Write a SQL statement that finds out each order number followed by the
name of the customers who made the order.*/
SELECT Orders.ord_no, Customers.cust_name FROM Orders, Customers 
	WHERE Orders.customer_id = Customers.customer_id;

/*5. Write a SQL statement that sorts out the customer and their grade who
made an order. Each of the customers must have a grade and served by
at least a salesman, who belongs to a city.*/
SELECT DISTINCT Customers.cust_name, Customers.grade, 
	Customers.salesman_id, Salesman.city FROM Customers
	INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
	INNER JOIN Salesman ON Customers.salesman_id = Salesman.salesman_id
	WHERE Customers.grade NOT NULL ORDER BY Customers.grade;

/*6. Write a query that produces all customers with their name, city, salesman
and commission, who served by a salesman and the salesman works at a
rate of the commission within 12% to 14%.*/
SELECT C.cust_name, C.city, S.name, S.commission FROM Customers C, Salesman S
	WHERE C.salesman_id = S.salesman_id AND S.commission BETWEEN 0.12 AND 0.14;

/*7. Write a SQL statement that produces all orders with the order number,
customer name, commission rate and earned commission amount for
those customers who carry their grade is 200 or more and served by an
existing salesman.*/
SELECT Orders.ord_no, Customers.cust_name, Salesman.commission,
	(Orders.purch_amt * Salesman.commission) AS Earned FROM Orders
	INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
	INNER JOIN Salesman ON Orders.salesman_id = Salesman.salesman_id
	WHERE Customers.grade >= 200;

/*8. Find all customers with orders on October 5, 2012.*/
SELECT Customers.cust_name FROM Orders
	INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
	WHERE Orders.ord_date = '2012-10-05';
	
--Subqueries:

/*1. Write a query in SQL to list all the information of the actors who played a
role in the movie 'Annie Hall'.*/
SELECT * FROM Actors WHERE act_id IN
	(SELECT act_id FROM Roles WHERE mov_id IN
	(SELECT mov_id FROM Movies WHERE mov_name = 'Annie Hall'));
	
/*2. Write a query in SQL to find the name of the director (first and last names)
who directed a movie that casted a role for 'Eyes Wide Shut'. (using
subquery)*/
SELECT dir_fname, dir_lname FROM Directors WHERE dir_id IN
	(SELECT dir_id FROM Dirmovs WHERE mov_id IN
	(SELECT mov_id FROM Movies WHERE mov_name = 'Eyes Wide Shut'));
	
/*3. Write a query in SQL to list all the movies which released in the country
other than UK.*/
SELECT mov_name FROM Movies WHERE mov_rel_country <> 'UK';

/*4. Write a query in SQL to find the movie title, year, date of release, director
and actor for those movies which reviewer is unknown.*/
SELECT M.mov_name, M.mov_year, D.dir_id, R.act_id FROM Movies M
	INNER JOIN Dirmovs D ON M.mov_id = D.mov_id
	INNER JOIN Roles R ON M.mov_id =  R.mov_id
	WHERE M.mov_id IN
	(SELECT mov_id FROM Revmovs WHERE rev_id in
	(SELECT rev_id FROM Reviewers WHERE rev_name IS NULL));
	
/*5. Write a query in SQL to find the titles of all movies directed by the director
whose first and last name are Woody Allen.*/
SELECT mov_name FROM Movies WHERE mov_id IN
	(SELECT mov_id FROM Dirmovs WHERE dir_id IN
	(SELECT dir_id FROM Directors WHERE 
	dir_fname = 'Woody' AND dir_lname = 'Allen'));

/*6. Write a query in SQL to find all the years which produced at least one
movie and that received a rating of more than 3 stars. Show the results in
increasing order.*/
SELECT mov_year, COUNT(mov_name) FROM Movies GROUP BY mov_year;
--All listed years produced at least one movie.

SELECT mov_year FROM Movies WHERE rev_stars>3 ORDER BY mov_year;

/*7. Write a query in SQL to find the titles of all movies that have no ratings.*/
SELECT mov_name FROM Movies WHERE num_o_ratings IS NULL;

/*8. Write a query in SQL to return the reviewer name, movie title, and stars for
those movies which reviewed by a reviewer and must be rated. Sort the
result by reviewer name, movie title, and number of stars.*/
SELECT rev_name, mov_name, rev_stars FROM Movies 
	WHERE rev_stars IS NOT NULL AND num_o_ratings IS NOT NULL
	ORDER BY rev_name, mov_name, rev_stars;
	
/*9. Write a query in SQL to find the movie title, and the highest number of
stars that movie received and arranged the result according to the group of
a movie and the movie title appear alphabetically in ascending order.*/
SELECT mov_name, MAX(rev_stars) FROM Movies 
	GROUP BY mov_name ORDER BY mov_name;
	
/*10. Write a query in SQL to find the titles of all movies which have been
reviewed by anybody except by Paul Monks*/
SELECT mov_name FROM Movies WHERE mov_id IN
	(SELECT mov_id FROM Revmovs WHERE rev_id NOT IN 
	(SELECT rev_id FROM Reviewers WHERE rev_name = 'Paul Monks'));