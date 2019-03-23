use bumbogames
GO
CREATE OR ALTER PROCEDURE SelectCategories
@CategoryID INT = NULL
AS
BEGIN
	SELECT * FROM Category
	WHERE @CategoryID IS NULL OR id = @CategoryID
END