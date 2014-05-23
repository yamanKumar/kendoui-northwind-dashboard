USE [C:\REPOS\KENDO-DASHBOARD\ASPNET-MVC\KENDOUI-NORTHWIND-DASHBOARD\APP_DATA\NORTHWIND.MDF]
GO
/****** Object:  StoredProcedure [dbo].[CountryCustomersByMonth]    Script Date: 5/22/2014 19:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CountryCustomersByMonth]
	@Country VARCHAR(50),
	@FromDate VARCHAR(50),
	@ToDate VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT CAST(COUNT(Data.Customers) AS decimal) AS Value, Data.Date FROM (
		SELECT 1 AS Customers, DATEFROMPARTS(DATEPART(YEAR, Orders.OrderDate), DATEPART(MONTH, Orders.OrderDate), 1) AS Date
		FROM Orders
		WHERE Orders.ShipCountry = @Country AND Orders.OrderDate >=  CONVERT(DATE, @FromDate,112) AND Orders.OrderDate <=  CONVERT(DATE, @ToDate,112)
		GROUP BY Orders.CustomerID, DATEFROMPARTS(DATEPART(YEAR, Orders.OrderDate), DATEPART(MONTH, Orders.OrderDate), 1)
	) AS Data 
	GROUP BY Data.Date
END
