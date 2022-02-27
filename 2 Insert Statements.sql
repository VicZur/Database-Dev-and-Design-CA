Insert into Customer (CFirstName, CSurName, Active)
Values ('Anna', 'Adams', 'Y'),
	   ('Ben', 'Bear', 'Y'),
	   ('Carrie', 'Carver', 'Y'),
	   ('David', 'Dear', 'Y'),
	   ('Elaine', 'Edmond', 'Y'),
	   ('Frank', 'Fredrick', 'Y'),
	   ('Gemma', 'Goldsmith', 'Y'),
	   ('Henry', 'Hadd', 'Y'),
	   ('Isla', 'Irving', 'Y'),
	   ('John', 'Jacobs', 'Y');

Insert into Employee (PPSNumber, EmpFirstName, EmpSurName, EmpDOB, HireDate)
values ('1234567A', 'Zara', 'Zapp', '1990-01-01', '2021-05-20'),
	   ('7654321B', 'Yuri', 'Yick', '1985-02-02', '2021-05-22'),
	   ('7362847R', 'Xena', 'Xuan', '1994-03-03', '2018-05-01'),
	   ('3628471W', 'William', 'Wood', '1990-04-04', '2021-05-22'),
	   ('9284067Q', 'Victoria', 'Venne', '1990-05-05', '2020-12-1'),
	   ('2746251P', 'Udo', 'Under', '1985-06-06', '2015-01-01'),
	   ('9028365R', 'Tara', 'Thomas', '1987-07-07', '2017-05-05'),
	   ('3758392B', 'Simon', 'Smith', '1990-08-08', '2018-03-05'),
	   ('4738597W', 'Rebecca', 'Ryans', '1990-09-09', '2021-05-22'),
	   ('3829475Q', 'Peter', 'Pauls', '1989-10-10', '2020-08-03');

Insert into Address (AddressLine1, AddressLine2, AddressLine3, City, County, PostCode, CustomerID, EmpID)
values	('11 The Street', null, null, 'Dublin', 'Dublin', 'F38Y1J2', 1, null),
		('22 The House', 'Fancy Name House', 'Lake Street', 'Galway', 'Galway', 'S72U6D8', 2, null),
		('Apartment 33 The Building', 'Main Street', null, 'Westport', 'Mayo', 'P89W9B4', 3, null),
		('Apartment 33 The Building', 'Main Street', null, 'Westport', 'Mayo', 'P89W9B4', 4, null),
		('Apartment 44 Big Tower', 'Lake Road', null, 'Dublin', 'Dublin', 'F38K9S2', 5, null),
		('55 Park Road', null, null, 'Cork', 'Cork', 'K94B9J4', 6, null),
		('55 Park Road', null, null, 'Cork', 'Cork', 'K94B9J4', 7, null),
		('55 Park Road', null, null, 'Cork', 'Cork', 'K94B9J4', 8, null),
		('Apartment 6 Square Apartment', 'Main Street', null, 'Galway', 'Galway', 'S72U8D3', 1, null),
		('282 Small Hill Road', null, null, 'Port Laoise', 'Laoise', 'R30L2X4', 9, null),
		('2948 Little Lake Street', null, null, 'Castlebar', 'Mayo', 'J37S6J9', 10, null),
		('70 Big Hill Road', null, null, 'Dun Laoghaire', 'Dublin', 'H78S2G3', null, 100),
		('70 Big Hill Road', null, null, 'Dun Laoghaire', 'Dublin', 'H78S2G3', null, 101),
		('70 Big Hill Road', null, null, 'Dun Laoghaire', 'Dublin', 'H78S2G3', null, 102),
		('Apartment 8 Historic House', 'Old Road', null, 'Dublin', 'Dublin', 'S12M4E9', null, 103),
		('928 River View Lane', null, null, 'Dublin', 'Dublin', 'J93I8Y2', null, 104),
		('928 River View Lane', null, null, 'Dublin', 'Dublin', 'J93I8Y2', null, 105),
		('928 River View Lane', null, null, 'Dublin', 'Dublin', 'J93I8Y2', null, 106),
		('Apartment 1290 The Shops', 'Shop Street', null, 'Galway', 'Galway', 'P4IM6N7', null, 107),
		('28 Crescent Moon Road', null, null, 'Howth', 'Dublin', 'Z83Q1L8', null, 108),
		('300 Old Church Street', null, null, 'Dublin', 'Dublin', 'K2D5V0T', null, 109);

Insert into Car (SerialNum, Make, Model, CarYear, Transmission, FuelType, EngineSize)
Values	('1FADP3K21DL2', 'Ford', 'Focus', '2020', 'Manual', 'Petrol', 1.8),
		('1GNKRGKD1EJ2', 'Kia', 'Rio', '2019', 'Automatic', 'Petrol', 2.0),
		('KL4CJASB9EB6', 'Chevrolet', 'Tracker', '2010', 'Manual', 'Petrol', 1.8),
		('4S4BRBLC0E32', 'Tesla', 'Model 3', '2012', 'Manual', 'Electric', 1.6),
		('2LMDJ6JK8BBJ', 'BMW', '740I', '2018', 'Automatic', 'Petrol', 2.0),
		('1FM5K8F87EGA', 'Toyota', 'Avanza', '2021', 'Manual', 'Diesel', 1.6),
		('3GNBABDB8AS5', 'Honda', 'CRF', '2021', 'Manual', 'Petrol', 1.2),
		('JN1RZ24D4TX6', 'Ford', 'Fiesta', '2021', 'Automatic', 'Petrol', 1.2),
		('1FUY3LYB6PP4', 'BMW', 'X3', '2021', 'Manual', 'Petrol', 2.0),
		('1GC0KXCG5DF2', 'Kia', 'Sorento', '2016', 'Manual', 'Petrol', 1.4),
    	('2HMBF22F1PB0', 'Hyundai', 'Sonata', '2015', 'Manual', 'Petrol', 1.4),
		('5TFBV54107X0', 'Toyota', 'Tundra', '2021', 'Automatic', 'Diesel', 2.2),
		('4S4BRCFC8B34', 'Subaru', 'Outback', '2010', 'Manual', 'Petrol', 1.8),
		('5TDKK3DC1DS3', 'Toyota', 'Sienna', '2014', 'Manual', 'Petrol', 1.8),
		('KMHSC72E0600', 'Hyundai', 'Santa Fe', '2018', 'Manual', 'Petrol', 2.0),
		('KNDPCCA27C73', 'Kia', 'Sportage', '2012', 'Manual', 'Petrol', 1.6);
		

Insert into Department (DepartmentName, DepartmentPhone)
Values	('Sales', '+135'),
		('Marketing', '+124'),
		('Finance', '+145'),
		('Accounting', '+159'),
		('Human Resources', '+137'),
		('Mechanical Service', '+198');

Insert into EmergencyContact (ContactFirstName, ContactSurName, ContactNumber, EmpID)
values	('Aaron', 'Andrews', '0837465729', 100),
		('Brenda', 'Bailey', '0857351038', 101),
		('Charlie', 'Chain', '0873928465', 102),
		('Donna', 'Durns', '+4483927494', 103),
		('Edward', 'Erinson', '0850394857', 104),
		('Freya', 'Fondue', '0897263069', 105),
		('George', 'Greggs', '0847283049', 106),
		('Hallie', 'Harper', '0830858593', 107),
		('Ivor', 'Imonson', '0810293948', 108),
		('Jackie', 'James', '0948392013', 109);

Insert into Title (JobTitle, Position, MinQual, DepartmentNumber)
values	('Sales Person', 'Junior', null, 1),
		('Sales Supervisor', 'Senior', null, 1),
		('Sales Manager', 'Management', 'QQI Level 7', 1),
		('Marketing Assistant', 'Junior', null, 2),
		('Marketing Team Leader', 'Senior', 'QQI Level 5', 2),
		('Marketing Manager', 'Management', 'QQI Level 7', 2),
		('Internal Auditor', 'Senior', 'QQI Level 7', 3),
		('Finance Manager', 'Management', 'QQI Level 7', 3),
		('Insurance Specialist', 'Senior', 'QQI Level 7', 3),
		('Tax Accountant', 'Junior', 'QQI Level 7', 4),
		('Financial Accountant', 'Junior', 'QQI Level 7', 4),
		('Accounts Manager', 'Management', 'QQI Level 7', 4),
		('HR Director', 'Management', 'QQI Level 7', 5),
		('HR Specialist', 'Senior', 'QQI Level 5', 5),
		('HR Assistant', 'Junior', NULL, 5),
		('Auto Technician', 'Junior', 'Apprentice', 6),
		('Auto Mechanic', 'Junior', 'Apprentice', 6),
		('Auto Specialist', 'Senior', 'QQI Level 6', 6),
		('Automotive Manager', 'Management', 'QQI Level 6', 6);


Insert into EmployeeTitle (JobTitle, EmpID, TStartDate, TEndDate)
Values	('Sales Person', 105, '2015-01-01', '2017-02-02'),
		('Sales Supervisor', 105, '2017-02-03', '2020-03-03'),
		('Sales Manager', 105, '2020-03-04', null),
		('Auto Mechanic', 106, '2017-05-05', '2019-06-06'),
		('Auto Specialist', 106, '2019-06-07', null),
		('Automotive Manager', 100, '2021-05-20', null),
		('Accounts Manager', 101, '2021-05-22', null),
		('Auto Technician', 102, '2018-05-01', '2020-01-01'),
		('Auto Specialist', 102, '2020-01-02', null),
		('Auto Mechanic', 103, '2021-05-22', null),
		('HR Director', 104, '2020-12-01', null),
		('Sales Person', 107, '2018-03-05', null),
		('Auto Specialist', 108, '2021-05-22', null),
		('Auto Mechanic', 109, '2020-08-03', null);

Insert into Invoice (DateBilled, Total, Paid, SerialNum, CustomerID, EmpID)
values	('2021-01-01', 21000.95, 'Y', '1FADP3K21DL2', 1, 105),
		('2020-02-02', 12000.15, 'Y', '1GC0KXCG5DF2', 2, 107),
		('2015-03-03', 5000.80, 'Y', 'KL4CJASB9EB6', 3, 105),
		('2018-04-04', 7000.90, 'Y', '4S4BRBLC0E32', 4, 105),
		('2021-05-22', 30000.55, 'N', '3GNBABDB8AS5', 5, 107),
		('2021-01-20', 45000.20, 'Y', '1GNKRGKD1EJ2', 6, 107),
		('2021-01-15', 22000.35, 'Y', '1FUY3LYB6PP4', 7, 105),
		('2021-01-10', 30000.00, 'Y', '1FM5K8F87EGA', 8, 105),
		('2018-02-15', 15000.50, 'Y', 'JN1RZ24D4TX6', 1, 107);

insert into Qualification (QualName, QualType, DateObtained, AwardingBody, EmpID)
Values	('Bachelor in Business Administration - Finance and Accounting', 'QQI Level 8', '2008', 'QQI', 101),
		('Diploma in Vehicle Technology', 'QQI Level 6', '2019', 'QQI', 102),
		('Automotive Apprentice', 'Apprentice', '2017-01-01', 'SOLAS', 102),
		('Automotive Apprentice', 'Apprentice', '2021-01-01', 'SOLAS', 103),
		('Diploma in Vehicle Technology', 'QQI Level 6', '2010', 'QQI', 100),
		('Bachelor in Business Administration - Human Resources', 'QQI Level 8', '2008', 'QQI', 104),
		('Bachelor in Business Administration - Sales', 'QQI Level 8', '2014', 'QQI', 105),
		('Automotive Apprentice', 'Apprentice', '2017-01-01', 'SOLAS', 106),
		('Diploma in Vehicle Technology', 'QQI Level 6', '2019', 'QQI', 106),
		('Bachelor in Business Administration - Sales', 'QQI Level 8', '2017', 'QQI', 107),
		('Diploma in Vehicle Technology', 'QQI Level 6', '2020', 'QQI', 108),
		('Automotive Apprentice', 'Apprentice', '2020-01-01', 'SOLAS', 109);

Insert into SalesStock (CarValue, Condition, ReadyForSale, Sold, SerialNum)
Values	(18000, 'N', 'Y', 'Y', '1FADP3K21DL2'),
		(10000, 'U', 'Y', 'Y', '1GC0KXCG5DF2'),
		(3300, 'U', 'Y', 'Y', 'KL4CJASB9EB6'),
		(5500, 'U', 'Y', 'Y', '4S4BRBLC0E32'),
		(25000, 'N', 'Y', 'Y', '3GNBABDB8AS5'),
		(40000, 'N', 'Y', 'Y', '1GNKRGKD1EJ2'),
		(20000, 'N', 'Y', 'Y', '1FUY3LYB6PP4'),
		(27000, 'N', 'Y', 'Y', '1FM5K8F87EGA'),
		(10000, 'N', 'Y', 'Y', 'JN1RZ24D4TX6'),
		(20000, 'U', 'Y', 'N', '2LMDJ6JK8BBJ');


Insert into ServiceTicket (DateStarted, DateComplete, TicketType, Comment, SerialNum, CustomerID, EmpID)
Values	('2020-04-05', '2020-04-07', 'R', 'Engine repair', '2HMBF22F1PB0', 10,102),
		('2021-01-07', '2021-01-07', 'S', null, '5TFBV54107X0', 9, 109),		
		('2018-01-01', '2018-01-01', 'S', null, '4S4BRCFC8B34', 1, 103),
		('2020-12-20', '2020-12-22', 'R', 'Body work. Front drivers side replaced.', '5TDKK3DC1DS3', 2, 106),
		('2021-05-05', '2021-05-05', 'S', null, 'KMHSC72E0600', 5, 108),
		('2021-05-10', null, 'R', 'Brakes/Tyres','KNDPCCA27C73', 9, 109),
		('2019-02-02', '2019-02-02', 'S', null, 'KL4CJASB9EB6', 2, 103),
		('2021-03-02', '2021-03-02', 'S', null, '1FM5K8F87EGA', 8, 106),
		('2021-02-11', '2021-02-11', 'S', null, '3GNBABDB8AS5', 5, 102),
		('2020-04-03', '2020-04-03', 'S', null, '1GC0KXCG5DF2', 2, 108);
		
Insert into Contact (PrimaryPhone, SecondPhone, Email, CustomerID, EmpID)
Values	('0837584932', null, 'zarazapp@email.com', null, 100),
		('0856375892', null, 'yuriyick@emial.com', null, 101),
		('0878273619', '0982746389', 'xenaxuan@mail.com', null, 102),
		('0838273648', '0829384726', 'wwood@mail.com', null, 103),
		('0878270098', null, 'vicvenne@mail.com', null, 104),
		('0839284759', null, 'udounder@email.com', null, 105),
		('0879093321', '0883726483', 'tarat@email.com', null, 106),
		('0890394827', null, 'simonsmith@mail.com', null, 107),
		('0892837465', null, 'rryans@mail.com', null, 108),
		('0768473820', null, 'peterpauls@mail.com', null, 109),
		('+4495837261', '04738259274', 'annaadams@mail.com', 1, null),
		('0879403928', '08992716345', 'benb@email.com', 2, null),
		('0830948272', '08352263765', 'carriecarver@mail.com', 3, null),
		('0983746283', null, 'ddear@email.com', 4, null),
		('0856372840', null, 'elaineed@email.com', 5, null),
		('0877366559', '09989384744', 'frankfred@mail.com', 6, null),
		('0328472844', '08567438293', 'gemmagold@email.com', 7, null),
		('0976253472', '03284756377', 'henryhadd@mail.com', 8, null),
		('0888374663', null, 'islairving@email.com', 9, null),
		('0937465839', null, 'johnj@email.com', 10, null);
