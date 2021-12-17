--11. Show only the date portion of the BirthDate field.
SELECT FirstName, LastName, Title, CAST(BirthDate AS DATE) 
	AS DateOnlyBirthDate FROM Employees;

/*12. Show the FirstName and LastName columns from
the Employees table, and then create a new column
called FullName, showing FirstName and LastName
joined together in one column, with a space inbetween.*/
SELECT FirstName, LastName, 
	CONCAT(FirstName,' ',LastName) AS FullName
	FROM Employees;

/*13. In the OrderDetails table, we have the fields
UnitPrice and Quantity. Create a new field,
TotalPrice, that multiplies these two together. We’ll
ignore the Discount field for now.
In addition, show the OrderID, ProductID, UnitPrice,
and Quantity. Order by OrderID and ProductID.*/
SELECT OrderID, ProductID, UnitPrice, Quantity,
	(UnitPrice * Quantity) AS TotalPrice
	FROM OrderDetails ORDER BY OrderID, ProductID;

/*14. How many customers do we have in the Customers
table? Show one value only, and don’t rely on getting
the recordcount at the end of a resultset.*/
SELECT COUNT(CustomerID) AS TotalCustomers FROM Customers;

/*15. Show the date of the first order ever made in the
Orders table.*/
SELECT MIN(OrderDate) AS FirstOrder FROM Orders;

/*16. Show a list of countries where the Northwind
company has customers.*/
SELECT DISTINCT Country FROM Customers;

/*17. Show a list of all the different values in the
Customers table for ContactTitles. Also include a
count for each ContactTitle.*/
SELECT ContactTitle, COUNT(ContactTitle) 
	AS TotalContactTitle
	FROM Customers GROUP BY ContactTitle
	ORDER BY TotalContactTitle DESC;

/*18. We’d like to show, for each product, the associated
Supplier. Show the ProductID, ProductName, and the
CompanyName of the Supplier. Sort by ProductID.*/
SELECT P.ProductID, P.ProductName, S.CompanyName
	FROM Products P	INNER JOIN Suppliers S ON 
	P.SupplierID = S.SupplierID
	ORDER BY ProductID;

/*19. We’d like to show a list of the Orders that were
made, including the Shipper that was used. Show the
OrderID, OrderDate (date only), and CompanyName
of the Shipper, and sort by OrderID.
In order to not show all the orders (there’s more than
800), show only those rows with an OrderID of less
than 10300.*/
SELECT O.OrderID, CAST(O.OrderDate AS DATE) AS OrderDate,
	S.CompanyName FROM Orders O INNER JOIN Shippers S 
	ON O.ShipVia = S.ShipperID
	WHERE O.OrderID < 10300 ORDER BY O.OrderID;