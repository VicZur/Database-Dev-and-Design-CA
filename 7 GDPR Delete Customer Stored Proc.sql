create proc uspDeleteCustomer
@CustomerID int,
@CustomerFirstName varchar(50)

AS

if @CustomerID is null
begin
	print 'Cannot delete, must input Customer ID'
	return -1
end

else if (
select CustomerID from Customer
where CustomerID = @CustomerID) is null
begin
	print 'Customer ID cannot be found'
	return -1
end


else if @CustomerFirstName is null
begin
	print 'Cannot delete, must input Customer First Name for validation reasons'
	return -1
end

else if (
select CFirstName from Customer
where CustomerID = @CustomerID) != @CustomerFirstName
begin
	print 'The customerID and customer first name do not match a customer'
	return -1
end

else
begin

begin tran
begin try
	
	Update Customer
	Set CFirstName = '',
		CSurName = '',
		Active = 'N'
	where CustomerID = @CustomerID

	Update Address
	Set AddressLine1 = '',
		AddressLine2 = '',
		AddressLine3 = '',
		City = '',
		County = '',
		PostCode = ''
	Where CustomerID = @CustomerID

	Update Contact
	Set PrimaryPhone = '',
		SecondPhone = '',
		Email = '@'
	Where CustomerID = @CustomerID

	print 'The customer has successfully been deleted'
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
	END CATCH

end
go

/* TESTING

--view data before update(aka 'delete')
select Customer.CustomerID, Customer.CFirstName, Address.AddressLine1, AddressLine2, AddressLine3, City, County, Postcode, Address.EmpID, PrimaryPhone, SecondPhone, Contact.Email
from Customer
inner join Address
ON Customer.CustomerID = Address.CustomerID
inner join Contact
on Customer.CustomerID = Contact.CustomerID


--successful update test, as correlates to TEST PLAN
exec uspDeleteCustomer
@CustomerID = 1,
@CustomerFirstName = 'Anna'

--check to ensure working
select Customer.CustomerID, Customer.CFirstName, Address.AddressLine1, AddressLine2, AddressLine3, City, County, Postcode, Address.EmpID, PrimaryPhone, SecondPhone, Contact.Email
from Customer
inner join Address
ON Customer.CustomerID = Address.CustomerID
inner join Contact
on Customer.CustomerID = Contact.CustomerID


--error test customerID not found
exec uspDeleteCustomer
@CustomerId = 100,
@CustomerFirstName = 'Anna'

--Error test no ID given
exec uspDeleteCustomer
@customerID = null,
@customerFirstName = 'Anna'


--Error test no name given
exec uspDeleteCustomer
@customerID = 2,
@customerFirstName = null

--Error test ID and name do not match
exec uspDeleteCustomer
@customerID = 3,
@CustomerFirstName = 'Ben'
*/
