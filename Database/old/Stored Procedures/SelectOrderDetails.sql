USE bumbogames
GO
CREATE OR ALTER PROCEDURE SelectOrderDetails
@OrderId INT
AS 
BEGIN
	SELECT 
	od.id
	,p.id as ProductId
	,p.[name]
	,od.quantity
	,p.price
	,i.[name] as ImageName
	,SUM(od.quantity * p.price) as linetotal	
	 FROM OrderDetails od INNER JOIN Products p ON od.productId = p.id
	 INNER JOIN SiteImages i ON p.imageId = i.id
	WHERE 
	(@OrderId IS NULL OR od.orderNumber = @OrderId)
	GROUP BY od.id,p.id,p.[name]
	,p.price,od.quantity,i.[name]
END
