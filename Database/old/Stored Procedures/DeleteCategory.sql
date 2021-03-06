USE bumbogames
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