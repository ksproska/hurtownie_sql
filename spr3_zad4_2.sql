INSERT INTO 
	[254534].dbo.Dim_Customer
SELECT 
	[CustomerId], 
	[FirstName], 
	[LastName], 
	st.Name AS [TeritoryName], 
	[CountryRegionCode], 
	[Group] 
FROM 
	[AdventureWorks2019].[Sales].[Customer] c
LEFT JOIN
[AdventureWorks2019].[Sales].[SalesTerritory] st
	ON st.TerritoryID = c.TerritoryID
LEFT JOIN [AdventureWorks2019].[Person].[Person] p
	ON c.PersonID = p.BusinessEntityID
ORDER BY [CustomerId]
;


INSERT INTO
	[254534].dbo.Dim_Product
SELECT 
	p.[ProductID], 
	p.[Name], 
	p.[ListPrice], 
	p.[Color], 
	ps.Name AS [SubCategoryName], 
	pc.Name AS [CategoryName]
FROM 
	[AdventureWorks2019].[Production].[Product] p
LEFT JOIN
	[AdventureWorks2019].[Production].[ProductSubcategory] ps
	ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN
	[AdventureWorks2019].[Production].[ProductCategory] pc
	ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY [ProductID]
;


INSERT INTO
	[254534].dbo.Fact_Orders
SELECT 
	[ProductID], 
	[CustomerID], 
	[OrderDate], 
	[ShipDate], 
	[OrderQty], 
	[UnitPrice], 
	[UnitPriceDiscount], 
	[LineTotal]
FROM 
	[AdventureWorks2019].[Sales].[SalesOrderHeader] h
LEFT JOIN [AdventureWorks2019].[Sales].[SalesOrderDetail] d
ON d.SalesOrderID = h.SalesOrderID
ORDER BY [ProductID], [CustomerID]
;