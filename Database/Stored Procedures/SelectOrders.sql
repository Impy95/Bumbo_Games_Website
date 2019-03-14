USE bumbogames
GO

CREATE OR ALTER PROCEDURE SelectOrders
@OrderId INT = NULL
AS 
BEGIN
	SELECT * FROM Orders
	WHERE 
	(@OrderId IS NULL OR orderNumber = @OrderId)
END
