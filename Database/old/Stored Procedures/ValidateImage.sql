USE bumbogames
GO

CREATE OR ALTER PROCEDURE ValidateImage
@ImageName NVARCHAR(50)
AS
BEGIN
UPDATE SiteImages
SET validated=1
WHERE [name] = @ImageName
END