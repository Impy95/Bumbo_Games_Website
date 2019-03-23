USE bumbogames
GO

CREATE OR ALTER PROCEDURE VerifyAccount
@VerifyHash NVARCHAR(MAX)

AS
BEGIN

UPDATE Customers SET
verified = 1
WHERE verifiedHash = @VerifyHash
END
