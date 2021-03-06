USE bumbogames
GO

CREATE OR ALTER PROCEDURE CartTotal
@CartUId VARCHAR(50)
AS
BEGIN
	SELECT 
	SUM(p.price * c.qty) as Total 
	FROM Cart c INNER JOIN Products p ON c.prodId = p.Id 
	WHERE c.cartUId = @CartUId
END
