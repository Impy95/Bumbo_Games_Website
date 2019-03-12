USE bumbogames
GO

CREATE OR ALTER PROC SearchProducts
@MatchAllWords BIT,
@CategoryId INT = NULL,
@Keyword1 NVARCHAR(50)=NULL,
@Keyword2 NVARCHAR(50)=NULL,
@Keyword3 NVARCHAR(50)=NULL,
@Keyword4 NVARCHAR(50)=NULL,
@Keyword5 NVARCHAR(50)=NULL,
@Hidden BIT = NULL 
AS
BEGIN
	IF @MatchAllWords = 0
		BEGIN
			SELECT 
			p.id
			,p.[name]
			,p.price
			,p.briefDescription
			,p.fullDescription
			,i.[name] as ImageName
			,i.altText
			,p.hidden
			,p.featured
			,(
				SELECT c.name FROM Category c WHERE c.id = p.categoryId 
			) as CategoryName
			FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%')
			OR (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%')
			OR (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%')
			OR (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%')
			OR (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%')
			AND 
			(@Hidden IS NULL OR p.hidden = @Hidden)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.price,p.CategoryId
		END
	ELSE
		BEGIN
			SELECT 
			p.id
			,p.[name]
			,p.price
			,p.briefDescription
			,p.fullDescription
			,i.[name] as ImageName
			,i.altText
			,p.hidden
			,p.featured
			,(
				SELECT c.[name] FROM Category c WHERE c.id = p.categoryId 
			) as CategoryName
			FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%')
			AND (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%')
			AND (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%')
			AND (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%')
			AND (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%')
			AND 
			(@Hidden IS NULL OR p.hidden = @Hidden)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.price,p.CategoryId
		END
END
