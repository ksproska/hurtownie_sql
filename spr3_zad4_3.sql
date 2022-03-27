SELECT DISTINCT
	CONCAT([LastName], ', ', [FirstName]) AS [Nazwisko, imi�],
	p.[CategoryName] AS [Kategoria produktu],
	p.[Name] AS [Nazwa produktu],
	p.[ListPrice] AS [Cena]
FROM Dim_Customer c 
INNER JOIN Fact_Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Dim_Product p
ON o.ProductID = p.ProductID
WHERE p.[CategoryName] IS NOT NULL 
	AND p.[Name] IS NOT NULL 
	AND p.[ListPrice] IS NOT NULL 
	AND [LastName] IS NOT NULL 
	AND [FirstName] IS NOT NULL
ORDER BY [Nazwisko, imi�], [Kategoria produktu], [Nazwa produktu], [Cena]
;
