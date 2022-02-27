create proc uspUpdateActiveCustomers

AS

-- Set Customer.Active to N if the [(date of the last sales invoice OR serviceticket was more than one year ago) OR (Customer has no service ticket AND no invoice)]
Update Customer
set Customer.Active = 'N'

where ((((CustomerID in (
	select invoice.CustomerID
	from Invoice
	inner join Customer
	on Invoice.CustomerID = Customer.CustomerID 
	where
	(datediff(month, Invoice.DateBilled, getdate()) > 13)))
	OR
	(CustomerID in (
	select ServiceTicket.CustomerID
	from ServiceTicket
	inner join Customer
	on ServiceTicket.CustomerID = Customer.CustomerID 
	where
	(datediff(month, ServiceTicket.DateStarted, getdate()) > 13))))
    OR
	((CustomerID NOT in (
	select invoice.CustomerID
	from Invoice
	inner join Customer
	on Invoice.CustomerID = Customer.CustomerID))
	AND
	(CustomerID NOT in (
	select ServiceTicket.CustomerID
	from ServiceTicket
	inner join Customer
	on ServiceTicket.CustomerID = Customer.CustomerID)))))--))

-- Set Active to Y if Last invoice OR last ticket was within 13 months
Update Customer
set Active = 'Y'
where (((CustomerID in (
	select Invoice.CustomerID
	from Invoice
	inner join Customer
	on Invoice.CustomerID = Customer.CustomerID 
	where
	(datediff(month, Invoice.DateBilled, getdate()) <= 13)))
	OR
	(CustomerID in 
	(select ServiceTicket.CustomerID
	from ServiceTicket
	inner join Customer
	on ServiceTicket.CustomerID = Customer.CustomerID 
	where
	(datediff(month, ServiceTicket.DateStarted, getdate()) <= 13)))))

--Set to null if the customer has been deleted (updated to have '' in all fields) - could potentially still be linked by ID number to recent ticket (as seen as CustomerID 1 after following all steps of project)	
update Customer 
set Active = 'N'
where ((CFirstName in (
		Select Customer.CFirstName
		from Customer
		Where
		(Customer.CFirstName LIKE '')))
		AND
		(CSurName in (
		Select Customer.CSurName
		from customer
		where
		(Customer.CSurName LIKE ''))))
go
	 
exec uspUpdateActiveCustomers

Select * from Customer

