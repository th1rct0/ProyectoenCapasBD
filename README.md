Base datos para sistema de ejemplo del proyecto una arquitectura de 5 capas. La base de datos es una BD de Microsoft de ejemplo para practicar en SQL Managment studio. 
En SQLMS posiciona el cursor en la base de datos y dale click en adjuntar busca el archivo .mdf (este archivo es el que tiene la base de datos) tambien lo puedes hacer con .ldf(este archivo lleva el control de errores y lo que haces en la bd).
Se seguira modificando.

##PROCEDIMIENTOS ALMACENADOS <BR>
###Customer_Del PARA ELIMINAR UN DATO<BR>
```sql
USE [AdventureWorksLT2008R2]
GO
/****** Object:  StoredProcedure [dbo].[Customer_Del]    Script Date: 1/1/2026 8:09:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Ing. Humberto Ramoas Cardenas>
-- Create date: <21/11/2021,>
-- Description:	<Procedimiento para Eliminar >
-- =============================================
ALTER PROCEDURE [dbo].[Customer_Del]
	@CustomerId integer 
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DELETE FROM SalesLT.Customer WHERE CustomerID = @CustomerId;
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
```

##PROCEDIMIENTOS ALMACENADOS<BR>
###Customer_Del PARA AGERAGAR O ACTUALIZAR UN DATO<BR>

```sql
USE [AdventureWorksLT2008R2]
GO
/****** Object:  StoredProcedure [dbo].[Customer_Set]    Script Date: 1/1/2026 8:20:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Customer_Set]
	@CustomerId integer = null output,
	@NameStyle bit = 0,
	@Title nvarchar(8) = null,
	@FirstName nvarchar(50),
	@MiddleName nvarchar(50)=null,
	@LastName nvarchar(50),
	@Suffix nvarchar(10)=null,
	@CompanyName nvarchar(128)=null,
	@SalesPerson nvarchar(256) = null,
	@EmailAddress nvarchar(50)= null,
	@Phone nvarchar(25)=null,
	@PasswordHash nvarchar(128),
	@PasswordSalt nvarchar(10)
AS
BEGIN
	/*Iniciamos Revisando si el registro ya existe*/
	Declare @Nuevo bit = 0;
	Declare @IdTmp int;
	
	IF @CustomerId is not null
	BEGIN
		Select @IdTmp=CustomerId 
			from SalesLT.Customer
			Where CustomerID = @CustomerId ;
		
		IF @IdTmp is null
			Set @Nuevo = 1;
	END
	
	BEGIN TRAN
	BEGIN TRY
	IF @Nuevo = 1  --Registro es nuevo
	BEGIN
		Insert into SalesLT.Customer
			(NameStyle,Title,FirstName,MiddleName,LastName,Suffix,
			CompanyName,SalesPerson,EmailAddress,Phone,
			PasswordHash,PasswordSalt)
			values 
			(@NameStyle,@Title,@FirstName,@MiddleName,@LastName,@Suffix,
			@CompanyName,@SalesPerson,@EmailAddress,@Phone,
			@PasswordHash,@PasswordSalt);
			
		Set @CustomerId = @@IDENTITY;
	END
	ELSE
	BEGIN
		UPDATE SalesLT.Customer Set
			NameStyle = @NameStyle,
			Title = @Title,
			FirstName = @FirstName,
			MiddleName = @MiddleName,
			LastName = @LastName,
			Suffix = @Suffix,
			CompanyName = @CompanyName,
			SalesPerson = @SalesPerson,
			EmailAddress = @EmailAddress,
			Phone = @Phone,
			PasswordHash = @PasswordHash,
			PasswordSalt = @PasswordSalt,
			ModifiedDate = GETDATE()
		WHERE CustomerID = @CustomerId
			
	END

		COMMIT

	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
```
