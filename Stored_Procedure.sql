CREATE OR ALTER PROCEDURE orders_procedure
	@CustomerID INT,
	@OrderID INT,
	@OrderDate DATE,
	@ProductID INT, 
	@Quantity INT
AS
BEGIN 
    DECLARE @subTotal DECIMAL(10,2);
    DECLARE @TotalAmount DECIMAL(10,2);
    DECLARE @QuantityAvailable INT;
    DECLARE @Price DECIMAL(10,2);

    SELECT @Price = Price FROM Products WHERE ProductID = @ProductID;
    SELECT @QuantityAvailable = QuantityAvailable FROM Stock WHERE ProductID = @ProductID;

     IF @Quantity > @QuantityAvailable
    BEGIN
        RAISERROR('Error: Not enough stock available!', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
        VALUES (@OrderID, @CustomerID, @OrderDate, 0); --  ⁄ÌÌ‰ 0 „ƒﬁ « Õ Ï Ì „ Õ”«» «·„Ã„Ê⁄ «·‰Â«∆Ì
    END

    SET @subTotal = @Quantity * @Price;

    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal)
    VALUES (@OrderID, @ProductID, @Quantity, @subTotal);

    SELECT @TotalAmount = SUM(SubTotal) FROM OrderDetails WHERE OrderID = @OrderID;

    UPDATE Orders SET TotalAmount = @TotalAmount WHERE OrderID = @OrderID;

    UPDATE Stock SET QuantityAvailable = QuantityAvailable - @Quantity WHERE ProductID = @ProductID;
END;

--- Test the procedure
EXEC orders_procedure @CustomerID = 1, @OrderID = 101, @OrderDate = '2025-03-17', @ProductID = 2, @Quantity = 5;
EXEC orders_procedure @CustomerID = 2, @OrderID = 3, @OrderDate = '2025-03-18', @ProductID = 1, @Quantity = 8;

SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Stock;
