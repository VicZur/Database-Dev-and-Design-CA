create proc uspNewTicketExistingCar
@DateStarted  Datetime = null,
@DateComplete Datetime = null,
@TicketType varchar(1),
@Comment text = null,
@EmployeeID int,
@CustomerID int = null,
@SerialNum varchar(12)

AS


IF @SerialNum is null
	begin 
		print 'Cannot add car, no Serial Number given'
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

ELSE IF len(@SerialNum) != 12
	begin
		print 'The serial number must be 12 characters'
		return -1
	end

ELSE IF (
select serialnum From car
where SerialNum = @SerialNum
) IS NULL
	begin
		print 'The Serial Number is not in the system. Please try again or use uspNewTicketNewCar to add the car and create a ticket'
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

ELSE
BEGIN

	If @DateStarted is null
	begin
		set @DateStarted = GetDate()
	end

	BEGIN TRAN
	BEGIN TRY

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
-- Successful test
exec uspNewTicketExistingCar
@DateStarted = '2021-05-05',
@DateComplete = '2021-05-06',
@TicketType = 'S',
@Comment = 'Service',
@EmployeeID = 100,
@CustomerID = 9,
@SerialNum = '1FADP3K21DL2'

--test default values & null working
exec uspNewTicketExistingCar
@TicketType  = 'S',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DL2'


--empid 101 is part of accounting department, will fail
exec uspNewTicketExistingCar
@TicketType = 'r',
@EmployeeID = 101,
@SerialNum = '1FADP3K21DL2'

--serial num doesnt exist
exec uspNewTicketExistingCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = '1FADP3K21jL2'

--serial num is null
exec uspNewTicketExistingCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = null

-- serial num is less than 12 characters
exec uspNewTicketExistingCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = '1FADP3K21jL'

--customerID not in the system
exec uspNewTicketExistingCar
@TicketType = 'r',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DL2',
@CustomerID = 500

-- Invalid ticket type 
exec uspNewTicketExistingCar
@TicketType = 'y',
@EmployeeID = 100,
@SerialNum = '1FADP3K21DL2'
*/