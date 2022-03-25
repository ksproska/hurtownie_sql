-- ZAD 1.1 -------------------------------------------------------------------------------------------------
SELECT
	YEAR([OrderDate]) AS 'Lata' 
FROM 
	[Sales].[SalesOrderHeader] 
GROUP BY YEAR([OrderDate]) 
ORDER BY YEAR([OrderDate])
;

-- ZAD 1.2 -------------------------------------------------------------------------------------------------
SELECT 
	[SalesOrderID] AS 'Identyfikator', 
	YEAR([OrderDate]) as 'Rok', 
	ROUND([SubTotal], 2) as 'Kwota'
FROM 
	[Sales].[SalesOrderHeader] 
WHERE YEAR([OrderDate]) IN (
	SELECT 
		MIN(YEAR([OrderDate]))
	FROM 
		[Sales].[SalesOrderHeader]
)
;

-- ZAD 1.3 -------------------------------------------------------------------------------------------------
SELECT 
	YEAR([OrderDate]) as 'Rok', 
	MONTH([OrderDate]) as 'Mc', 
	[SalesOrderID] AS 'Identyfikator', 
	ROUND([SubTotal], 2) as 'Kwota'
FROM 
	[Sales].[SalesOrderHeader] 
WHERE MONTH([OrderDate]) = 5
ORDER BY YEAR([OrderDate])
;

-- ZAD 2.1 -------------------------------------------------------------------------------------------------
--WITH danePersonalne AS 
--(
--	SELECT 
--	C.CustomerID AS [ClientId],
--	CONCAT(P.LastName, ', ', P.FirstName) AS [Nazwisko, imiê]
--FROM
--	[Sales].[SalesOrderHeader] S INNER JOIN [Sales].[Customer] C
--	ON S.[CustomerID] = C.[CustomerID]
--	INNER JOIN [Person].[Person] P
--	ON C.[PersonID] = P.[BusinessEntityID]
--	GROUP BY C.CustomerID
--	--ORDER BY C.CustomerID
--)
WITH freqClients AS (
	SELECT 
		S.CustomerID AS [klientId],
		COUNT(S.CustomerID) AS [Liczba zamówieñ]
	FROM
		[Sales].[SalesOrderHeader] S
	GROUP BY S.CustomerID
	HAVING COUNT(S.CustomerID) > 25
)
SELECT
	fc.klientId,
	CONCAT(P.LastName, ', ', P.FirstName) AS [Nazwisko, imiê],
	fc.[Liczba zamówieñ]

FROM
	freqClients fc
	JOIN [Sales].[Customer] C
	ON fc.klientId = C.CustomerID
	JOIN [Person].[Person] P
	ON fc.klientId = P.BusinessEntityID
ORDER BY [Liczba zamówieñ] DESC, fc.klientId
;

-- ZAD 2.2 -------------------------------------------------------------------------------------------------
SELECT 
	R.Name, 
	COUNT(HR.[SalesReasonID]) AS 'Dotyczy'
FROM
	[Sales].[SalesOrderHeaderSalesReason] HR
	RIGHT JOIN
	[Sales].[SalesReason] R
	ON HR.SalesReasonID = R.SalesReasonID
GROUP BY R.Name
ORDER BY COUNT(R.[SalesReasonID]) DESC
;

 --ZAD 3 -------------------------------------------------------------------------------------------------
WITH Pivoted AS
(
	SELECT
		[SalesPersonID],
		[CustomerID],
		COALESCE(CAST([2011] AS VARCHAR), 'brak') [2011],
		COALESCE(CAST([2012] AS VARCHAR), 'brak') [2012],
		COALESCE(CAST([2013] AS VARCHAR), 'brak') [2013],
		COALESCE(CAST([2014] AS VARCHAR), 'brak') [2014]
	FROM (
		SELECT 
			[SalesPersonID],
			[CustomerID],
			YEAR([OrderDate]) AS Rok,
			[SubTotal]
		FROM
			[Sales].[SalesOrderHeader]
		WHERE [SalesPersonID] IS NOT NULL
	) AS e
	
	PIVOT(
		SUM([SubTotal])
		FOR Rok IN ([2011], [2012], [2013], [2014])
	) AS X
)
SELECT * 
FROM Pivoted
ORDER BY [SalesPersonID], [CustomerID]
;

-- ZAD 4.1 -------------------------------------------------------------------------------------------------
WITH danePersonalne AS 
(
	SELECT 
		C.CustomerID AS 'klientId',
		CONCAT(P.LastName, ', ', P.FirstName) AS 'Nazwisko, imiê'
	FROM
		[Sales].[SalesOrderHeader] S INNER JOIN [Sales].[Customer] C
		ON S.[CustomerID] = C.[CustomerID]
		INNER JOIN [Person].[Person] P
		ON C.[PersonID] = P.[BusinessEntityID]
	GROUP BY C.CustomerID, P.LastName, P.FirstName
)
SELECT
	d.[Nazwisko, imiê],
	[CustomerID],
	CAST([2013] AS DEC(10, 2)) [2013],
	CAST([2014] AS DEC(10, 2)) [2014]
FROM (
	SELECT
		[CustomerID],
		YEAR([OrderDate]) AS Rok,
		[SubTotal]
	FROM
		[Sales].[SalesOrderHeader]
	) AS years

	PIVOT(
		AVG([SubTotal])
		FOR Rok IN ([2013], [2014])
	) AS pivoted

	INNER JOIN danePersonalne d 
	ON pivoted.CustomerID = d.klientId
ORDER BY d.[Nazwisko, imiê]
;
 --ZAD 4.2
WITH danePersonalne AS 
(
	SELECT 
		C.CustomerID AS 'klientId',
		CONCAT(P.LastName, ', ', P.FirstName) AS 'Nazwisko, imiê'
	FROM
		[Sales].[SalesOrderHeader] S 
		INNER JOIN [Sales].[Customer] C
		ON S.[CustomerID] = C.[CustomerID]
		INNER JOIN [Person].[Person] P
		ON C.[PersonID] = P.[BusinessEntityID]
	GROUP BY C.CustomerID, P.LastName, P.FirstName
)
SELECT
	d.[Nazwisko, imiê] AS 'Name',
	[CustomerID],
	ROUND(AVG(CASE WHEN YEAR([OrderDate]) = 2013 THEN [SubTotal] ELSE NULL END), 2) AS '2013',
	ROUND(AVG(CASE WHEN YEAR([OrderDate]) = 2014 THEN [SubTotal] ELSE NULL END), 2) AS '2014'
FROM 
	[Sales].[SalesOrderHeader] years
	INNER JOIN danePersonalne d 
	ON years.CustomerID = d.klientId
GROUP BY d.[Nazwisko, imiê], [CustomerID]
ORDER BY d.[Nazwisko, imiê], [CustomerID]
;