use bumbogames
GO
CREATE OR ALTER PROCEDURE InsertCustomer
@Email NVARCHAR(50),
@Username NVARCHAR(50),
@FirstName NVARCHAR(50),
@MiddleName NVARCHAR(50) = NULL,
@LastName NVARCHAR(50),
@Pwd NVARCHAR(15),
@Birthday DATE = NULL,
@Street NVARCHAR(50),
@City NVARCHAR(20),
@Province NVARCHAR(2),
@Country NVARCHAR(30),
@Pcode NVARCHAR(6),
@Phone NVARCHAR(10),
@Verified BIT = 0,
@VerifyHash NVARCHAR(MAX) = NULL,
@Identity INT OUTPUT
AS
BEGIN
	INSERT INTO Customers (lastname,middleName,firstname, birthday, street, city, province,country, postalcode, phone, email,username, [password],verified, verifiedHash)
	VALUES (@lastname,@MiddleName, @firstname,@Birthday, @street, @city, @province,@Country, @pcode, @phone, @email, @username, @pwd,@Verified, @VerifyHash)

	SET @Identity = @@IDENTITY
END
