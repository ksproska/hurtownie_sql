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
	[AdventureWorks2019].[Sales].[SalesTerritory] st
FULL OUTER JOIN [AdventureWorks2019].[Sales].[Customer] c
ON st.TerritoryID = c.TerritoryID
FULL OUTER JOIN [AdventureWorks2019].[Person].[Person] p
ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID IS NOT NULL
ORDER BY [CustomerId]
;


INSERT INTO
	[254534].dbo.Dim_Product
SELECT 
	[ProductID], 
	p.[Name], 
	[ListPrice], 
	[Color], 
	ps.Name AS [SubCategoryName], 
	pc.Name AS [CategoryName]
FROM 
	[AdventureWorks2019].[Production].[Product] p
FULL OUTER JOIN
	[AdventureWorks2019].[Production].[ProductSubcategory] ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
FULL OUTER JOIN
	[AdventureWorks2019].[Production].[ProductCategory] pc
ON ps.ProductSubcategoryID = pc.ProductCategoryID
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
	[AdventureWorks2019].[Sales].[SalesOrderDetail] d
INNER JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] h
ON d.SalesOrderID = h.SalesOrderID
ORDER BY [ProductID], [CustomerID]
;