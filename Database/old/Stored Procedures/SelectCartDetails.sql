USE bumbogames
GO
CREATE OR ALTER proc SelectCartDetails
@CartUId VARCHAR(50)
AS
BEGIN
	SELECT 
	cartUId
	, c.prodId
	, c.qty
	, p.price	
	FROM 
	Cart c INNER JOIN Products p ON c.prodId = p.id 
	WHERE cartUId = @CartUId
END

