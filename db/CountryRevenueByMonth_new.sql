USE [C:\REPOS\KENDO-DASHBOARD\ASPNET-MVC\KENDOUI-NORTHWIND-DASHBOARD\APP_DATA\NORTHWIND.MDF]
GO
/****** Object:  StoredProcedure [dbo].[CountryRevenueByMonth]    Script Date: 5/21/2014 17:14:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[CountryRevenueByMonth]
	@Country VARCHAR(50),
	@FromDate VARCHAR(50),
	@ToDate VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT Orders.OrderDate As Date, (Quantity * UnitPrice) - (Quantity * UnitPrice * Discount) AS Value
	FROM [Order Details]
		INNER JOIN Orders ON Orders.OrderID = [Order Details].OrderID
	WHERE Orders.ShipCountry = @Country AND Orders.OrderDate >=  CONVERT(DATE, @FromDate,112) AND Orders.OrderDate <=  CONVERT(DATE, @ToDate,112)
	GROUP BY (Quantity * UnitPrice) - (Quantity * UnitPrice * Discount), Orders.OrderDate
END
