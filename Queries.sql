--- Display all customers
SELECT * FROM Customers;

--- Display all products
SELECT * FROM Products;

--- Display all Orders and their details 
SELECT o.OrderID, c.Name AS CustomerName, p.Name AS ProductName, od.Quantity, od.SubTotal
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

--- Display the quantity of each product remaining in the stock
SELECT p.Name, s.QuantityAvailable
FROM Products p JOIN Stock s ON p.ProductID = s.ProductID;

--- Total sales per product
SELECT p.Name AS 'Product Name', SUM(od.Quantity) AS 'Total Sold', SUM(od.SubTotal) AS 'Total Revenue'
FROM OrderDetails od JOIN Products p ON od.ProductID = p.ProductID
GROUP BY P.Name

--- Customers who spent more than 5,000 riyals
SELECT c.Name AS 'Customer Name', SUM(o.TotalAmount) AS TotalSpent
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name
HAVING SUM(o.TotalAmount) > 5000