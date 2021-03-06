USE bumbogames
GO
CREATE OR ALTER PROCEDURE UpdateCustomer
@UserName NvarChar(50) = NULL,
@Email NVARCHAR(50) = NULL,
@FirstName NVARCHAR(50) = NULL,
@MiddleName NVARCHAR(50) = NULL,
@LastName NVARCHAR(50) = NULL,
@Birthday DATE = NULL,
@Street NVARCHAR(50) = NULL,
@City NVARCHAR(20) = NULL,
@Province NVARCHAR(2) = NULL ,
@Country NVARCHAR(30) = NULL,
@Pcode NVARCHAR(6) = NULL,
@Phone NVARCHAR(10) = NULL,
@Archived BIT = 1
AS
BEGIN


	UPDATE Customers SET 
	email= ISNULL(@Email, email),
	firstName = ISNULL( @FirstName, firstName),
	middleName = ISNULL(@MiddleName, middleName),
	lastName =ISNULL( @LastName, lastName),
	birthday = ISNULL(@Birthday, birthday),
	street = ISNULL(@Street,street),
	city = ISNULL(@City,city),
	province = ISNULL(@Province, province),
	country = ISNULL(@Country, country),
	postalCode = ISNULL(@Pcode, postalCode),
	phone = ISNULL(@Phone,phone),
	archived = @Archived
	WHERE userName = @UserName;

END
