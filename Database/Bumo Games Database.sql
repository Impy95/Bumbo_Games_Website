
use bumbogames

DROP TABLE IF EXISTS Products
DROP TABLE IF EXISTS Category
DROP TABLE IF EXISTS Customers
DROP TABLE IF EXISTS SiteImages

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
lastName NVARCHAR(50) NOT NULL,
password NVARCHAR(15) NOT NULL,
street NVARCHAR(50) NOT NULL,
city NVARCHAR(20) NOT NULL,
province NVARCHAR(2) NOT NULL,
postalCode NVARCHAR(6) NOT NULL,
phone NVARCHAR(10) NOT NULL
)

CREATE TABLE SiteImages(
id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
name NVARCHAR(50) NOT NULL,
uploadDate DATETIME NOT NULL,
altText NVARCHAR(50) NOT NULL)

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
		@Hidden = 1,
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
		@Hidden = 1,
		@ProductPrice = 12.51,
		@Featured = 1,
		@CategoryId = 1,
		@ImageName = N'image.png',
		@ImageUploadDate = @Now,
		@AltText = N'image',
		@Id = @Id OUTPUT
		GO
