SELECT
Region,
ProductCategory,
SUM(SalesAmount)
from [dbo].[vwOrdersALL]
WHERE YEAR(OrderDate) = 2013 AND Currency = N'US Dollar'
GROUP BY Region, ProductCategory

-- Cube function
SELECT
Region,
ProductCategory,
SUM(SalesAmount)
from [dbo].[vwOrdersALL]
WHERE YEAR(OrderDate) = 2013 AND Currency = N'US Dollar'
GROUP BY cube(Region, ProductCategory)

-- Rollup function

SELECT
ProductCategory,
ProductSubCategory,
SUM(SalesAmount)
from [dbo].[vwOrdersALL]
WHERE YEAR(OrderDate) = 2013 AND Currency = N'US Dollar'
GROUP BY rollup(ProductCategory, ProductSubCategory)

-- Subquery
SELECT
[Source],
SUM(SalesAmount) AS Sales,
SUM(SalesAmount) / (SELECT SUM(SalesAmount) from [dbo].[vwOrdersALL] WHERE country = N'United States' and [Source] <> 'web')
from [dbo].[vwOrdersALL]
WHERE country = N'United States' and [Source] <> 'web'
GROUP BY [Source]
ORDER BY Sales DESC