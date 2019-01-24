use bumbogames

DROP TABLE IF EXISTS Products
DROP TABLE IF EXISTS Category

Create Table Products(
Productid INT NOT NULL PRIMARY KEY IDENTITY(1,1),
Name varchar(50) NOT NULL,
Description VARCHAR(255) NOT NULL,
UnitCost MONEY NOT NULL,
DisplayCost MONEY NOT NULL,
Image VARCHAR(255) NOT NULL,
CategoryID INT,
Hidden BIT  NOT NULL)

Create Table Category(
CategoryID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
CategoryName VARCHAR(255) NOT NULL,
CategoryDescription VARCHAR(255)
)

