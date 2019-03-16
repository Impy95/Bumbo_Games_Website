USE bumbogames
GO

CREATE OR ALTER PROCEDURE SelectCategoryMaintenance 
@CategoryId INT = NULL,
@Keyword NVARCHAR(MAX) = NULL
AS
BEGIN

	SELECT c.*
	FROM Category c
	WHERE 
	(@CategoryId IS NULL OR c.id = @CategoryId)
	AND
	(@Keyword IS NULL OR 
		(
			[name] LIKE '%'+@Keyword+'%' OR description LIKE '%'+@Keyword+'%'
		)
	)
	
END