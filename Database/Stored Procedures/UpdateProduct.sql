USE bumbogames
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
