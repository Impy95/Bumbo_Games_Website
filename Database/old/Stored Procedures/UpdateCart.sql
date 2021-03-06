USE bumbogames
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
