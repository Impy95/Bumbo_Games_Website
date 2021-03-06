USE bumbogames
GO
CREATE OR ALTER PROC [dbo].[SelectCart]
@CartUId VARCHAR(50),
@CartProdID INT = NULL
AS
BEGIN
	
	SELECT 
	c.cartUId as CartId
	,MAX(p.id) as ProductId
	,MAX(p.[name]) as ProductName
	,SUM(c.qty)	as Qty
	,MAX(p.price) as Price
	,(
		c.qty * p.price
	) AS LineTotal	
	FROM Cart c INNER JOIN Products p ON c.prodId = p.id
	WHERE 
	c.cartUId = @CartUId 
	AND 
	(@CartProdID IS NULL OR c.prodId = @CartProdID)
	GROUP BY c.cartUId,p.[name],c.qty,p.price
END
