USE [bumbogames]
GO
CREATE PROC [dbo].[SearchProducts]
@MatchAllWords BIT,
@CategoryId INT = NULL,
@Keyword1 NVARCHAR(50)=NULL,
@Keyword2 NVARCHAR(50)=NULL,
@Keyword3 NVARCHAR(50)=NULL,
@Keyword4 NVARCHAR(50)=NULL,
@Keyword5 NVARCHAR(50)=NULL,
@StatusCode BIT = NULL 
AS
BEGIN
	IF @MatchAllWords = 0
		BEGIN
			SELECT
			p.Productid,
			p.[name],
			p.DisplayCost,
			p.Description,
			p.Image,
			p.CategoryID,
			p.Hidden,
			(
				SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID 
			) as CategoryName
			FROM Products p
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR Description LIKE '%'+@Keyword1+'%' OR  (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID)  LIKE '%'+@Keyword1+'%')
			OR (p.[name] LIKE '%'+@Keyword2+'%' OR Description LIKE '%'+@Keyword2+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword2+'%')
			OR (p.[name] LIKE '%'+@Keyword3+'%' OR Description LIKE '%'+@Keyword3+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword3+'%')
			OR (p.[name] LIKE '%'+@Keyword4+'%' OR Description LIKE '%'+@Keyword4+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword4+'%')
			OR (p.[name] LIKE '%'+@Keyword5+'%' OR Description LIKE '%'+@Keyword5+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword5+'%')
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.DisplayCost,p.CategoryId
		END
	ELSE
		BEGIN
			SELECT
			p.Productid,
			p.[name],
			p.DisplayCost,
			p.Description,
			p.Image,
			p.CategoryID,
			p.Hidden,
			(
				SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID 
			) as CategoryName
			FROM Products p
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR Description LIKE '%'+@Keyword1+'%' OR  (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID)  LIKE '%'+@Keyword1+'%')
			AND (p.[name] LIKE '%'+@Keyword2+'%' OR Description LIKE '%'+@Keyword2+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword2+'%')
			AND (p.[name] LIKE '%'+@Keyword3+'%' OR Description LIKE '%'+@Keyword3+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword3+'%')
			AND (p.[name] LIKE '%'+@Keyword4+'%' OR Description LIKE '%'+@Keyword4+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword4+'%')
			AND (p.[name] LIKE '%'+@Keyword5+'%' OR Description LIKE '%'+@Keyword5+'%' OR (SELECT c.CategoryName FROM Category c WHERE c.CategoryID = p.CategoryID) LIKE '%'+@Keyword5+'%')
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.DisplayCost,p.CategoryId
		END
END