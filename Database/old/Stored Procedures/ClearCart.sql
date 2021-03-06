USE bumbogames
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
