USE bumbogames
GO

CREATE OR ALTER PROCEDURE InsertOrder
@CustomerId INT,
@OrderDate DATE,
@CartUId VARCHAR(50),
@OrderNo INT OUTPUT,
@ShippingStreet NVARCHAR(255),
@ShippingCity NVARCHAR(255),
@ShippingProvince NVARCHAR(255),
@ShippingPostalCode NVARCHAR(255)
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	
	/*
		The OrderDetails Table Type variable for Holding my Cart Items
	*/
	DECLARE @OrderDetails AS OrderDetail

	/*
		The PK generated from inserting into Order. Needed in OrderDetails 
	*/
	DECLARE @OrderNumber INT 
	
	INSERT INTO @OrderDetails
	SELECT prodId,qty FROM Cart WHERE cartUId = @CartUId

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Cart into OrderDetail TVP error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		Transaction Good. Order Details retrieved from Cart and inserted into OrdeDetails TVP. 
		Keep Going
	*/

	/*
		Calcuate the order total based off the TVP of OrderDetail
	*/
	DECLARE @OrderTotal MONEY
	SET @OrderTotal = (
		SELECT SUM(OrderDetailLineTotal) 
		FROM (
			SELECT (oDet.Qty * (SELECT price FROM Products WHERE id = oDet.ProductId)
		) as OrderDetailLineTotal
		FROM @OrderDetails oDet) 
		LineTotalsTableAlias
		
	)

	/*
		Insert the Order Header Record
	*/
	INSERT INTO Orders (CustomerId,orderDate,totalAmount, shippingStreet,shippingCity,shippingProvince,shippingPostalCode) VALUES(@CustomerId,@OrderDate,@OrderTotal,@ShippingStreet,@ShippingCity,@ShippingProvince,@ShippingPostalCode)

	--Get the Orders PK from the insert
	SET @OrderNumber = @@IDENTITY

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Order Header error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All Good
		Insert Order Details using the Order Number and TVP
	*/

	INSERT INTO OrderDetails
	SELECT @OrderNumber,ProductId,Qty FROM @OrderDetails

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Order Details error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All Good
		Delete the Cart
	*/
	DELETE FROM Cart WHERE cartUId = @CartUId

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Cart Deletion error. Transaction cancelled.',16,1)
		RETURN
		END

	SET @OrderNo = @OrderNumber

	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
