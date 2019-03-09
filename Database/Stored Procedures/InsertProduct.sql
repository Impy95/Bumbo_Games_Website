USE bumbogames
GO
CREATE OR ALTER PROCEDURE insertProduct
@ProductName NVARCHAR(50),
@ProductBriefDesc NVARCHAR(MAX),
@ProductFullDesc NVARCHAR(MAX),
@StatusCode BIT,
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
	VALUES (@ProductName,@ProductBriefDesc,@ProductFullDesc,@StatusCode,@ProductPrice,@Featured,@CategoryId,@ImageID)	
		
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