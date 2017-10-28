/*
BUDT 758Y Fall 2016 Homework #4 – SQL DDL

Repeat steps below for the Terps Tours, Inc. normalized relations and referential integrity actions listed on the last page of this document (not what you submitted for Homework #3).
1.	Compose SQL CREATE TABLE statements:
i.	Use corresponding table name.
ii.	Choose appropriate data type for each attribute.
iii.	Identify and name the PRIMARY KEY.
iv.	Identify and name each FOREIGN KEY if any.
2.	Compose SQL INSERT INTO statements:
i.	Insert at least one record into each table.
3.	Compose SQL DROP TABLE statements:
i.	Use the reversed order from CREATE TABLEs.




Terps Tours, Inc. ERD normalized relations:
•	Guide (guideId, lastName, firstName, street, city, state, zip, phone, hireDate)
•	Trip (tripId, tripName, startLocation, state, distance, maxSize, type, season)
•	Reservation (reservationId, tripId, tripDate, customerId, numPersons, price, otherFees)
•	Customer (customerId, lastName, firstName, street, city, state, zip, phone)
•	Tours (guideId, tripId)


Referential integrity constraints and actions:

Relation	| Foreign Key	| Base Relation | 	Primary Key | 	Constraint: ON DELETE	| Constraint: ON UPDATE
Reservation | 	tripId | Trip	| tripId	| NO ACTION	| NO ACTION
Reservation | 	customerId |	Customer	| customerId	| CASCADE	| CASCADE
Tours |	guideId |	Guide |	guideId |	NO ACTION	| CASCADE
Tours | tripId |	Trip	| tripId	| NO ACTION	| CASCADE

*/

USE BUDT758_DB_Student_008

DROP TABLE [Reservation]
DROP TABLE [Tours]

DROP TABLE [Customers]
DROP TABLE [Trip]

DROP TABLE [Guide]

CREATE TABLE [Guide] (
guideID CHAR (10) NOT NULL,
lastName VARCHAR (20),
FirstName CHAR (20),
street CHAR(20),
city CHAR(10),
state CHAR(10),
zip CHAR(10),
phone CHAR (20),
HireDate DATE,
CONSTRAINT pk_Guide_guideID PRIMARY KEY (guideID))
;

CREATE TABLE [Trip] (
tripID CHAR (10) NOT NULL,
tripName VARCHAR (20),
startLocation CHAR (10),
state CHAR(10),
Distance CHAR(10),
MaxSize Integer,
type CHAR(10),
season CHAR (20),
CONSTRAINT pk_Trip_tripID PRIMARY KEY (tripID));

CREATE TABLE [Customers] (
customerID VARCHAR (15) NOT NULL,
lastName VARCHAR (20),
FirstName VARCHAR (10),
street VARCHAR(20),
city VARCHAR(20),
state VARCHAR(20),
zip VARCHAR(20),
phone VARCHAR (20),
CONSTRAINT pk_Customers_customerID PRIMARY KEY (customerID));

CREATE TABLE [Reservation] (
reservationID CHAR (10) NOT NULL,
tripID CHAR (10),
tripDate DATE,
customerID VARCHAR(15) NOT NULL,
numPersons INTEGER,
price NUMERIC (6,2),
otherFees NUMERIC (6,2),
CONSTRAINT pk_Resevation_reservationID PRIMARY KEY (reservationID),
CONSTRAINT fk_Reservation_tripID FOREIGN KEY (tripID)
REFERENCES [Trip] (tripID)
ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Customers_customerID FOREIGN KEY (customerID)
REFERENCES [Customers] (customerID)
ON DELETE CASCADE ON UPDATE CASCADE

);
CREATE TABLE [Tours] (
guideID CHAR (10) NOT NULL,
tripID CHAR (10) NOT NULL,
CONSTRAINT pk_Tours_guideID_tripID PRIMARY KEY (guideID, tripID),
CONSTRAINT fk_Tours_guideID FOREIGN KEY (guideID)
REFERENCES [Guide](guideID)
ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Tours_tripID FOREIGN KEY (tripID)
REFERENCES [Trip](TripID)
ON DELETE NO ACTION ON UPDATE CASCADE

);

INSERT INTO [Guide] VALUES
('123456789', 'Mane', 'Gucci', '1355 S Hines Blvd', 'Chicago', 'Illinois', '20740', '301-234-2345', '07/20/2016');

INSERT INTO [Trip] VALUES
('9876543210', 'Gucci Store', 'Chicago', 'Illinois', '7 Miles', '20', 'Jog', 'Spring');


INSERT INTO [Customers] VALUES
('1122334455', 'Impressions', 'Beauty', '5585 Westcott Ct','Sacramento', 'California', '4056', '240-456-3456');

INSERT INTO [Reservation] Values
('12345645', '9876543210', '5/23/2016', '1122334455', '4', '150.00', '25.00');

INSERT [Tours] VALUES
('123456789', '9876543210');



