SELECT * FROM FactInternetSales INNER JOIN DimCustomer 
on FactInternetSales.CustomerKey = DimCustomer.CustomerKey

SELECT * FROM FactInternetSales AS fs INNER JOIN DimCustomer as dc
on fs.CustomerKey = dc.CustomerKey

-- forex

SELECT
CONCAT(dc.FirstName, ' ', dc.LastName),
dc.EmailAddress,
sum(fs.SalesAmount),
dcy.CurrencyName
FROM FactInternetSales AS fs INNER JOIN DimCustomer as dc
on fs.CustomerKey = dc.CustomerKey
INNER JOIN DimCurrency as dcy
on fs.CurrencyKey = dcy.CurrencyKey
GROUP BY dc.FirstName, dc.LastName, dc.EmailAddress, dcy.CurrencyName
ORDER BY sum(fs.SalesAmount) DESC

SELECT
dp.[EnglishProductName],
dp.color,
dp.SIZE,
sum(fs.SalesAmount) AS SalesAmount
FROM FactInternetSales as fs
INNER JOIN dimproduct as dp
on fs.productkey = dp.productkey
WHERE dp.STATUS = N'Current'
GROUP BY EnglishProductName, color, dp.size
ORDER BY SalesAmount DESC

SELECT
dp.[EnglishProductName],
dp.color,
dp.SIZE,
isnull(sum(fs.SalesAmount), 0) AS SalesAmount
FROM FactInternetSales as fs
RIGHT JOIN dimproduct as dp
on fs.productkey = dp.productkey
WHERE dp.STATUS = N'Current'
GROUP BY EnglishProductName, color, dp.size
ORDER BY SalesAmount 

SELECT * FROM dimsalesreason

SELECT 
--fs.salesordernumber,
--fs.SalesOrderLineNumber,
dsr.[SalesReasonReasonType],
sum(fs.salesamount)
FROM FactInternetSales as fs
INNER JOIN [dbo].[FactInternetSalesReason] as fsr
ON fs.salesordernumber = fsr.salesordernumber AND fs.SalesOrderLineNumber = fsr.SalesOrderLineNumber
INNER JOIN [DimSalesReason]  as dsr
ON fsr.salesreasonkey = dsr.salesreasonkey
--WHERE fs.salesordernumber = N'SO51178'
GROUP BY [SalesReasonReasonType]


-- UNIONS


SELECT 
    --Sales and promo summary from Internet Sales
    fs.SalesOrderNumber AS InvoiceNumber,
    fs.SalesOrderLineNumber AS InvoiceLineNumber,
    fs.OrderDate AS OrderDate,
    fs.SalesAmount AS SalesAmount,
    fs.TaxAmt AS TaxAmount,
    fs.Freight AS FreightAmount,
    fs.OrderQuantity AS Quantity,
 
    dp.EnglishProductName AS ProductName,
 
    dpsc.EnglishProductSubcategoryName AS ProductSubCategory,
 
    dpc.EnglishProductCategoryName  AS ProductCategory,
 
    dst.SalesTerritoryCountry AS Country,
    dst.SalesTerritoryRegion AS Region,
 
    dpr.EnglishPromotionName AS PromotionName,
    dpr.EnglishPromotionType AS PromotionType,
    dpr.EnglishPromotionCategory AS PromotionCategory,
 
    dcy.CurrencyName AS Currency,

    'Web' AS Source
 
FROM FactInternetSales AS fs
    INNER JOIN DimProduct AS dp
    ON fs.ProductKey=dp.ProductKey
    INNER JOIN DimProductSubcategory AS dpsc
    ON dp.ProductSubcategoryKey=dpsc.ProductSubcategoryKey
    INNER JOIN DimProductCategory AS dpc
    ON dpsc.ProductCategoryKey=dpc.ProductCategoryKey
    INNER JOIN DimSalesTerritory AS dst
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
    INNER JOIN DimPromotion AS dpr
    ON fs.PromotionKey=dpr.PromotionKey
    INNER JOIN DimCurrency AS dcy
    On fs.CurrencyKey=dcy.CurrencyKey
 
WHERE YEAR(fs.OrderDate) IN (2012,2013)



UNION


SELECT 
    --Sales and promo summary from Reseller sales
    fs.SalesOrderNumber AS InvoiceNumber,
    fs.SalesOrderLineNumber AS InvoiceLineNumber,
    fs.OrderDate AS OrderDate,
    fs.SalesAmount AS SalesAmount,
    fs.TaxAmt AS TaxAmount,
    fs.Freight AS FreightAmount,
    fs.OrderQuantity AS Quantity,
 
    dp.EnglishProductName AS ProductName,
 
    dpsc.EnglishProductSubcategoryName AS ProductSubCategory,
 
    dpc.EnglishProductCategoryName  AS ProductCategory,
 
    dst.SalesTerritoryCountry AS Country,
    dst.SalesTerritoryRegion AS Region,
 
    dpr.EnglishPromotionName AS PromotionName,
    dpr.EnglishPromotionType AS PromotionType,
    dpr.EnglishPromotionCategory AS PromotionCategory,
 
    dcy.CurrencyName AS CurrencyKey,

    dr.ResellerName AS Source
 
FROM FactResellerSales AS fs
    INNER JOIN DimProduct AS dp
    ON fs.ProductKey=dp.ProductKey
    INNER JOIN DimProductSubcategory AS dpsc
    ON dp.ProductSubcategoryKey=dpsc.ProductSubcategoryKey
    INNER JOIN DimProductCategory AS dpc
    ON dpsc.ProductCategoryKey=dpc.ProductCategoryKey
    INNER JOIN DimSalesTerritory AS dst
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
    INNER JOIN DimPromotion AS dpr
    ON fs.PromotionKey=dpr.PromotionKey
    INNER JOIN DimCurrency AS dcy
    On fs.CurrencyKey=dcy.CurrencyKey
    INNER JOIN DimReseller AS dr
    ON fs.ResellerKey = dr.ResellerKey
 
WHERE YEAR(fs.OrderDate) IN (2012,2013)

ORDER BY OrderDate DESC

SELECT * from [dbo].[vwOrdersALL]

-- subqueries

SELECT 

    InvoiceNumber,
    InvoiceLineNumber,
    OrderDate,
    SalesAmount,
    ProductName,
    ProductSubcategory

FROM vwOrdersALL

WHERE OrderDate = (SELECT MAX(OrderDate) FROM vwOrdersALL)

