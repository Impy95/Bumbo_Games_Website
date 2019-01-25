USE [bumbogames]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[insertProduct]
		@Name = N'Testinator',
		@Description = N'Cool killling game',
		@UnitCost = 10.59,
		@DisplayCost = 11.59,
		@Image = N'None',
		@CategoryID = NULL,
		@Hidden = False

SELECT	'Return Value' = @return_value

GO
