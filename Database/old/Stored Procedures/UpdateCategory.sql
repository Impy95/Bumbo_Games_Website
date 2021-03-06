USE bumbogames
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
