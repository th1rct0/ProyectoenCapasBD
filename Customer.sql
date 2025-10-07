USE [AdventureWorksLT2008R2]
GO
/****** Object:  StoredProcedure [dbo].[Customer_Get]    Script Date: 10/5/2025 8:16:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--=================================================================
---AUTHOR:		 Ing. Humberto Ramos
---Create date:	 10/4/2025
---Descripcion:	 Devuelve los registros de Customer

ALTER PROCEDURE [dbo].[Customer_Get]
	@CustomerId integer = null
AS
BEGIN
	IF @CustomerId IS NULL
	BEGIN
		--Devolver todos los registros
		Select *
			From SalesLT.Customer
	END
	ELSE
	BEGIN
		SELECT *
			FROM SalesLT.Customer
			WHERE CustomerID = @CustomerId
	END
END