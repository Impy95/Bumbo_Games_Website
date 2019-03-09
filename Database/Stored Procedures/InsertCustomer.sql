use bumbogames
GO
CREATE PROCEDURE InsertCustomer
@Email NVARCHAR(50),
@Username NVARCHAR(50),
@FirstName NVARCHAR(20),
@LastName NVARCHAR(30),
@Pwd NVARCHAR(15),
@Street NVARCHAR(50),
@City NVARCHAR(20),
@Province NVARCHAR(2),
@Pcode NVARCHAR(6),
@Phone NVARCHAR(10),
@Identity INT OUTPUT
AS
BEGIN
	INSERT INTO Customers (lastname, firstname, street, city, province, postalcode, phone, email,username, [password])
	VALUES (@lastname, @firstname, @street, @city, @province, @pcode, @phone, @email, @username, @pwd)

	SET @Identity = @@IDENTITY
END
