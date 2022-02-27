create proc uspNewTicketNewCar
@DateStarted Datetime = null,
@DateComplete Datetime = null,
@TicketType varchar(1),
@Comment text = null,
@EmployeeID int,
@CustomerID int = null,
@SerialNum varchar(12),
@Make varchar(50),
@Model varchar(50),
@CarYear date,
@Transmission varchar(20),
@FuelType varchar(20),
@EngineSize numeric(4,2)

AS

IF @SerialNum is null
	begin 
		print 'Cannot add car, no Serial Number given'
		return -1
	end

ELSE IF @EngineSize < 0
	begin
		print 'The engine size must be greater than 0'
		return -1
	end

ELSE IF 
(
select departmentname
from Employee
inner join EmployeeTitle
on Employee.EmpID = EmployeeTitle.EmpID
inner join title
on EmployeeTitle.JobTitle = Title.JobTitle
inner join department
on title.DepartmentNumber = Department.DepartmentNumber
where employee.EmpID = @EmployeeID) NOT LIKE 'Mechanical Service'
	begin
		print 'only employees in the mechanical department may open a ticket'
		return -1
	end

ELSE IF @SerialNum in (
select serialnum From car
)
	begin
		print 'The Serial Number is already in the system. Please check again or use uspNewTicketNewCar to add the car and create a ticket'
		return -1
	end

ELSE IF len(@SerialNum) != 12
	begin
		print 'The serial number must be 12 characters'
		return -1
	end

ELSE IF (@CustomerID is NOT NULL AND(
select CustomerID from Customer
where CustomerID = @CustomerID) IS NULL)
	Begin
		print 'The customer is not in the system'
		return -1
	End

ElSE IF @TicketType != 'S' AND @TicketType != 'R'
	begin
		print 'The ticket type must be "s" for service or "r" for repair'
		return -1
	end

ELSE IF @EngineSize <= 0
	begin
		print 'The engine size must be greater than 0'
		return -1
	end

ELSE
BEGIN

	If @DateStarted is null
	begin
		set @DateStarted = GetDate()
	end

	BEGIN TRAN
	BEGIN TRY

	INSERT INTO Car (Make, Model, CarYear, Transmission, FuelType, EngineSize, SerialNum)
	VALUES (@Make, @Model, @CarYear, @Transmission, @FuelType, @EngineSize, @SerialNum)

	INSERT INTO ServiceTicket (DateStarted, DateComplete, TicketType, Comment, SerialNum, CustomerID, EmpID)
	VALUES (@DateStarted, @DateComplete, @TicketType, @Comment, @SerialNum, @CustomerID, @EmployeeID)

	print 'The ticket has successfully been added'
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
-- see relevant tables
select * from ServiceTicket
join car
on ServiceTicket.SerialNum = car.SerialNum

-- Successful test
exec uspNewTicketNewCar
@DateStarted = '2021-05-05',
@DateComplete = '2021-05-06',
@TicketType = 'S',
@Comment = 'Service',
@EmployeeID = 100,
@CustomerID = 9,
@SerialNum = '1FADP3K22k9d',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

--test default values & null working
exec uspNewTicketNewCar
@TicketType  = 'S',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DMF',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

--empid 101 is part of accounting department, will fail
exec uspNewTicketNewCar
@TicketType = 'r',
@EmployeeID = 101,
@SerialNum = '1FADP3K21GH2',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

--serial num already exists in Database
exec uspNewTicketNewCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = '1FM5K8F87EGA',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0


--serial num is null
exec uspNewTicketNewCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = null,
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

-- serial num is less than 12 characters
exec uspNewTicketNewCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = '1FADP3K21jL',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

--customerID not in the system
exec uspNewTicketNewCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DH2',
@CustomerID = 500,
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

-- Invalid ticket type 
exec uspNewTicketNewCar
@TicketType = 'y',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DQ2',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 2.0

--Test Engine size must be greater than 0
exec uspNewTicketNewCar
@TicketType = 'S',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DQ2',
@Make = 'Test',
@Model = 'Test',
@CarYear = '2021',
@Transmission = 'Manual',
@FuelType = 'Petrol',
@EngineSize = 0
*/