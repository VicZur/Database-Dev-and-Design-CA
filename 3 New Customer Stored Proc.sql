Create PROC uspNewCustomer
@FirstName varchar(50),
@SurName varchar(50),
@Active varchar(1) = 'y',
@PhoneNumber varchar(25),
@SecondPhoneNo varchar(25) = null,
@Email varchar(100),
@Address varchar(100),
@AddressLine2 varchar(50) = null,
@AddressLine3 varchar(50) = null,
@City varchar(30),
@County varchar(12),
@PostCode varchar(7)

AS

IF (@Email NOT LIKE '%@%') OR (@Email LIKE '% %')
	begin
		print 'Invalid Email address'
		return -1
	end

ELSE IF len(@Postcode) < 7
	Begin
		print 'Please enter a valid postcode'
		return -1
	end

ELSE
begin
begin tran
	begin try

		Insert Into Customer (CFirstName, CSurName, Active)
		Values (@FirstName, @SurName, @Active)

		Insert Into Contact (PrimaryPhone, SecondPhone, Email, CustomerID)
		Values (@PhoneNumber, @SecondPhoneNo, @Email, IDENT_CURRENT('Customer'))

		Insert Into Address (AddressLine1, AddressLine2, AddressLine3, City, County, PostCode, CustomerID)
		Values (@Address, @AddressLine2, @AddressLine3, @City, @County, @PostCode, IDENT_CURRENT('Customer'))

		print 'You have successfully added the customer'
		commit tran 
		return 0
	end try

	begin catch
		Select
		ERROR_NUMBER() as ErrorNumber,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage;
		
		print 'PROBLEM! Rolling Back the Tran'
		rollback tran
		return -1
	end catch
end
go
/* TESTING 

--SUCCESSFUL		
exec uspNewCustomer
@FirstName='Tilly',
@SurName='Tester',
@Active = 'Y',
@PhoneNumber= '0987352436',
@SecondPhoneNo= '0764534278',
@Email='TillyTeser@email.com',
@Address='Test House',
@AddressLine2 ='Testing Ave',
@AddressLine3 ='Apt 1',
@city = 'Dublin',
@county= 'Dublin',
@PostCode ='A12B3C4'

--SUCCESSFUL WITH DEFAULTS
exec uspNewCustomer
@FirstName='Tamar',
@SurName='Tester',
@PhoneNumber= '0987352436',
@Email='TTeser@email.com',
@Address='Test House',
@city = 'Dublin',
@county= 'Dublin',
@PostCode ='A12B3C4'


--Invalid email (no @)
exec uspNewCustomer
@FirstName='Tamar',
@SurName='Tester',
@PhoneNumber= '0987352436',
@Email='TTeseremail.com',
@Address='Test House',
@city = 'Dublin',
@county= 'Dublin',
@PostCode ='A12B3C4'

--Inalid email (includes space)
exec uspNewCustomer
@FirstName='Tamar',
@SurName='Tester',
@PhoneNumber= '0987352436',
@Email='TTeser email.com',
@Address='Test House',
@city = 'Dublin',
@county= 'Dublin',
@PostCode ='A12B3C4'

--Invalid postcode
exec uspNewCustomer
@FirstName='Tamar',
@SurName='Tester',
@PhoneNumber= '0987352436',
@Email='TTeser@email.com',
@Address='Test House',
@city = 'Dublin',
@county= 'Dublin',
@PostCode ='A12B3C'

*/