Create View VW_INACTIVECUSTOMERS
AS

SELECT customer.CustomerID, CFirstName AS [Customer First Name], CSurName AS [Customer Surname], Invoice.DateBilled [Last Invoice], ServiceTicket.DateComplete [Last Service Ticket], AddressLine1, AddressLine2, AddressLine3, City, County, PostCode, PrimaryPhone, SecondPhone, Email
from customer
left join ServiceTicket
on Customer.CustomerID = ServiceTicket.CustomerID
left join Invoice
on Customer.CustomerID = Invoice.CustomerID
join address
on Customer.CustomerID = Address.CustomerID
join contact
on Customer.CustomerID = Contact.CustomerID
where (active = 'n') AND (CFirstName NOT LIKE '') AND (CSurName NOT LIKE '')
go

select * from VW_INACTIVECUSTOMERS





