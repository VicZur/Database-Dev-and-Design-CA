Create proc uspInsertNewEmployee
--employee
@PPSNumber varchar(9),
@FirstName varchar(50),
@SurName varchar(50),
@DateOfBirth date,
@HireDate date = null,

--emergency contact
@ContactFirstName varchar(50),
@ContactSurName varchar(50),
@ContactNumber varchar(25),

--employeetitle
@JobTitle varchar(50),
--assume job title start date is same as hire date for new employees

--qualification
@QualificationName varchar(100) = null,
@QualType varchar(50) = null,
@DateObtained date = null,
@AwardingBody varchar(100) = null,

--address
@Address varchar(100),
@AddressLine2 varchar(50) = null,
@AddressLine3 varchar(50) = null,
@City varchar(30),
@County varchar(12),
@PostCode varchar(7),

--contact
@PhoneNumber varchar(25),
@SecondPhoneNo varchar(25) = null,
@Email varchar(100)

AS

IF @PPSNumber is null 
	begin
		print 'Cannot add Employee, must include PPS NO'
		return -1
	end

Else if @PPSNumber in (select PPSNumber from Employee)
	begin
		print 'This PPS Number alredy exists in the system'
		return -1
	end

Else if @JobTitle Like '%Auto%' and @QualificationName is null
	begin
		print 'An employee working in a mechanical field must have a qualification'
		return -1
	end

Else IF @QualificationName is not null AND (@QualType is null OR @DateObtained is null OR @AwardingBody is null)
	begin
		print 'All fields relating to qualification must be completed if a qualification name is given'
		return -1
	end

Else IF len(@PPSNumber) < 8
	begin
		print 'The PPS Number must be at least 8 characters'
		return -1
	end

Else if (datediff(year, @DateOfBirth,getdate()) < 14)
	begin
		print 'The employee must be at least 14 years old to legally work'
		return -1
	end

Else if @DateObtained is not null and (datediff(year, @DateObtained, getdate()) < 0)
	begin
		print 'The qualification must have been obtained before today'
		return -1
	end

ELSE IF len(@Postcode) < 7
	Begin
		print 'Please enter a valid postcode'
		return -1
	end

Else if (@Email NOT LIKE '%@%') OR (@Email LIKE '% %')
	begin
		print 'Invalid Email address'
		return -1
	end

Else
BEGIN
	if @HireDate is null
	begin
		set @hiredate = GETDATE() 
	end
	

	BEGIN TRAN
	BEGIN TRY

		INSERT INTO Employee (PPSNumber, EmpFirstName, EmpSurName, EmpDOB, HireDate)
		Values (@PPSNumber, @FirstName, @SurName, @DateOfBirth, @HireDate)

		INSERT INTO EmergencyContact (ContactFirstName, ContactSurName, ContactNumber, EmpID)
		Values (@ContactFirstName, @ContactSurName, @ContactNumber, IDENT_CURRENT('Employee'))

		INSERT INTO EmployeeTitle(JobTitle, EmpID, TStartDate)
		Values (@JobTitle, IDENT_CURRENT('Employee'), @HireDate)

		INSERT INTO Address(AddressLine1, AddressLine2, AddressLine3, City, County, PostCode, EmpID)
		Values (@Address, @AddressLine2, @AddressLine3, @City, @County, @PostCode, IDENT_CURRENT('Employee'))

		INSERT INTO Contact (PrimaryPhone, SecondPhone, Email, EmpID)
		Values (@PhoneNumber, @SecondPhoneNo, @Email, IDENT_CURRENT('Employee'))

		if @QualificationName is not null
		begin
			INSERT INTO Qualification (QualName, QualType, DateObtained, AwardingBody, EmpID)
			Values (@QualificationName, @QualType, @DateObtained, @AwardingBody, IDENT_CURRENT('Employee'))
		end

		print 'The employee has successfully been added'
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
--see relevant tables
select * from Employee
join EmployeeTitle
on Employee.EmpID = EmployeeTitle.EmpID
left join Qualification
on Employee.EmpID = Qualification.EmpID
join Contact
on Employee.EmpID = Contact.EmpID
join Address
on Employee.EmpID = Address.EmpID
join EmergencyContact
on Employee.EmpID = EmergencyContact.EmpID
order by Employee.EmpID

--successful test
exec uspInsertNewEmployee
@PPSNumber = '4637485A',
@FirstName = 'Tina',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@HireDate = '2021-05-24',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Auto Mechanic',
@QualificationName = 'Apprentice',
@QualType = 'QQI Level 6',
@DateObtained = '2020-03-04',
@AwardingBody = 'QQI',
@Address = 'Testing House',
@AddressLine2 = '100 Testing Lane',
@AddressLine3 = 'Apartment 2',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@SecondPhoneNo = '0836475839',
@Email = 'test@email.com'

select * from employee


--successful test with null values working
exec uspInsertNewEmployee
@PPSNumber = '1234567B',
@FirstName = 'Tommy',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'



-- test no qualif for mechanic
exec uspInsertNewEmployee
@PPSNumber = '1234567C',
@FirstName = 'Tanya',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Auto Mechanic',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--Test PPSNumber is null
exec uspInsertNewEmployee
@PPSNumber = null,
@FirstName = 'Tammy',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Auto Mechanic',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'


--Test PPSNumber already exists (Run after insert statements)
exec uspInsertNewEmployee
@PPSNumber = '9028365R',
@FirstName = 'Tommy',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--Test if qual name is not null, but qual type/date/awarding body ARE null
exec uspInsertNewEmployee
@PPSNumber = '1234567D',
@FirstName = 'Timothy',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@HireDate = '2021-05-24',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Auto Mechanic',
@QualificationName = 'Apprentice',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--PPSNumber less that 8 digits
exec uspInsertNewEmployee
@PPSNumber = '123456A',
@FirstName = 'Torrance',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--Age less than 14 (legal working min)
exec uspInsertNewEmployee
@PPSNumber = '1234567E',
@FirstName = 'Tiger',
@SurName = 'Tester',
@DateOfBirth = '2020-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--Qualification DateObtained must be prior to now
exec uspInsertNewEmployee
@PPSNumber = '1234567F',
@FirstName = 'Triangle',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Auto Mechanic',
@QualificationName = 'Apprentice',
@QualType = 'QQI Level 6',
@DateObtained = '2022-03-03',
@AwardingBody = 'QQI',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--Check valid postcode length
exec uspInsertNewEmployee
@PPSNumber = '1234567G',
@FirstName = 'Taco',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S',
@PhoneNumber = '0983645273',
@Email = 'test@email.com'

--Check valid email address (mandatory @)
exec uspInsertNewEmployee
@PPSNumber = '1234567H',
@FirstName = 'Tommy',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'testemail.com'

--Check valid email address (no spaces)
exec uspInsertNewEmployee
@PPSNumber = '1234567I',
@FirstName = 'Tommy',
@SurName = 'Tester',
@DateOfBirth = '1990-01-01',
@ContactFirstName = 'Terry',
@ContactSurName = 'Tester',
@ContactNumber = '0987364532',
@JobTitle = 'Sales Person',
@Address = 'Testing House',
@City = 'Dublin',
@County = 'Dublin',
@PostCode = 'D82J4S7',
@PhoneNumber = '0983645273',
@Email = 'test email.com'

*/