USE bumbogames
GO

CREATE OR ALTER PROCEDURE CartCount
@CartUId VARCHAR(50)
AS
SELECT SUM(qty) FROM Cart
WHERE cartUId=@CartUId	
