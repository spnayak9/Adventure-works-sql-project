SELECT COUNT(*) as TotalCustomers,
AVG(YearlyIncome) as AVGYearlyIncome
FROM DimCustomer

SELECT * FROM DimCustomer

SELECT GETDATE()

SELECT
[OrderDate] ,
[DueDate],
[ShipDate],
DATEDIFF(year,ShipDate,GETDATE()),
DATEADD(day,10,DueDate)
FROM [dbo].[FactInternetSales]

SELECT day('20201011') -- Month, year, day

SELECT DATENAME(Month,'02-12-2020') -- Both - and / works

SET LANGUAGE British

SELECT [EnglishProductName],
[EnglishDescription],
CONCAT(EnglishProductName,'-',EnglishDescription)
FROM dimproduct

SELECT upper([EnglishProductName]),
lower([EnglishDescription]),
len(CONCAT(EnglishProductName,'-',EnglishDescription)),
REPLACE(EnglishProductName,'Front','Durable')
FROM dimproduct
WHERE Productkey = 555;

SELECT
[ProductKey],
[ProductAlternateKey],
LEFT(ProductAlternateKey,2),
SUBSTRING(ProductAlternateKey,4,4) --start, length
FROM dimproduct

SELECT * FROM dimproduct WHERE class is not NULL

SELECT DISTINCT class, LEN(class) FROM dimproduct WHERE class <> 'H' or class is NULL

SELECT EnglishProductName,
EnglishDescription,
[Status],
[Color],
class
FROM dimproduct
WHERE (class <> 'H' or class is null) and [Status] is not NULL

SELECT EnglishProductName,
EnglishDescription,
[Status],
[Color],
class,
[SafetyStockLevel]
FROM dimproduct
WHERE Color in ('Black','Silver') AND SafetyStockLevel BETWEEN 500 and 1000

SELECT firstname
FROM DimCustomer
WHERE FirstName LIKE 'R%'

SELECT firstname, EmailAddress
FROM DimCustomer
WHERE FirstName LIKE 'R__'

SELECT firstname, EmailAddress
FROM DimCustomer
WHERE FirstName LIKE '_R%'

SELECT firstName,
ISNULL(MiddleName,'UNKN'),
Coalesce(MiddleName,'Unkn'),
lastname,
YearlyIncome,
Emailaddress,
IIF(YearlyIncome > 50000,'Above Average','Below Average'),
case 
    WHEN NumberChildrenAtHome = 0 then '0'
    When NumberChildrenAtHome = 1 then '1'
    when NumberChildrenAtHome BETWEEN 2 and 4 then '2-4'
    when NumberChildrenAtHome >= 5 then '5+'
    else 'UNKN'
END
from DimCustomer
WHERE IIF(YearlyIncome > 50000,'Above Average','Below Average') = 'Below Average'

SELECT salesamount,
CAST(SalesAmount as Int),
orderdate,
CAST(OrderDate as date)
from FactInternetSales

/*
    Multiline comment
 */


SELECT [SafetyStockLevel],
[ReorderPoint],
CAST([ReorderPoint] as decimal(8,4)) / CAST([SafetyStockLevel] as decimal(8,4))
FROM DimProduct

-- unicode string
SELECT color FROM DimProduct WHERE Color IN(N'Black',N'White')

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