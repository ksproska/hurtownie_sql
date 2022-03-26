WITH names AS (
SELECT 
	CONCAT(p.LastName, ', ', p.FirstName) AS [Pracownik], 
	e.BusinessEntityID AS [pracID]
FROM 
	[HumanResources].[Employee] e
	FULL OUTER JOIN [Person].[Person] p
	ON e.BusinessEntityID = p.BusinessEntityID)
	SELECT
		names.Pracownik,
		[SalesPersonID] AS [pracID],
		YEAR([OrderDate]) AS [Rok zamównienia], 
		SUM([SubTotal]) AS [Kwota],
		COUNT([SalesOrderID]) AS [Liczba zamówieñ]
	FROM 
		[Sales].[SalesOrderHeader] sh
INNER JOIN names
ON names.pracID = sh.[SalesPersonID]
GROUP BY names.Pracownik, [SalesPersonID], YEAR([OrderDate])
ORDER BY [SalesPersonID], YEAR([OrderDate])
;
