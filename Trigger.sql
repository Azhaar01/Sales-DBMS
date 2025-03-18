CREATE TRIGGER Trg_Audit
ON Orders
FOR INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Audit (ChangeID, OrderID, ProductNAME, Quantity, TotalAmount, Operation, ChangeDate)
        SELECT 
            i.OrderID AS ChangeID, 
            i.OrderID, 
            p.Name AS ProductNAME,
            od.Quantity, 
            i.TotalAmount, 
            'INSERT', 
            GETDATE()
        FROM inserted i
        JOIN OrderDetails od ON i.OrderID = od.OrderID
        JOIN Products p ON od.ProductID = p.ProductID;
    END;

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO Audit (ChangeID, OrderID, ProductNAME, Quantity, TotalAmount, Operation, ChangeDate)
        SELECT 
            d.OrderID AS ChangeID, 
            d.OrderID, 
            p.Name AS ProductNAME,
            od.Quantity, 
            d.TotalAmount, 
            'DELETE', 
            GETDATE()
        FROM deleted d
        JOIN OrderDetails od ON d.OrderID = od.OrderID
        JOIN Products p ON od.ProductID = p.ProductID;
    END;
END;

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (1, 1, '2025-03-20', 100);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal)
VALUES (1, 2, 5, 50);


DELETE FROM Orders WHERE OrderID = 1;

SELECT * FROM Audit;

