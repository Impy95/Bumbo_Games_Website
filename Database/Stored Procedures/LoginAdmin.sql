USE bumbogames
GO
CREATE OR ALTER   PROCEDURE LoginAdmin
@Email NVARCHAR(50),
@Password NVARCHAR(50)
AS
SELECT email,[password] FROM adminLogin 
WHERE email=@Email AND [password]=@Password

IF @@rowcount = 0 
	BEGIN
		RAISERROR('Username or password incorrect', 16, 1)
		RETURN
	END
