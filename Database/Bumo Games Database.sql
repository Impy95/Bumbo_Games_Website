
use bumbogames

DROP TABLE IF EXISTS Products
DROP TABLE IF EXISTS Category
DROP TABLE IF EXISTS Customers
DROP TABLE IF EXISTS SiteImages
DROP TABLE IF EXISTS Cart
DROP TABLE IF EXISTS OrderDetails
DROP TABLE IF EXISTS Orders
DROP TABLE IF EXISTS adminLogin
DROP TYPE IF EXISTS OrderDetail


Create Table Products(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
name varchar(50) NOT NULL,
briefDescription VARCHAR(255) NOT NULL,
fullDescription VARCHAR(255) NOT NULL,
price MONEY NOT NULL,
imageid INT NOT NULL,
categoryID INT,
featured BIT NOT NULL,
hidden BIT  NOT NULL,)



Create Table Category(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
name VARCHAR(255) NOT NULL,
description VARCHAR(255)
)

CREATE TABLE Customers(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
userName NVARCHAR(50) NOT NULL,
email NVARCHAR(50) NOT NULL,
firstName NVARCHAR(50) NOT NULL,
middleName NVARCHAR(50) NULL,
lastName NVARCHAR(50) NOT NULL,
password NVARCHAR(15) NOT NULL,
birthday DATE NOT NULL,
street NVARCHAR(50) NOT NULL,
city NVARCHAR(20) NOT NULL,
province NVARCHAR(2) NOT NULL,
country NVARCHAR(30) NOT NULL,
postalCode NVARCHAR(6) NOT NULL,
phone NVARCHAR(10) NOT NULL,
archived BIT NOT NULL DEFAULT 0
)

CREATE TABLE SiteImages(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
name NVARCHAR(50) NOT NULL,
uploadDate DATETIME NOT NULL,
altText NVARCHAR(50) NOT NULL)

CREATE TABLE Cart(
cartUId VARCHAR(50) NOT NULL,
prodId INT NOT NULL,
qty INT NOT NULL,
[date] date NOT NULL DEFAULT CURRENT_TIMESTAMP,
)
CREATE TABLE Orders(
orderNumber INT NOT NULL PRIMARY KEY IDENTITY(1,1),
customerId INT NOT NULL,
orderDate DATE NOT NULL,
shippingStreet NVARCHAR(255) NOT NULL,
shippingCity NVARCHAR(255) NOT NULL,
shippingProvince NVARCHAR(255) NOT NULL,
shippingPostalCode NVARCHAR(255) NOT NULL,
totalAmount MONEY NOT NULL
)
CREATE TABLE OrderDetails(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
orderNumber INT NOT NULL FOREIGN KEY REFERENCES Orders(orderNumber),
productId INT NOT NULL,
quantity INT NOT NULL
)
CREATE TABLE adminLogin(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
email NVARCHAR(50) NOT NULL,
password NVARCHAR(15) NOT NULL
)

CREATE TYPE OrderDetail AS TABLE(
ProductId INT NOT NULL,
Qty INT NOT NULL
)

INSERT INTO adminLogin VALUES ('bumboAdmin','admin2019')
GO
DECLARE @IdOutput INT
EXEC insertCategory 
@Name = 'Fighting',
@Description = 'Punch kick it all in the mind',
@IdOutput = @IdOutput OUTPUT

EXEC insertCategory 
@Name = 'RPG',
@Description = 'Big Nerd Game',
@IdOutput = @IdOutput OUTPUT

EXEC insertCategory 
@Name = 'Action',
@Description = 'All the cool kids play these',
@IdOutput = @IdOutput OUTPUT

EXEC insertCategory 
@Name = 'Sports',
@Description = '....what?',
@IdOutput = @IdOutput OUTPUT
GO
GO
DECLARE @Id int, @Now datetime
set @Now = GetDate()
EXEC	[dbo].[insertProduct]
		@ProductName = N'Warbut',
		@ProductBriefDesc = N'but its war ',
		@ProductFullDesc = N'but it is time for war and warbut',
		@Hidden = 0,
		@ProductPrice = 12.50,
		@Featured = 1,
		@CategoryId = 1,
		@ImageName = N'image.png',
		@ImageUploadDate = @Now,
		@AltText = N'image',
		@Id = @Id OUTPUT
GO
DECLARE @Id int, @Now datetime
set @Now = GetDate()
EXEC	[dbo].[insertProduct]
		@ProductName = N'Warbut2',
		@ProductBriefDesc = N'WOAH A NEW GAME  ',
		@ProductFullDesc = N'THATS AMAZING',
		@Hidden = 0,
		@ProductPrice = 12.51,
		@Featured = 1,
		@CategoryId = 1,
		@ImageName = N'image.png',
		@ImageUploadDate = @Now,
		@AltText = N'image',
		@Id = @Id OUTPUT
		GO

DECLARE	@return_value int,
		@Identity int

EXEC	@return_value = [dbo].[InsertCustomer]
		@Email = N'epicpaulie@gmail.com',
		@Username = N'paulieP',
		@FirstName = N'Paulie',
		@MiddleName = NULL,
		@LastName = N'Peterson',
		@Pwd = N'password',
		@Birthday = '1996-12-12',
		@Street = N'1 Eclaire Road',
		@City = N'Terry Town',
		@Province = N'HR',
		@Country = 'New Zealand',
		@Pcode = N'111111',
		@Phone = N'1231231234',
		@Identity = @Identity OUTPUT

SELECT	@Identity as N'@Identity'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int,
		@Identity int

EXEC	@return_value = [dbo].[InsertCustomer]
		@Email = N'ouch@gmail.com',
		@Username = N'chadStrider64',
		@FirstName = N'Chad',
		@MiddleName = NULL,
		@LastName = N'JustChad',
		@Pwd = N'password',
		@Birthday = '1964-12-12',
		@Street = N'46 Boomer Street',
		@City = N'Boomer Ville',
		@Province = N'BM',
		@Country = 'Boomer',
		@Pcode = N'111BMR',
		@Phone = N'4444444444',
		@Identity = @Identity OUTPUT

SELECT	@Identity as N'@Identity'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int,
		@Identity int

EXEC	@return_value = [dbo].[InsertCustomer]
		@Email = N'smillie@gmail.com',
		@Username = N'b1gst1nk',
		@FirstName = N'Smillie',
		@MiddleName = N'Von',
		@LastName = N'Smillerton',
		@Pwd = N'password',
		@Birthday = '1900-01-01',
		@Street = N'123 stinkstreet',
		@City = N'City stinky haha',
		@Province = N'ST',
		@Country = 'Garbage',
		@Pcode = N'S1N3k',
		@Phone = N'1800Stinky',
		@Identity = @Identity OUTPUT

SELECT	@Identity as N'@Identity'

SELECT	'Return Value' = @return_value

GO

