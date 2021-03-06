USE bumbogames
GO

CREATE OR ALTER   PROCEDURE [dbo].[Login]
@Username NVARCHAR(50),
@Password NVARCHAR(50)
AS
BEGIN
	SELECT userName from Customers WHERE userName = @Username and password = @Password
	IF @@rowcount = 0 
		BEGIN
			RAISERROR('Username or password incorrect', 16, 1)
		END
END
