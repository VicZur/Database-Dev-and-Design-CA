Create View VW_MIEXTRACT
AS
Select TicketID, TicketType, DateStarted, DateComplete, Comment, 
Car.SerialNum AS [Serial Number], Make, Model, Year(CarYear) AS [Car Year], Transmission, FuelType, EngineSize, 
ServiceTicket.EmpID AS [Employee ID], EmpFirstName AS [Employee First Name], EmpSurName AS [Employee Surname], HireDate AS [Employee Hire Date], EmployeeTitle.JobTitle AS [Employee Title], CustomerID

from ServiceTicket
join Employee
on ServiceTicket.EmpID = Employee.EmpID
join EmployeeTitle
on Employee.EmpID = EmployeeTitle.EmpID
join Car
on ServiceTicket.SerialNum = car.SerialNum
where ((DateDiff(Month, DateComplete, GetDate()) <= 3) OR (DateDiff(Month, DateStarted, GetDate()) <=3)) and TEndDate is null;

/*TEndDate is null means the must be the Employees current title. Assume that a promotion (meaning they were possibly working under a 
lower title when completing the ticket) within the last 3 months is irrelevant

Assume further customer info is irrelevant for this particular purpose*/
go


select * from VW_MIEXTRACT