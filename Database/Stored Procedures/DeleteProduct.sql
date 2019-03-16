USE bumbogames
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