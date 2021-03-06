USE bumbogames
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
