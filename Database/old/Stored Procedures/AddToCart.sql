USE bumbogames
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
