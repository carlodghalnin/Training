/*32. We're defining high-value customers
as those who've made at least 1 order with a total
value (not including the discount) equal to $10,000 or
more. We only want to consider orders made in the
year 2016.*/
SELECT * FROM
	(SELECT MAX(O.CustomerID) AS CustomerID, 
	MAX(D.OrderID) AS OrderID, 
	MAX(O.OrderDate) AS OrderDate,
	SUM(D.UnitPrice * D.Quantity) AS TotalOrderAmount 
	FROM OrderDetails D 
	JOIN Orders O ON D.OrderID = O.OrderID
	WHERE CAST(O.OrderDate AS DATE) LIKE '2016%'
	GROUP BY O.OrderID) 
AS Temp WHERE TotalOrderAmount >= 10000
ORDER BY TotalOrderAmount DESC;

/*33. Define high-value customers as those 
who have orders totaling $15,000 or more in 2016.*/
SELECT * FROM	
	(SELECT O.CustomerID, 
	SUM(D.UnitPrice * D.Quantity) AS TotalOrders 
	FROM OrderDetails D 
	JOIN Orders O ON D.OrderID = O.OrderID
	WHERE CAST(O.OrderDate AS DATE) LIKE '2016%'
	GROUP BY O.CustomerID) 
AS Temp WHERE TotalOrders >= 15000 
ORDER BY TotalOrders DESC;

--34. Change #33 to include the discount.
SELECT * FROM	
	(SELECT O.CustomerID, 
	SUM((D.UnitPrice * (1 - D.Discount)) * D.Quantity) 
	AS TotalOrders FROM OrderDetails D 
	JOIN Orders O ON D.OrderID = O.OrderID
	WHERE CAST(O.OrderDate AS DATE) LIKE '2016%'
	GROUP BY O.CustomerID) 
AS Temp WHERE TotalOrders >= 15000 
ORDER BY TotalOrders DESC;

/*35.Show all orders made on the last day of the
month. Order by EmployeeID and OrderID.*/
SELECT OrderID, EmployeeID, OrderDate FROM Orders
	WHERE DAY(DATEADD(DAY, 1, OrderDate)) = 1
	ORDER BY EmployeeID, OrderID;

/*36. Show the 10 orders with the most line items,
in order of total line items. */
SELECT TOP 10 OrderID, COUNT(OrderID) AS LineItems 
	FROM OrderDetails GROUP BY OrderID 
	ORDER BY LineItems DESC;

--37. Show a random set of 2% of all orders.
SELECT TOP 17 OrderID  FROM Orders ORDER BY NEWID();

/*38. Show all the OrderIDs with line items that match 
60 or more, in order of OrderID.*/
SELECT * FROM
	(SELECT OrderID, MAX(Quantity) as Quantity,
	COUNT(OrderID) AS Lines FROM OrderDetails 
	GROUP BY OrderID, Quantity) AS Temp 
WHERE Lines > 1 AND Quantity >= 60 ORDER BY OrderID;

--39. Show details of duplicate orders for #38.
WITH Dupes (OrderID, Quantity, Lines) AS 
	(SELECT * FROM
		(SELECT OrderID, MAX(Quantity) as Quantity,
		COUNT(OrderID) AS Lines FROM OrderDetails 
		GROUP BY OrderID, Quantity) 
	AS Temp WHERE Lines > 1 AND Quantity >= 60)
SELECT * FROM OrderDetails WHERE OrderID IN 
	(SELECT OrderID FROM Dupes);

--*40. This is an attempt at #39.
Select
OrderDetails.OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From OrderDetails
Join (
Select
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
) PotentialProblemOrders
on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID
--It returns 20 instead of 16 rows. Correct the query.
Select
OrderDetails.OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From OrderDetails
Join (
Select
DISTINCT OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
) PotentialProblemOrders
on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID

--41. Which orders are late?
SELECT OrderID, RequiredDate, ShippedDate FROM Orders
	WHERE RequiredDate <= ShippedDate;

/*42. Which salespeople have the most orders arriving 
late? */
WITH LateOrders (EmployeeID, OrderID, 
	RequiredDate, ShippedDate) AS 
	(SELECT EmployeeID, OrderID, RequiredDate, ShippedDate
	FROM Orders WHERE RequiredDate <= ShippedDate)
SELECT EmployeeID, COUNT(EmployeeID) AS NumberLates
	FROM LateOrders GROUP BY EmployeeID
	ORDER BY NumberLates DESC;

/*43. The results in #42 need to be compared against 
the total number of orders per salesperson. */
WITH Lates (EmployeeIDL, LateOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders 
	WHERE RequiredDate <= ShippedDate 
	GROUP BY EmployeeID),
	Totals (EmployeeIDT, TotalOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders  
	GROUP BY EmployeeID)
SELECT L.EmployeeIDL, E.LastName, L.LateOrders,
	T.TotalOrders FROM Lates L JOIN Totals T
	ON L.EmployeeIDL = T.EmployeeIDT
	LEFT JOIN Employees E
	ON L.EmployeeIDL = E.EmployeeID
	ORDER BY L.EmployeeIDL;

--44. Include the missing employee in #43.
WITH Lates (EmployeeIDL, LateOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders 
	WHERE RequiredDate <= ShippedDate 
	GROUP BY EmployeeID),
	Totals (EmployeeIDT, TotalOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders  
	GROUP BY EmployeeID)
SELECT T.EmployeeIDT, E.LastName, L.LateOrders,
	T.TotalOrders 
	FROM Totals T LEFT JOIN Lates L 
	ON T.EmployeeIDT = L.EmployeeIDL
	LEFT JOIN Employees E
	ON T.EmployeeIDT = E.EmployeeID
	ORDER BY T.EmployeeIDT;

--45. Replace #44's NULL with 0.
WITH Lates (EmployeeIDL, LateOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders 
	WHERE RequiredDate <= ShippedDate 
	GROUP BY EmployeeID),
	Totals (EmployeeIDT, TotalOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders  
	GROUP BY EmployeeID)
SELECT T.EmployeeIDT, E.LastName, 
	ISNULL(L.LateOrders, 0) AS LateOrders,
	T.TotalOrders 
	FROM Totals T LEFT JOIN Lates L 
	ON T.EmployeeIDT = L.EmployeeIDL
	LEFT JOIN Employees E
	ON T.EmployeeIDT = E.EmployeeID
	ORDER BY T.EmployeeIDT;

--46. Get percentage of late versus total orders.
WITH Lates (EmployeeIDL, LateOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders 
	WHERE RequiredDate <= ShippedDate 
	GROUP BY EmployeeID),
	Totals (EmployeeIDT, TotalOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders  
	GROUP BY EmployeeID)
SELECT T.EmployeeIDT, E.LastName, 
	ISNULL(L.LateOrders, 0) AS LateOrders,
	T.TotalOrders, 
	ISNULL((LateOrders/CAST(T.TotalOrders 
	AS DECIMAL)), 0) AS PercentLates
	FROM Totals T LEFT JOIN Lates L 
	ON T.EmployeeIDT = L.EmployeeIDL
	LEFT JOIN Employees E
	ON T.EmployeeIDT = E.EmployeeID
	ORDER BY T.EmployeeIDT;

--46. Cut off decimals in #45 to 2 places.
WITH Lates (EmployeeIDL, LateOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders 
	WHERE RequiredDate <= ShippedDate 
	GROUP BY EmployeeID),
	Totals (EmployeeIDT, TotalOrders) AS 
	(SELECT EmployeeID, COUNT(*) FROM Orders  
	GROUP BY EmployeeID)
SELECT T.EmployeeIDT, E.LastName, 
	ISNULL(L.LateOrders, 0) AS LateOrders,
	T.TotalOrders, 
	CONVERT(DECIMAL(10,2), 
	ISNULL((LateOrders/CONVERT(DECIMAL(5,2), 
	T.TotalOrders)), 0)) 
	AS PercentLates
	FROM Totals T LEFT JOIN Lates L 
	ON T.EmployeeIDT = L.EmployeeIDL
	LEFT JOIN Employees E
	ON T.EmployeeIDT = E.EmployeeID
	ORDER BY T.EmployeeIDT;

/*48. Group customers by 2016 orders: 0 to 1,000,
1,000 to 5,000, 5,000 to 10,000, and over 10,000.
Order by customer ID.*/
SELECT C.CustomerID, C.CompanyName,
	SUM(D.UnitPrice * D.Quantity) AS TotalOrders 
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	JOIN OrderDetails D ON O.OrderID = D.OrderID
	WHERE CAST(O.OrderDate AS DATE) LIKE '2016%'
	GROUP BY C.CustomerID, C.CompanyName
	ORDER BY C.CustomerID;