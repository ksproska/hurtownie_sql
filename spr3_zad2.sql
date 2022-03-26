WITH names AS (
	SELECT 
		CONCAT(p.LastName, ', ', p.FirstName) AS [Pracownik], 
		e.BusinessEntityID AS [pracID]
	FROM 
		[HumanResources].[Employee] e
	FULL OUTER JOIN [Person].[Person] p
	ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT DISTINCT
	names.Pracownik,
	[SalesPersonID] AS [pracID],
	YEAR([OrderDate]) AS [Rok zamównienia], 
	ROUND(SUM([SubTotal]) OVER(PARTITION BY [SalesPersonID], YEAR([OrderDate])), 2) AS [Kwota],
	COUNT([SalesOrderID]) OVER(PARTITION BY [SalesPersonID], YEAR([OrderDate])) AS [Liczba zamówieñ]
FROM 
	[Sales].[SalesOrderHeader] sh
INNER JOIN names
ON names.pracID = sh.SalesPersonID
WHERE [SalesPersonID] IS NOT NULL
ORDER BY [pracID], YEAR([OrderDate])
;