SELECT 
	COALESCE(c.CustomerID, 0) AS CustomerID -- No sales if Zero
	,COALESCE(SUM(soh.TotalDue), 0) AS TotalDue -- No sales if Zero
	,COALESCE(p.FirstName, '') + COALESCE(p.LastName, '') AS Fullname
FROM
	Person.Person p 
	LEFT JOIN Sales.Customer c ON P.BusinessEntityID = c.PersonID AND p.PersonType = 'IN' -- Individual Retail Customer
	LEFT JOIN sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
	LEFT JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
	LEFT JOIN Person.Address a ON bea.AddressID = a.AddressID
WHERE
	a.StateProvinceID = 9 AND a.City = 'Bellflower' --'San Fransico' -- No sales in this area
GROUP by 
	c.CustomerID
	, COALESCE(p.FirstName,'') + COALESCE(p.LastName,'')
HAVING 
	(SUM(soh.TotalDue) > 2000) -- Filter amounts by size.. Change this to see customers with no sales
ORDER BY c.CustomerID
