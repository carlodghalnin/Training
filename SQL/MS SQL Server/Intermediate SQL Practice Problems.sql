/*20. For this problem, we’d like to see the total number of
products in each category. Sort the results by the total
number of products, in descending order.*/
SELECT C.CategoryName, COUNT(P.CategoryID) AS NumberProducts 
	FROM Products P INNER JOIN Categories C 
	ON P.CategoryID = C.CategoryID GROUP BY C.CategoryName 
	ORDER BY NumberProducts DESC;

/*21. In the Customers table, show the total number of
customers per Country and City.*/
SELECT Country, City, COUNT(CustomerID) AS TotalCustomer 
	FROM Customers GROUP BY City, Country
	ORDER BY TotalCustomer DESC;

/*22. What products do we have in our inventory that
should be reordered? For now, just use the fields
UnitsInStock and ReorderLevel, where UnitsInStock
is less than the ReorderLevel, ignoring the fields
UnitsOnOrder and Discontinued.
Order the results by ProductID.*/
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel 
	FROM Products WHERE UnitsInStock < ReorderLevel
	ORDER BY ProductID;

/*23. Now we need to incorporate these fields—
UnitsInStock, UnitsOnOrder, ReorderLevel,
Discontinued—into our calculation. We’ll define
“products that need reordering” with the following:
UnitsInStock plus UnitsOnOrder are less than
or equal to ReorderLevel
The Discontinued flag is false (0).*/
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder,
	ReorderLevel FROM Products 
	WHERE (UnitsInStock + UnitsOnOrder) <= ReorderLevel
	AND Discontinued = 0 ORDER BY ProductID;

/*24. A salesperson for Northwind is going on a business
trip to visit customers, and would like to see a list of
all customers, sorted by region, alphabetically.

However, he wants the customers with no region
(null in the Region field) to be at the end, instead of
at the top, where you’d normally find the null values.
Within the same region, companies should be sorted
by CustomerID.*/
SELECT CustomerID, CompanyName, Region,
	CASE
		WHEN Region IS NULL THEN 1
		ELSE 0
	END AS Located
	FROM Customers ORDER BY Located, Region;

/*25. Some of the countries we ship to have very high
freight charges. We'd like to investigate some more
shipping options for our customers, to be able to offer
them lower freight charges. Return the three ship
countries with the highest average freight overall, in
descending order by average freight.*/
SELECT TOP 3 AVG(Freight) AS AvgFreight, ShipCountry FROM Orders
	GROUP BY ShipCountry ORDER BY AvgFreight DESC;

/*26. Now, instead of using all the orders
we have, we only want to see orders from the year
2015.*/
SELECT TOP 3 AVG(Freight) AS AvgFreight, ShipCountry FROM Orders
	WHERE CAST(OrderDate AS DATE) LIKE '2015%'
	GROUP BY ShipCountry ORDER BY AvgFreight DESC;

/*27. Another (incorrect) answer to the problem above is
this:*/

Select Top 3
ShipCountry
,AverageFreight = avg(freight)
From Orders
Where
OrderDate between '1/1/2015' and '12/31/2015'
Group By ShipCountry
Order By AverageFreight desc;

/*Notice when you run this, it gives Sweden as the
ShipCountry with the third highest freight charges.
However, this is wrong - it should be France.
What is the OrderID of the order that the (incorrect)
answer above is missing?*/
SELECT OrderID, OrderDate FROM Orders
	WHERE CAST(OrderDate AS DATE) LIKE '2015%'
	AND OrderDate NOT between '1/1/2015' and '12/31/2015';
--OrderIDs 10806 and 10807, with OrderDate 2015-12-31 11:00:00.000

/*28. We now want to get the three ship countries with the
highest average freight charges. But instead of
filtering for a particular year, we want to use the last
12 months of order data, using as the end date the last
OrderDate in Orders.*/
SELECT TOP 3 AVG(Freight) AS AvgFreight, ShipCountry FROM Orders
	WHERE OrderDate BETWEEN 
	DATEADD(YYYY, -1, (SELECT MAX(OrderDate) FROM Orders)) AND 
	(SELECT MAX(OrderDate) FROM Orders)
	GROUP BY ShipCountry ORDER BY AvgFreight DESC;

/*29. Show EmployeeID, LastName, OrderID, ProductName, and
Quantity. Sort by OrderID and Product ID.*/
SELECT O.EmployeeID, E.LastName, O.OrderID, P.ProductName,
	D.Quantity FROM Orders O
	INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
	INNER JOIN OrderDetails D ON O.OrderID = D.OrderID
	INNER JOIN Products P ON D.ProductID = P.ProductID
	ORDER BY O.OrderID, D.ProductID;

/*30. There are some customers who have never actually
placed an order. Show these customers.*/
SELECT DISTINCT CustomerID FROM Customers
	WHERE CustomerID NOT IN 
	(SELECT DISTINCT CustomerID FROM Orders);

/*31. One employee (Margaret Peacock, EmployeeID 4)
has placed the most orders. However, there are some
customers who've never placed an order with her.
Show only those customers who have never placed
an order with her.*/
SELECT DISTINCT CustomerID FROM Customers
	WHERE CustomerID NOT IN 
	(SELECT DISTINCT CustomerID FROM Orders
	WHERE EmployeeID = 4);