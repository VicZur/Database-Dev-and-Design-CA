create proc uspAddCarToSalesStock

@SerialNum varchar(12),
@Make varchar(50),
@Model varchar(50),
@CarYear date,
@Transmission varchar(20),
@FuelType varchar(20),
@EngineSize numeric(4,2),
@CarValue numeric(8,2),
@Condition varchar(1),
@ReadyForSale varchar(1),
@Sold varchar(1) = 'N'

AS

IF @SerialNum is null
	begin 
		print 'Cannot add car, no Serial Number given'
		return -1
	end

ELSE IF len(@SerialNum) != 12
	begin
		print 'The serial number must be 12 characters'
		return -1
	end

ELSE IF ((@Condition != 'N') AND (@Condition != 'U'))
	begin
		print 'The condition must be entered as N/U'
		return -1
	end
ELSE IF ((@ReadyForSale != 'N') AND (@ReadyForSale != 'Y'))
	begin
		print 'Ready for Sale must be entered as Y/N'
		return -1
	end
ELSE IF ((@Sold != 'N') AND (@Sold != 'Y'))
	begin
		print 'Sold must be entered as Y/N'
		return -1
	end
ELSE IF @EngineSize <= 0
	begin
		print 'The engine size must be greater than 0'
		return -1
	end

ELSE IF @CarValue <= 0
	begin
		print 'The car value must be greater than 0'
		return -1
	end


ELSE
	begin
	BEGIN TRAN
	BEGIN TRY
	
		INSERT into Car (SerialNum, Make, Model, CarYear, Transmission, FuelType, EngineSize)
		Values (@SerialNum, @Make, @Model, @CarYear, @Transmission, @FuelType, @EngineSize)

		INSERT into SalesStock (CarValue, Condition, ReadyForSale, Sold, SerialNum)
		Values (@CarValue, @Condition, @ReadyForSale, @Sold, @SerialNum)

		print 'The car has successfully been added'
		commit tran 
		return 0
	END TRY

	BEGIN CATCH
	Select
		ERROR_NUMBER() as ErrorNumber,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage;
		
		print 'PROBLEM! Rolling Back the Tran'
		rollback tran
		return -1
	END CATCH
end
go

/* TESTING
--successful test
exec uspAddCarToSalesStock
@SerialNum = '123456789013',
@Make ='Ford',
@Model = 'Focus',
@CarYear  = '2020',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'N',
@ReadyForSale ='Y',
@Sold = 'N'

--test default value for sold field
exec uspAddCarToSalesStock
@SerialNum = '123456789s13',
@Make ='Ford',
@Model = 'Focus',
@CarYear  = '2020',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'N',
@ReadyForSale ='Y'

--test w repeat serial num
exec uspAddCarToSalesStock
@SerialNum = '1FUY3LYB6PP4',
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'n',
@ReadyForSale ='y',
@Sold = 'n'

--test  wrong condition flag
exec uspAddCarToSalesStock
@SerialNum = 'dhfjtyruehcy',
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'y',
@ReadyForSale ='y',
@Sold = 'n'

--test Serial number null
exec uspAddCarToSalesStock
@SerialNum = null,
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'n',
@ReadyForSale ='y',
@Sold = 'n'

--test Serial Number less than 12 characters
exec uspAddCarToSalesStock
@SerialNum = '123456',
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'n',
@ReadyForSale ='y',
@Sold = 'n'

--Test wrong ReadyForSale flag
exec uspAddCarToSalesStock
@SerialNum = '123456789014',
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'n',
@ReadyForSale ='w',
@Sold = 'n'

-- Test wrong Sold flag
exec uspAddCarToSalesStock
@SerialNum = '123456789015',
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 20000,
@Condition = 'n',
@ReadyForSale ='y',
@Sold = 'w'

--Test invalid engine size
exec uspAddCarToSalesStock
@SerialNum = '123456789015',
@Make ='Ford',
@Model = 'Focus',
@CarYear  = '2020',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 0,
@CarValue = 20000,
@Condition = 'n',
@ReadyForSale ='y',
@Sold = 'n'

-- Test invalid value
exec uspAddCarToSalesStock
@SerialNum = '123456789015',
@Make ='ford',
@Model = 'focus',
@CarYear  = '2020',
@Transmission = 'manual',
@FuelType = 'petrol',
@EngineSize = 2.2,
@CarValue = 0,
@Condition = 'n',
@ReadyForSale ='y',
@Sold = 'n'

*/
