
Create Table Employee(
EmpID Int IDENTITY(100,1) NOT NULL,
PPSNumber varchar(9) NOT NULL CONSTRAINT [The PPS Number must be at least 8 characters.] CHECK (Len(PPSNumber) >= 8),
EmpFirstName varchar(50) NOT NULL,
EmpSurName varchar(50) NOT NULL,
EmpDOB Date NOT NULL CONSTRAINT [The employee must be at least 14 years old.] CHECK (datediff(year, EmpDOB,getdate()) >= 14),
HireDate Date NOT NULL DEFAULT (GetDate()),
PRIMARY KEY (EmpID)
);

Create Table EmergencyContact(
ContactID Int IDENTITY(100,1) NOT NULL,
ContactFirstName varchar(50) NOT NULL,
ContactSurName varchar(50) NOT NULL,
ContactNumber varchar(25) NOT NULL,
EmpID int NOT NULL,
PRIMARY KEY (ContactID)
);

Create table Qualification(
QualID Int IDENTITY(100,1) NOT NULL,
QualName varchar(100) NOT NULL,
QualType varchar(50) NOT NULL,
DateObtained Date NOT NULL CONSTRAINT [The date obtained must be before today.] CHECK (datediff(year, DateObtained, getdate()) >= 0),
AwardingBody varchar(100) NOT NULL,
EmpID int NOT NULL,
PRIMARY KEY (QualID)
);

Create Table Title(
JobTitle varchar(50) NOT NULL,
Position varchar(50) NOT NULL DEFAULT 'Junior',
MinQual varchar(50) NULL,
DepartmentNumber int NOT NULL,
PRIMARY KEY (JobTitle)
);

Create Table EmployeeTitle(
JobTitle varchar(50) NOT NULL,
EmpID Int NOT NULL,
TStartDate Date NOT NULL DEFAULT (GetDate()),
TEndDate Date NULL,
PRIMARY KEY (JobTitle, EmpID)
);

Create Table Department(
DepartmentNumber int IDENTITY(1,1) NOT NULL,
DepartmentName varchar(50) NOT NULL,
DepartmentPhone varchar(6) NOT NULL UNIQUE,
PRIMARY KEY (DepartmentNumber)
);

Create Table Customer(
CustomerID int IDENTITY(1,1) NOT NULL,
CFirstName varchar(50) NOT NULL,
CSurName varchar(50) NOT NULL,
Active varchar(1) NOT NULL CONSTRAINT [Active must be Y/N] CHECK (active = 'y' or active = 'n' or active = '') DEFAULT 'y',
PRIMARY KEY (CustomerID)
);

Create Table Address(
AddressID int IDENTITY (500,1) NOT NULL,
AddressLine1 varchar(100) NOT NULL,
AddressLine2 varchar(50) NULL,
AddressLine3 varchar(50) NULL,
City varchar(30) NOT NULL,
County varchar(12) NOT NULL,
PostCode varchar(7) NOT NULL, 
CustomerID int NULL,
EmpID int NULL,
PRIMARY KEY (AddressID), 
CONSTRAINT [Address must be connected to only either employee or customer] CHECK ((CustomerID is NULL AND EmpID is NOT NULL) OR (CustomerID is NOT NULL AND EmpID is NULL)) 
);


Create Table Contact(
ContactID Int IDENTITY(500,1) NOT NULL,
PrimaryPhone varchar(25) NOT NULL,
SecondPhone varchar(25) NULL,
Email varchar(100) NOT NULL CONSTRAINT [Invalid email address.] CHECK((Email LIKE '%@%') AND (Email NOT LIKE '% %')),
CustomerID int NULL,
EmpID int NULL,
PRIMARY KEY (ContactID),
CONSTRAINT [Contact must be connected to only either employee or customer] CHECK ((CustomerID is NULL AND EmpID is NOT NULL) OR (CustomerID is NOT NULL AND EmpID is NULL)) 
);

Create Table Invoice(
InvoiceNumber Int IDENTITY(1,1) NOT NULL,
DateBilled DateTime NOT NULL DEFAULT Getdate(),
Total numeric(8,2) NOT NULL CONSTRAINT [The total must be greater than 0] CHECK (total > 0),
Paid varchar(1) NOT NULL CONSTRAINT [Paid must indicate Y/N] CHECK (Paid = 'y' or Paid = 'n'),
SerialNum varchar(12) NOT NULL,
CustomerID int NOT NULL,
EmpID int NOT NULL,
PRIMARY KEY (InvoiceNumber)
);

Create Table Car(
SerialNum varchar(12) NOT NULL CONSTRAINT [The Serial Number must be 12 characters] CHECK (len(SerialNum) = 12),
Make varchar(50) NOT NULL,
Model varchar(50) NOT NULL,
CarYear date NOT NULL,
Transmission varchar(20) NOT NULL,
FuelType varchar(20) NOT NULL,
EngineSize numeric(4,2) NOT NULL CONSTRAINT [Engine size must be greater than 0] CHECK (EngineSize > 0),
PRIMARY KEY (SerialNum)
);

Create Table SalesStock(
StockID Int IDENTITY(1,1) NOT NULL,
CarValue numeric(8,2) NOT NULL CONSTRAINT [The car value must be greater than 0] CHECK (CarValue > 0),
Condition varchar(1) NOT NULL CONSTRAINT [Condition must be "U" if used, "N" if new.] CHECK (Condition = 'N' or Condition = 'U'),
ReadyForSale varchar(1) NOT NULL CONSTRAINT [ReadyForSale must be Y/N] CHECK (ReadyForSale = 'y' or ReadyForSale = 'n'),
Sold varchar(1) NOT NULL CONSTRAINT [Sold must be Y/N] CHECK (sold = 'y' or sold = 'n') DEFAULT 'n',
SerialNum varchar(12) NOT NULL,
PRIMARY KEY (StockID)
);

Create Table ServiceTicket(
TicketID int IDENTITY(1,1) NOT NULL,
DateStarted Datetime NOT NULL DEFAULT (GetDate()),
DateComplete DateTime NULL,
TicketType varchar(1) NOT NULL CONSTRAINT [Ticket Type must be "R" for repair, "S" for service.] CHECK (TicketType= 'r' or TicketType = 's'),
Comment Text NULL,
SerialNum varchar(12) NOT NULL,								
CustomerID int NULL,
EmpID int NOT NULL,
CONSTRAINT[The date complete must be after the date started] CHECK (Datediff(Day, DateComplete, DateStarted) <=0 ),
PRIMARY KEY (TicketID)
);

ALTER Table Qualification
Add Foreign Key (EmpID) References Employee(EmpID)

ALTER Table EmergencyContact
Add Foreign Key (EmpID) References Employee(EmpID)

ALTER Table Title
Add Foreign Key (DepartmentNumber) References Department(DepartmentNumber);

ALTER Table EmployeeTitle
Add Foreign Key (JobTitle) References Title(JobTitle),
	Foreign Key (EmpID) References Employee(EmpID);

ALTER Table Address
Add Foreign Key (CustomerID) References Customer(CustomerID),
	Foreign Key (EmpID) References Employee(EmpID);

Alter Table Contact
Add Foreign Key (CustomerID) References Customer(CustomerID),
	Foreign Key (EmpID) References Employee(EmpID);


ALTER Table Invoice
Add Foreign Key (SerialNum) References Car(SerialNum),
	Foreign Key (CustomerID) References Customer(CustomerID),
	Foreign Key (EmpID) References Employee(EmpID);

ALTER Table SalesStock
Add Foreign Key (SerialNum) References Car(SerialNum);


ALTER Table ServiceTicket
Add Foreign Key (SerialNum) References Car(SerialNum),
	Foreign Key (CustomerID) References Customer(CustomerID),
	Foreign Key (EmpID) References Employee(EmpID);