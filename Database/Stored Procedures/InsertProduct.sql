CREATE PROCEDURE insertProduct
	(@Name VARCHAR(50), 
	@Description VARCHAR(255),
	@UnitCost MONEY,
	@DisplayCost MONEY,
	@Image VARCHAR(255),
	@CategoryID INT,
	@Hidden BIT)
AS
BEGIN
INSERT INTO [dbo].[Products](
Name,
Description,
UnitCost,
DisplayCost,
Image,
Hidden)
VALUES (
@Name,
@Description,
@UnitCost,
@DisplayCost,
@Image,
@Hidden)
END
GO
