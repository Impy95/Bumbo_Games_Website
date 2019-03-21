USE bumbogames 
GO

CREATE OR ALTER PROCEDURE SelectImagesMaintenance
AS
BEGIN
SELECT * FROM SiteImages
WHERE validated = 0
END