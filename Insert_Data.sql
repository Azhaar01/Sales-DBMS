USE SalesManagement;
GO 

INSERT INTO Customers (CustomerID, Name, Email, Phone, City, RegistrationDate) VALUES 
(1,	'Ahmed Ali', 'ahmed@email.com',	'0501234567', 'Riyadh', '2023-05-10'),
(2,	'Sara Khaled', 'sara@email.com', '0569876543', 'Jeddah', '2022-12-22'),
(3,	'Omar Saeed', 'omar@email.com',	'0534567890', 'Dammam',	'2024-02-15');

INSERT INTO Products (ProductID, Name, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 3500.00),
(2, 'Phone', 'Electronics', 2500.00),
(3,	'Headphones', 'Accessories', 300.00);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES 
(1,	1,	'2024-03-01',	6000.00),
(2,	2,	'2024-03-05',	3500.00);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES 
(1,	1,	1,	3500.00),
(1,	2,	1,	2500.00),
(2,	1,	1,	3500.00);

INSERT INTO Stock (ProductID, QuantityAvailable) VALUES
(1,	18),
(2,	49),
(3,	100);
