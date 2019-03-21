
use bumbogames


--DATABASE
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
hidden BIT  NOT NULL,
validatedImage bit NOT NULL DEFAULT 0)



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
birthday DATE NULL,
street NVARCHAR(50) NOT NULL,
city NVARCHAR(20) NOT NULL,
province NVARCHAR(2) NOT NULL,
country NVARCHAR(30) NOT NULL,
postalCode NVARCHAR(6) NOT NULL,
phone NVARCHAR(10) NOT NULL,
archived BIT NOT NULL DEFAULT 0,
verified BIT NOT NULL DEFAULT 0,
verifiedHash NVARCHAR(MAX) NULL 
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

--STORED PROCEDURES

GO

CREATE OR ALTER PROC AddToCart
@CartUId VARCHAR(50),
@ProductId INT,
@Qty INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
IF EXISTS (SELECT * FROM Cart WHERE cartUID=@CartUId AND prodId=@ProductId)
	BEGIN
	UPDATE Cart SET qty=qty+@Qty WHERE cartUID=@CartUId AND prodId=@ProductId
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
ELSE
	BEGIN
	INSERT INTO Cart (cartUID,prodId,qty) VALUES (@CartUId,@ProductId,@Qty)
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert into cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO

CREATE OR ALTER PROCEDURE CartCount
@CartUId VARCHAR(50)
AS
SELECT SUM(qty) FROM Cart
WHERE cartUId=@CartUId	

GO

CREATE OR ALTER PROC ClearCart
@CartUId VARCHAR(50)
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	DELETE FROM Cart WHERE cartUId=@CartUId
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Delete cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO
CREATE OR ALTER PROCEDURE DeleteCategory
@CategoryId INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
		IF EXISTS (SELECT * FROM Products WHERE categoryID=@CategoryId)
			BEGIN
				ROLLBACK TRANSACTION		
				RAISERROR('Cannot delete this categtory as it is currently related to a product. Transaction cancelled.',16,1)
				RETURN
			END
		
		DELETE FROM Category WHERE id = @CategoryId

		IF @@Error<>0
			BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Category deletion error. Transaction cancelled.',16,1)
			RETURN
			END

	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO
CREATE OR ALTER PROCEDURE DeleteFromCart
@CartUId VARCHAR(50),
@ProdId INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	Delete FROM Cart 
	WHERE cartUId=@CartUId AND prodId=@ProdId
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO

CREATE OR ALTER PROCEDURE DeleteProduct
@ProductId INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
		IF EXISTS (SELECT * FROM Cart WHERE prodId=@ProductId)
			BEGIN
				ROLLBACK TRANSACTION		
				RAISERROR('Cannot delete this product as it is currently in a cart. Transaction cancelled.',16,1)
				RETURN
			END

		IF EXISTS (SELECT * FROM OrderDetails WHERE productId = @ProductId)
			BEGIN	
				ROLLBACK TRANSACTION	
				RAISERROR('Cannot delete this product as it is currently in one or more orders. Transaction cancelled.',16,1)
				RETURN
			END
	
		DECLARE @ImageId INT
			
		SET @ImageId = (SELECT imageId FROM Products WHERE id = @ProductId)

		--Ensure this image is not used for other products
		IF NOT EXISTS (SELECT * FROM Products WHERE imageId = @ImageId AND id <> @ProductId)
			BEGIN
				DELETE FROM SiteImages WHERE id = @ImageId

				IF @@Error<>0
					BEGIN
					ROLLBACK TRANSACTION
					RAISERROR('Product deletion error. SiteImage deletion error. Transaction cancelled.',16,1)
					RETURN
					END
			END
		
		DELETE FROM Products WHERE id = @ProductId

		IF @@Error<>0
			BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Product deletion error. Transaction cancelled.',16,1)
			RETURN
			END

	/*
		All clear.
	*/
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO
CREATE OR ALTER PROCEDURE GetCartSize(@CartUId VARCHAR(50))
AS
BEGIN
SELECT SUM(qty) 
FROM CART 
WHERE cartUId = @CartUId
END

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

GO

CREATE OR ALTER PROCEDURE InsertOrder
@CustomerId INT,
@OrderDate DATE,
@CartUId VARCHAR(50),
@OrderNo INT OUTPUT,
@ShippingStreet NVARCHAR(255),
@ShippingCity NVARCHAR(255),
@ShippingProvince NVARCHAR(255),
@ShippingPostalCode NVARCHAR(255)
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	
	/*
		The OrderDetails Table Type variable for Holding my Cart Items
	*/
	DECLARE @OrderDetails AS OrderDetail

	/*
		The PK generated from inserting into Order. Needed in OrderDetails 
	*/
	DECLARE @OrderNumber INT 
	
	INSERT INTO @OrderDetails
	SELECT prodId,qty FROM Cart WHERE cartUId = @CartUId

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Cart into OrderDetail TVP error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		Transaction Good. Order Details retrieved from Cart and inserted into OrdeDetails TVP. 
		Keep Going
	*/

	/*
		Calcuate the order total based off the TVP of OrderDetail
	*/
	DECLARE @OrderTotal MONEY
	SET @OrderTotal = (
		SELECT SUM(OrderDetailLineTotal) 
		FROM (
			SELECT (oDet.Qty * (SELECT price FROM Products WHERE id = oDet.ProductId)
		) as OrderDetailLineTotal
		FROM @OrderDetails oDet) 
		LineTotalsTableAlias
		
	)

	/*
		Insert the Order Header Record
	*/
	INSERT INTO Orders (CustomerId,orderDate,totalAmount, shippingStreet,shippingCity,shippingProvince,shippingPostalCode) VALUES(@CustomerId,@OrderDate,@OrderTotal,@ShippingStreet,@ShippingCity,@ShippingProvince,@ShippingPostalCode)

	--Get the Orders PK from the insert
	SET @OrderNumber = @@IDENTITY

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Order Header error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All Good
		Insert Order Details using the Order Number and TVP
	*/

	INSERT INTO OrderDetails
	SELECT @OrderNumber,ProductId,Qty FROM @OrderDetails

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Order Details error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All Good
		Delete the Cart
	*/
	DELETE FROM Cart WHERE cartUId = @CartUId

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Cart Deletion error. Transaction cancelled.',16,1)
		RETURN
		END

	SET @OrderNo = @OrderNumber

	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO
CREATE OR ALTER PROCEDURE insertProduct
@ProductName NVARCHAR(50),
@ProductBriefDesc NVARCHAR(MAX),
@ProductFullDesc NVARCHAR(MAX),
@Hidden BIT,
@ProductPrice MONEY,
@Featured BIT,
@CategoryId INT,
@ImageName NVARCHAR(50),
@ImageUploadDate DATETIME,
@AltText NVARCHAR(50),
@Id INT OUTPUT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN

	/*
		SiteImages PK Variable for Image Insert
	*/
	DECLARE @ImageID INT

	INSERT INTO SiteImages
	([name],uploadDate,altText)
	VALUES
	(@ImageName,@ImageUploadDate,@AltText)
	
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Site Image error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear. Insert the product	
		Get the SiteImages PK
	*/
	SET @ImageID = @@IDENTITY
	
	INSERT INTO Products 
	([name],briefDescription,fullDescription,hidden,price,featured,categoryId,imageId)
	VALUES (@ProductName,@ProductBriefDesc,@ProductFullDesc,@Hidden,@ProductPrice,@Featured,@CategoryId,@ImageID)	
		
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert product error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear. Set the return @Id with the newly created productId
	*/
	SET @Id = @@IDENTITY
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

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

GO

CREATE OR ALTER PROC SearchProducts
@MatchAllWords BIT,
@CategoryId INT = NULL,
@Keyword1 NVARCHAR(50)=NULL,
@Keyword2 NVARCHAR(50)=NULL,
@Keyword3 NVARCHAR(50)=NULL,
@Keyword4 NVARCHAR(50)=NULL,
@Keyword5 NVARCHAR(50)=NULL,
@Hidden BIT = NULL 
AS
BEGIN
	IF @MatchAllWords = 0
		BEGIN
			SELECT 
			p.id
			,p.[name]
			,p.price
			,p.briefDescription
			,p.fullDescription
			,i.[name] as ImageName
			,i.altText
			,p.hidden
			,p.featured
			,(
				SELECT c.name FROM Category c WHERE c.id = p.categoryId 
			) as CategoryName
			FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%')
			OR (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%')
			OR (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%')
			OR (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%')
			OR (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%')
			AND 
			(@Hidden IS NULL OR p.hidden = @Hidden)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.price,p.CategoryId
		END
	ELSE
		BEGIN
			SELECT 
			p.id
			,p.[name]
			,p.price
			,p.briefDescription
			,p.fullDescription
			,i.[name] as ImageName
			,i.altText
			,p.hidden
			,p.featured
			,(
				SELECT c.[name] FROM Category c WHERE c.id = p.categoryId 
			) as CategoryName
			FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%')
			AND (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%')
			AND (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%')
			AND (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%')
			AND (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%')
			AND 
			(@Hidden IS NULL OR p.hidden = @Hidden)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.price,p.CategoryId
		END
END

GO
CREATE OR ALTER PROC [dbo].[SelectCart]
@CartUId VARCHAR(50),
@CartProdID INT = NULL
AS
BEGIN
	
	SELECT 
	c.cartUId as CartId
	,MAX(p.id) as ProductId
	,MAX(p.[name]) as ProductName
	,SUM(c.qty)	as Qty
	,MAX(p.price) as Price
	,(
		c.qty * p.price
	) AS LineTotal	
	FROM Cart c INNER JOIN Products p ON c.prodId = p.id
	WHERE 
	c.cartUId = @CartUId 
	AND 
	(@CartProdID IS NULL OR c.prodId = @CartProdID)
	GROUP BY c.cartUId,p.[name],c.qty,p.price
END

GO
CREATE OR ALTER proc SelectCartDetails
@CartUId VARCHAR(50)
AS
BEGIN
	SELECT 
	cartUId
	, c.prodId
	, c.qty
	, p.price	
	FROM 
	Cart c INNER JOIN Products p ON c.prodId = p.id 
	WHERE cartUId = @CartUId
END


GO
CREATE OR ALTER PROCEDURE SelectCategories
@CategoryID INT = NULL
AS
BEGIN
	SELECT * FROM Category
	WHERE @CategoryID IS NULL OR id = @CategoryID
END

GO

CREATE OR ALTER PROCEDURE SelectCategoryMaintenance 
@CategoryId INT = NULL,
@Keyword NVARCHAR(MAX) = NULL
AS
BEGIN

	SELECT c.*
	FROM Category c
	WHERE 
	(@CategoryId IS NULL OR c.id = @CategoryId)
	AND
	(@Keyword IS NULL OR 
		(
			[name] LIKE '%'+@Keyword+'%' OR description LIKE '%'+@Keyword+'%'
		)
	)
	
END

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
 
GO

CREATE OR ALTER PROCEDURE SelectImagesMaintenance
AS
BEGIN
SELECT * FROM Products
WHERE validatedImage = 0
END

GO
CREATE OR ALTER PROCEDURE SelectOrderDetails
@OrderId INT
AS 
BEGIN
	SELECT 
	od.id
	,p.id as ProductId
	,p.[name]
	,od.quantity
	,p.price
	,i.[name] as ImageName
	,SUM(od.quantity * p.price) as linetotal	
	 FROM OrderDetails od INNER JOIN Products p ON od.productId = p.id
	 INNER JOIN SiteImages i ON p.imageId = i.id
	WHERE 
	(@OrderId IS NULL OR od.orderNumber = @OrderId)
	GROUP BY od.id,p.id,p.[name]
	,p.price,od.quantity,i.[name]
END

GO

CREATE OR ALTER PROCEDURE SelectOrders
@OrderId INT = NULL
AS 
BEGIN
	SELECT * FROM Orders
	WHERE 
	(@OrderId IS NULL OR orderNumber = @OrderId)
END
GO

CREATE OR ALTER PROCEDURE SelectImageMaintenance 
@ProductId INT = NULL,
@CategoryId INT = NULL,
@Keyword NVARCHAR(MAX) = NULL
AS
BEGIN

	SELECT p.*,
	(
		SELECT name FROM SiteImages WHERE id=p.imageId
	) as ImageName
	FROM Products p
	WHERE 
	validatedImage = 0
	
END
GO

CREATE OR ALTER PROCEDURE SelectProductMaintenance 
@ProductId INT = NULL,
@CategoryId INT = NULL,
@Keyword NVARCHAR(MAX) = NULL
AS
BEGIN

	SELECT p.*,
	(
		SELECT name FROM Category WHERE id = p.categoryId
	) as CategoryName,
	(
		SELECT name FROM SiteImages WHERE id=p.imageId
	) as ImageName
	FROM Products p
	WHERE 
	(@ProductId IS NULL OR p.id = @ProductId)
	AND
	(@CategoryId IS NULL OR p.categoryID = @CategoryId)
	AND
	(@Keyword IS NULL OR 
		(
			[name] LIKE '%'+@Keyword+'%' OR briefDescription LIKE '%'+@Keyword+'%' OR fullDescription LIKE '%'+@Keyword+'%' 
		)
	)
	
END

GO

CREATE OR ALTER PROCEDURE SelectProducts
@ProductID INT = NULL,
@CategoryId INT = NULL,
@Keyword VARCHAR(50) = NULL,
@Price1 MONEY = NULL,
@Price2 MONEY = NULL,
@Featured BIT = NULL,
@Hidden BIT = NULL 
AS
BEGIN 
	
	SELECT 
	p.id
	,p.[name]
	,p.price
	,p.briefDescription
	,p.fullDescription
	,i.[name] as ImageName
	,i.altText
	,p.validatedImage
	,p.hidden
	,p.featured
	,(
		SELECT c.[name] FROM Category c WHERE c.id = p.categoryId 
	) as CategoryName
	FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
	WHERE 
	(@ProductID IS NULL OR p.id = @ProductID)
	AND
	(@Featured IS NULL OR p.featured = @Featured)
	AND 
	(@Hidden IS NULL OR p.hidden = @Hidden)
	AND 
	(@CategoryId IS NULL OR p.categoryId = @CategoryId)
	AND
	(
		(@Price1 IS NULL OR p.price >= @Price1)
		AND 
		(@Price2 IS NULL OR p.price <= @Price2)
	)
	ORDER BY p.[name],p.price,p.CategoryId

END



GO

CREATE OR ALTER PROCEDURE CartTotal
@CartUId VARCHAR(50)
AS
BEGIN
	SELECT 
	SUM(p.price * c.qty) as Total 
	FROM Cart c INNER JOIN Products p ON c.prodId = p.Id 
	WHERE c.cartUId = @CartUId
END

GO

CREATE OR ALTER PROC UpdateCart
@CartUId VARCHAR(50),
@ProdId INT,
@Qty INT
AS
BEGIN 
	IF @Qty = 0
		BEGIN
			DELETE FROM Cart WHERE 
			cartUId=@CartUId AND prodId=@ProdId
		END
	ELSE
		BEGIN
			UPDATE Cart 
			SET
			qty=@Qty
			WHERE 
			cartUId=@CartUId AND prodId=@ProdId
		END

	
END

GO

CREATE OR ALTER PROCEDURE UpdateCategory
@CategoryId INT,
@CategoryName NVARCHAR(255) = NULL,
@CategoryDesc NVARCHAR(255) = NULL
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	
	UPDATE Category 
	SET
	[name] = ISNULL(@CategoryName,[name])
	,description = ISNULL(@CategoryDesc,description)
	WHERE id= @CategoryId
		
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update product error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear.
	*/
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

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

GO

CREATE OR ALTER PROCEDURE UpdateProduct
@ProductId INT,
@ProductName NVARCHAR(50) = NULL,
@ProductBriefDesc NVARCHAR(MAX) = NULL,
@ProductFullDesc NVARCHAR(MAX) = NULL,
@Hidden BIT = NULL,
@ProductPrice MONEY = NULL,
@Featured BIT = NULL,
@CategoryId INT = NULL,
@ImageName NVARCHAR(50) = NULL,
@ImageUploadDate DATETIME = NULL,
@AltText NVARCHAR(50) = NULL
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN

	/*
		SiteImages PK Variable for Image Delete
	*/
	DECLARE @ImageId INT = NULL

	IF @ImageName IS NOT NULL
		BEGIN
			/*
				Get Old Image
			*/
			SET @ImageId = (
				SELECT imageId FROM Products WHERE id = @ProductId
			)

			DELETE FROM SiteImages
			WHERE id = @ImageID
	
			IF @@Error<>0
				BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('Delete SiteImage error. Transaction cancelled.',16,1)
				RETURN
				END

			/*
				All clear. Insert the product	 Image
				Get the SiteImages PK
			*/
			INSERT INTO SiteImages
			([name],uploadDate,altText)
			VALUES
			(@ImageName,@ImageUploadDate,@AltText)


			SET @ImageID = @@IDENTITY
		END
	
	UPDATE Products 
	SET
	[name] = ISNULL(@ProductName,[name])
	,briefDescription = ISNULL(@ProductBriefDesc,briefDescription)
	,fullDescription = ISNULL(@ProductFullDesc,fullDescription)
	,hidden = ISNULL(@Hidden,hidden)
	,price = ISNULL(@ProductPrice,price)
	,featured = ISNULL(@Featured, featured)
	,categoryId = ISNULL(@CategoryId,categoryId)
	,imageId = ISNULL(@ImageID,imageId)
	WHERE id= @ProductId
		
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update product error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear.
	*/
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO

CREATE OR ALTER PROCEDURE ValidateImage
@ProductId INT
AS
BEGIN
UPDATE Products
SET validatedImage=1
WHERE id = @ProductId
END

GO

CREATE OR ALTER PROCEDURE VerifyAccount
@VerifyHash NVARCHAR(MAX)

AS
BEGIN

UPDATE Customers SET
verified = 1
WHERE verifiedHash = @VerifyHash
END

--EXAMPLE INSERTS
GO
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
		@ProductName = N'Pokemon Crystal',
		@ProductBriefDesc = N'Catch tiny creatures ',
		@ProductFullDesc = N'Battle creatures against each other as you race to the pokemon league',
		@Hidden = 0,
		@ProductPrice = 19.99,
		@Featured = 1,
		@CategoryId = 2,
		@ImageName = N'images/image.png',
		@ImageUploadDate = @Now,
		@AltText = N'image',
		@Id = @Id OUTPUT
GO
DECLARE @Id int, @Now datetime
set @Now = GetDate()
EXEC	[dbo].[insertProduct]
		@ProductName = N'Street Fighter 2',
		@ProductBriefDesc = N'Fight in the streets',
		@ProductFullDesc = N'THATS AMAZING',
		@Hidden = 0,
		@ProductPrice = 14.99,
		@Featured = 1,
		@CategoryId = 1,
		@ImageName = N'images/image.png',
		@ImageUploadDate = @Now,
		@AltText = N'image',
		@Id = @Id OUTPUT
		GO
		DECLARE @Id int, @Now datetime
		set @Now = GetDate()
EXEC	[dbo].[insertProduct]
		@ProductName = N'Earthbound',
		@ProductBriefDesc = N'Go on an aventure and defeat Giygas',
		@ProductFullDesc = N'Join Ness, a psychic boy who can defeat the alien, Giygas.',
		@Hidden = 0,
		@ProductPrice = 899.99,
		@Featured = 0,
		@CategoryId = 2,
		@ImageName = N'images/image.png',
		@ImageUploadDate = @Now,
		@AltText = N'image',
		@Id = @Id OUTPUT
		GO
		DECLARE @Id int, @Now datetime
		set @Now = GetDate()
EXEC	[dbo].[insertProduct]
		@ProductName = N'The Legend of Zelda',
		@ProductBriefDesc = N'Save Zelda from Ganon',
		@ProductFullDesc = N'Ganon has stolen the triforce and sealed away Princess Zelda. Save her!',
		@Hidden = 0,
		@ProductPrice = 14.99,
		@Featured = 1,
		@CategoryId = 3,
		@ImageName = N'images/image.png',
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

