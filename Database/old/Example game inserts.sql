USE [bumbogames]
GO

DECLARE	@return_value int, @IdOutput int

EXEC	[dbo].[insertProduct]
		@Name = N'Cool Game',
		@Description = N'Way Past Cool',
		@UnitCost = 12.00,
		@DisplayCost = 14.99,
		@Image = 1,
		@CategoryID = NULL,
		@Hidden = false,
		@IdOutput = @IdOutput OUTPUT

SELECT	'Return Value' = @return_value

GO

USE [bumbogames]
GO

DECLARE	@return_value int, @IdOutput int

EXEC	@return_value = [dbo].[insertProduct]
		@Name = N'Lame Game',
		@Description = N'so lame',
		@UnitCost = 1.00,
		@DisplayCost = 4.99,
		@Image = 1,
		@CategoryID = NULL,
		@Hidden = false,
		@IdOutput = @IdOutput OUTPUT

SELECT	'Return Value' = @return_value

GO

USE [bumbogames]
GO

DECLARE	@return_value int, @IdOutput int

EXEC	@return_value = [dbo].[insertProduct]
		@Name = N'Hot Game',
		@Description = N'AAAAAAAAAAAAAAAAAAA',
		@UnitCost = 5.00,
		@DisplayCost = 9.99,
		@Image = N'cool.png',
		@CategoryID = NULL,
		@Hidden = false,
		@IdOutput = @IdOutput OUTPUT

SELECT	'Return Value' = @return_value

GO

USE [bumbogames]
GO

DECLARE	@return_value int, @IdOutput int

EXEC	@return_value = [dbo].[insertProduct]
		@Name = N'Dog Game',
		@Description = N'Ruh roh raggy',
		@UnitCost = 15.00,
		@DisplayCost = 19.99,
		@Image = N'dog.png',
		@CategoryID = NULL,
		@Hidden = false,
		@IdOutput = @IdOutput OUTPUT

SELECT	'Return Value' = @return_value

GO

USE [bumbogames]
GO

DECLARE	@return_value int, @IdOutput int

EXEC	@return_value = [dbo].[insertProduct]
		@Name = N'Not a Game',
		@Description = N'This isnt a game',
		@UnitCost = 4.00,
		@DisplayCost = 8.99,
		@Image = N'cool.png',
		@CategoryID = NULL,
		@Hidden = false,
		@IdOutput = @IdOutput OUTPUT

SELECT	'Return Value' = @return_value

GO