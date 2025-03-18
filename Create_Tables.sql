USE SalesManagement;
GO 
Create Table Customers(
	CustomerID INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL UNIQUE,
	Phone VARCHAR(20),
	City VARCHAR(100),
	RegistrationDate DATE DEFAULT GETDATE() 
);
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Category VARCHAR(255) NOT NULL,
	Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0)
)

CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
	CustomerID INT NOT NULL,
	OrderDate DATE NOT NULL,
	TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
)

CREATE TABLE OrderDetails (
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL CHECK(Quantity > 0),
	SubTotal DECIMAL(10,2) NOT NULL CHECK (SubTotal > 0),
	PRIMARY KEY (OrderID, ProductID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
)

CREATE TABLE Stock (
	ProductID INT PRIMARY KEY,
	QuantityAvailable INT NOT NULL CHECK(QuantityAvailable >= 0),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
)