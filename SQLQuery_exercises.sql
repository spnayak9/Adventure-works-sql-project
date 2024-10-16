--Exercise 1a

SELECT [SalesOrderNumber] as InvoiceNumber,
SUM(TotalProductCost) as TotalProductCost
FROM FactInternetSales
group by SalesOrderNumber
HAVING SUM(TotalProductCost) > 2000
order by TotalProductCost DESC;

--Exercise 1b

SELECT SalesOrderNumber as InvoiceNumber,
SalesOrderLineNumber as InvoiceLineNumber,
SalesAmount
from FactInternetSales
WHERE CurrencyKey = 100;

--Exercise 1c

SELECT distinct [SalesTerritoryKey] 
FROM FactInternetSales
ORDER BY SalesTerritoryKey;

-- exercise 2 a

SELECT salesordernumber,
[SalesOrderLineNumber],
[SalesAmount],
[TaxAmt]
from FactInternetSales
WHERE DATENAME(MONTH,orderdate) = N'December' AND SalesTerritoryKey =1

-- exercise 2b

SELECT
CONCAT(FirstName, ' ', LastName) as CustomerName,
case
    when NumberCarsOwned in (2,3) THEN '2-3'
    when NumberCarsOwned >= 4 then '4+'
End as Numbercarsowned,
EmailAddress
from DimCustomer
WHERE HouseOwnerFlag =1 AND NumberCarsOwned > 1

-- exercise 3a

SELECT TOP(5)

    dpsc.EnglishProductSubcategoryName AS SubCategory,
    SUM(fs.SalesAmount) AS SalesAmount
 
FROM FactInternetSales AS fs
    JOIN DimProduct AS dp
    ON fs.ProductKey=dp.ProductKey
    JOIN DimProductSubcategory AS dpsc
    ON dp.ProductSubcategoryKey=dpsc.ProductSubcategoryKey
    JOIN DimCurrency AS dcy
    ON fs.CurrencyKey=dcy.CurrencyKey
    JOIN DimSalesTerritory AS dst
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
 
WHERE dst.SalesTerritoryCountry =N'United States'
AND dcy.CurrencyName=N'US Dollar'
 
GROUP BY dpsc.EnglishProductSubcategoryName
 
ORDER BY SalesAmount DESC

-- exercise 3b

SELECT 
 
    CONCAT(de.FirstName, ' ', de.LastName) AS EmployeeName,
    de.Title AS EmployeeTitle,
    dcy.CurrencyName AS Currency,
    SUM(fs.SalesAmount) AS TotalSalesAmount
 
FROM FactResellerSales AS fs
    JOIN DimEmployee AS de
    ON fs.EmployeeKey=de.EmployeeKey
    JOIN DimSalesTerritory AS dst
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
    JOIN DimCurrency AS dcy
    ON fs.CurrencyKey=dcy.CurrencyKey
 
WHERE dst.SalesTerritoryGroup =N'Europe'
AND de.[Status] =N'Current'
 
GROUP BY de.FirstName, de.LastName, de.Title, dcy.CurrencyName
 
ORDER BY EmployeeName, TotalSalesAmount DESC

-- exercise 4a

SELECT 
o.OrganizationName,
a.AccountType,
a.AccountDescription,
SUM(ff.amount) as Amount

FROM FactFinance as ff
INNER JOIN DimScenario as s
on ff.ScenarioKey = s.ScenarioKey
INNER JOIN DimDate as d
ON d.DateKey = ff.DateKey
INNER JOIN DimOrganization as o
on o.OrganizationKey = ff.OrganizationKey
INNER JOIN DimAccount as a
on a.AccountKey = ff.AccountKey

WHERE s.ScenarioName = N'Actual'
AND d.CalendarYear = 2011
AND d.EnglishMonthName = N'January'
AND o.OrganizationName = N'Southwest Division'
AND a.AccountType = N'Expenditures'

GROUP BY o.OrganizationName, a.AccountType, a.AccountDescription

ORDER BY Amount DESC

-- exercise 4b

SELECT 
a.AccountDescription,
SUM(f.Amount) AS amount,
SUM(f.Amount) / (select SUM(f.Amount) AS amount

From FactFinance as f
INNER JOIN DimAccount as a
on f.AccountKey = a.AccountKey
INNER JOIN DimScenario as s
ON s.ScenarioKey = f.ScenarioKey
INNER JOIN DimOrganization as o
ON o.OrganizationKey = f.OrganizationKey
INNER JOIN DimDate as d
ON d.DateKey = f.DateKey

WHERE s.ScenarioName = N'Actual'
AND o.OrganizationName = N'Canadian Division'
AND d.CalendarYear = 2013
AND a.AccountType = N'Expenditures') AS [Percent]

From FactFinance as f
INNER JOIN DimAccount as a
on f.AccountKey = a.AccountKey
INNER JOIN DimScenario as s
ON s.ScenarioKey = f.ScenarioKey
INNER JOIN DimOrganization as o
ON o.OrganizationKey = f.OrganizationKey
INNER JOIN DimDate as d
ON d.DateKey = f.DateKey

WHERE s.ScenarioName = N'Actual'
AND o.OrganizationName = N'Canadian Division'
AND d.CalendarYear = 2013
AND a.AccountType = N'Expenditures'

GROUP BY a.AccountDescription
ORDER BY amount DESC
