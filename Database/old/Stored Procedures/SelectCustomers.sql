USE bumbogames
GO

CREATE OR ALTER PROCEDURE SelectCustomers
@CustomerId INT = NULL,
@UserName NVARCHAR(50) = NULL
AS
BEGIN
	SELECT * FROM Customers
	WHERE
	(@UserName IS NULL OR userName = @UserName)
	ORDER BY LastName,FirstName, City
END
