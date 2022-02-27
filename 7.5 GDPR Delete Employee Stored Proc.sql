Create proc uspDeleteEmployee
@EmployeeID int,
@EmployeeFirstName varchar(50)

AS

if @EmployeeID is null
begin
	print 'Cannot delete, must input Employee ID'
	return -1
end

else if (
select EmpID from Employee
where EmpID = @EmployeeID) is null
begin
	print 'Employee ID cannot be found'
	return -1
end

else if @EmployeeFirstName is null
begin
	print 'Cannot delete, must input Employee First Name for validation reasons'
	return -1
end

else if (
select EmpFirstName from Employee
where EmpID = @EmployeeID) != @EmployeeFirstName
begin
	print 'The employeeID and employee first name do not match an employee'
	return -1
end

else
begin

begin tran
begin try
	
	Update Employee
	Set EmpFirstName = '',
		EmpSurName = '',
		HireDate = '',
		EmpDOB = '',
		PPSNumber = '00000000'
	where EmpID = @EmployeeID

	Update Address
	Set AddressLine1 = '',
		AddressLine2 = '',
		AddressLine3 = '',
		City = '',
		County = '',
		PostCode = ''
	Where EmpID = @EmployeeID

	Update Contact
	Set PrimaryPhone = '',
		SecondPhone = '',
		Email = '@'
	Where EmpID = @EmployeeID

	Update EmergencyContact
	Set ContactFirstName = '',
	    ContactSurName = '',
	    ContactNumber = ''
	Where EmpID = @EmployeeID

	Update Qualification
	Set QualName = '',
		QualType = '',
		DateObtained = '',
		AwardingBody = ''
	Where EmpID = @EmployeeID

	print 'The employee has successfully been deleted'
	commit tran 
	return 0
end try

begin catch
Select
		ERROR_NUMBER() as ErrorNumber,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage;

END CATCH
end
go

/* TESTING

--see all relevant data
select * from
Employee
join address
on Employee.EmpID = Address.EmpID
join Contact
on Employee.EmpID = Contact.EmpID
join EmergencyContact
on Employee.EmpID = EmergencyContact.EmpID
join Qualification
on Employee.EmpID = Qualification.EmpID

--successful test update 
exec uspDeleteEmployee
@EmployeeID = 101,
@EmployeeFirstName = 'Yuri'


--error test EmployeeID not found
exec uspDeleteEmployee
@EmployeeId = 1,
@EmployeeFirstName = 'Yuri'

--Error test no ID given
exec uspDeleteEmployee
@EmployeeID = null,
@EmployeeFirstName = 'Yuri'


--Error test no name given
exec uspDeleteEmployee
@EmployeeID = 101,
@EmployeeFirstName = null

--Error test ID and name do not match
exec uspDeleteEmployee
@EmployeeID = 103,
@EmployeeFirstName = 'Yuri'
*/