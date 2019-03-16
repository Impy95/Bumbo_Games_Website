USE bumbogames
GO

CREATE OR ALTER PROCEDURE SelectProductMaintenance 
@ProductId INT = NULL,
@CategoryId INT = NULL,
@Keyword NVARCHAR(MAX) = NULL
AS
BEGIN

	SELECT p.*,
	(
		SELECT name FROM Category WHERE id = p.categoryId
	) as CategoryName,
	(
		SELECT name FROM SiteImages WHERE id=p.imageId
	) as ImageName
	FROM Products p
	WHERE 
	(@ProductId IS NULL OR p.id = @ProductId)
	AND
	(@CategoryId IS NULL OR p.categoryID = @CategoryId)
	AND
	(@Keyword IS NULL OR 
		(
			[name] LIKE '%'+@Keyword+'%' OR briefDescription LIKE '%'+@Keyword+'%' OR fullDescription LIKE '%'+@Keyword+'%' 
		)
	)
	
END