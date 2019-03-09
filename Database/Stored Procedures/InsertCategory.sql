CREATE OR ALTER PROCEDURE insertCategory(@Name VARCHAR(50), @Description VARCHAR(255), @IdOutput INT OUTPUT)

AS
BEGIN
INSERT INTO [dbo].[Category](
name,
description)
VALUES (
@Name,
@Description)
SET @IdOutput = SCOPE_IDENTITY()
END
GO