USE bumbogames
GO
CREATE OR ALTER PROCEDURE UpdateCustomer
@UserName NvarChar(50),
@Email NVARCHAR(50),
@FirstName NVARCHAR(20) = NULL,
@LastName NVARCHAR(30),
@Street NVARCHAR(50),
@City NVARCHAR(20),
@Province NVARCHAR(2),
@Pcode NVARCHAR(6),
@Phone NVARCHAR(10)
AS
BEGIN
IF @FirstName IS NULL
	UPDATE Customers SET 
	email=@Email,
	lastName = @LastName,
	street = @Street,
	city = @City,
	province = @Province,
	postalCode = @Pcode,
	phone = @Phone
	WHERE userName = @UserName;

	ELSE

	UPDATE Customers SET 
	email=@Email,
	firstName = @FirstName,
	lastName = @LastName,
	street = @Street,
	city = @City,
	province = @Province,
	postalCode = @Pcode,
	phone = @Phone
	WHERE userName = @UserName;

END
