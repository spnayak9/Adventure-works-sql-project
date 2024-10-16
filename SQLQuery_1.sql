SELECT CustomerKey as CustomerId, SUM(SalesAmount) as SalesAmount FROM FactInternetSales
WHERE YEAR(OrderDate) > 2010 GROUP BY CustomerKey HAVING SUM(SalesAmount) > 10000 ORDER BY SalesAmount DESC;

--select stmt

select * 
FROM FactInternetSales;

-- group by statement
select Top(10) --Percent
SalesOrderNumber as 'InvoiceNumber', --[InvoiceNumber]
OrderDate,
SUM(SalesAmount) as SalesAmount,
round(SUM(SalesAmount),1) as SalesAmount,
SUM(TaxAmt) as TaxAmt,
floor(SUM(TaxAmt)) as TaxAmt,
SUM(OrderQuantity) as OrderQuantity,
SUM(SalesAmount) + SUM(TaxAmt) as Invoicetotal
--SalesTerritoryKey
FROM FactInternetSales
--WHERE SalesTerritoryKey = 6
GROUP BY SalesOrderNumber, OrderDate
HAVING SUM(SalesAmount) > 1000
--ORDER BY SalesAmount DESC
--OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


--distinct

SELECT distinct CustomerKey

FROM FactInternetSales

ORDER BY CustomerKey;
-- order by
SELECT CustomerKey

FROM FactInternetSales

ORDER BY SalesAmount;

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