USE bumbogames
GO

CREATE OR ALTER PROCEDURE SelectProducts
@ProductID INT = NULL,
@CategoryId INT = NULL,
@Keyword VARCHAR(50) = NULL,
@Price1 MONEY = NULL,
@Price2 MONEY = NULL,
@Featured BIT = NULL,
@Hidden BIT = NULL 
AS
BEGIN 
	
	SELECT 
	p.id
	,p.[name]
	,p.price
	,p.briefDescription
	,p.fullDescription
	,i.[name] as ImageName
	,i.altText
	,i.validated
	,p.hidden
	,p.featured
	,(
		SELECT c.[name] FROM Category c WHERE c.id = p.categoryId 
	) as CategoryName
	FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
	WHERE 
	(@ProductID IS NULL OR p.id = @ProductID)
	AND
	(@Featured IS NULL OR p.featured = @Featured)
	AND 
	(@Hidden IS NULL OR p.hidden = @Hidden)
	AND 
	(@CategoryId IS NULL OR p.categoryId = @CategoryId)
	AND
	(
		(@Price1 IS NULL OR p.price >= @Price1)
		AND 
		(@Price2 IS NULL OR p.price <= @Price2)
	)
	ORDER BY p.[name],p.price,p.CategoryId

END


