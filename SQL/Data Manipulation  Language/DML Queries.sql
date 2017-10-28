DROP TABLE [TerpsTours.Reservation];
DROP TABLE [TerpsTours.Customer];
DROP TABLE [TerpsTours.Tours];
DROP TABLE [TerpsTours.Trip];
DROP TABLE [TerpsTours.Guide];

/*2.	SQL create tables:*/
CREATE TABLE [TerpsTours.Guide] (
	guideId	CHAR (4) NOT NULL,
	lastName	VARCHAR (10),
	firstName	VARCHAR (10),
	street	VARCHAR (20),
	city	VARCHAR (15),
	state	CHAR (2),
	zip	CHAR (5),
	phone	CHAR (12),
	hireDate	DATE,
	CONSTRAINT pk_Guide_guideId PRIMARY KEY (guideId) );
CREATE TABLE [TerpsTours.Trip] (
	tripId	INTEGER NOT NULL,
	tripName	VARCHAR (40),
	startLocation	VARCHAR (20),
	state	CHAR (2),
	distance	INTEGER,
	maxSize	INTEGER,
	type	VARCHAR (10),
	season	VARCHAR (15),
	CONSTRAINT pk_Trip_tripId PRIMARY KEY (tripId) );
CREATE TABLE [TerpsTours.Tours] (
	tripId	INTEGER NOT NULL,
	guideId	CHAR (4) NOT NULL,
	CONSTRAINT pk_Tours_tripId_guideId PRIMARY KEY (tripId,guideId),
	CONSTRAINT fk_Tours_tripId FOREIGN KEY (tripId)
		REFERENCES [TerpsTours.Trip] (tripId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_Tours_guideId FOREIGN KEY (guideId)
		REFERENCES [TerpsTours.Guide] (guideId)
		ON DELETE NO ACTION ON UPDATE CASCADE );
CREATE TABLE [TerpsTours.Customer] (
	customerId	CHAR (3) NOT NULL,
	lastName	VARCHAR (15),
	firstName	VARCHAR (15),
	street	VARCHAR (20),
	city	VARCHAR (15),
	state	CHAR (2),
	zip	CHAR (5),
	phone	CHAR (12),
	CONSTRAINT pk_Customer_customerId PRIMARY KEY (customerId) );
CREATE TABLE [TerpsTours.Reservation] (
	reservationId	CHAR (7) NOT NULL,
	tripId	INTEGER,
	tripDate	DATE,
	numPersons	INTEGER,
	price	MONEY,
	otherFees	MONEY,
	customerId	CHAR (3),
	CONSTRAINT pk_Reservation_reservationId PRIMARY KEY (reservationId),
	CONSTRAINT fk_Reservation_tripId FOREIGN KEY (tripId)
		REFERENCES [TerpsTours.Trip] (tripId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Reservation_customerId FOREIGN KEY (customerId)
		REFERENCES [TerpsTours.Customer] (customerId)
		ON DELETE CASCADE ON UPDATE CASCADE );

/*3.	SQL clear tables:*/
DELETE FROM [TerpsTours.Reservation];
DELETE FROM [TerpsTours.Customer];
DELETE FROM [TerpsTours.Tours];
DELETE FROM [TerpsTours.Trip];
DELETE FROM [TerpsTours.Guide];

/*4.	SQL insert data:*/
INSERT INTO [TerpsTours.Guide] VALUES
	('AM01','Abrams','Miles','54 Quest Ave.','Williamsburg','MA','01096','617-555-6032','6/3/2012'),
	('BR01','Boyers','Rita','140 Oakton Rd.','Jaffrey','NH','03452','603-555-2134','3/4/2012'),
	('DH01','Devon','Harley','25 Old Ranch Rd.','Sunderland','MA','01375','781-555-7767','1/8/2012'),
	('GZ01','Gregory','Zach','7 Moose Head Rd.','Dummer','NH','03588','603-555-8765','11/4/2012'),
	('KS01','Kiley','Susan','943 Oakton Rd.','Jaffrey','NH','03452','603-555-1230','4/8/2013'),
	('KS02','Kelly','Sam','9 Congaree Ave.','Fraconia','NH','03580','603-555-0003','6/10/2013'),
	('MR01','Marston','Ray','24 Shenandoah Rd.','Springfield','MA','01101','781-555-2323','9/14/2015'),
	('RH01','Rowan','Hal','12 Heather Rd.','Mount Desert','ME','04660','207-555-9009','6/2/2014'),
	('SL01','Stevens','Lori','15 Riverton Rd.','Coventry','VT','05825','802-555-3339','9/5/2014'),
	('UG01','Unser','Glory','342 Pineview St.','Danbury','CT','06810','203-555-8534','2/2/2015');
INSERT INTO [TerpsTours.Trip] VALUES
	(1,'Arethusa Falls','Harts Location','NH',5,10,'Hiking','Summer'),
	(2,'Mt Ascutney – North Peak','Weathersfield','VT',5,6,'Hiking','Late Spring'),
	(3,'Mt Ascutney – West Peak','Weathersfield','VT',6,10,'Hiking','Early Fall'),
	(4,'Bradbury Mountain Ride','Lewiston-Auburn','ME',25,8,'Biking','Early Fall'),
	(5,'Baldpate Mountain','North Newry','ME',6,10,'Hiking','Late Spring'),
	(6,'Blueberry Mountain','Batchelders Grant','ME',8,8,'Hiking','Early Fall'),
	(7,'Bloomfield - Maidstone','Bloomfield','CT',10,6,'Paddling','Late Spring'),
	(8,'Black Pond','Lincoln','NH',8,12,'Hiking','Summer'),
	(9,'Big Rock Cave','Tamworth','NH',6,10,'Hiking','Summer'),
	(10,'Mt. Cardigan - Firescrew','Orange','NH',7,8,'Hiking','Summer'),
	(11,'Chocorua Lake Tour','Tamworth','NH',12,15,'Paddling','Summer'),
	(12,'Cadillac Mountain Ride','Bar Harbor','ME',8,16,'Biking','Early Fall'),
	(13,'Cadillac Mountain','Bar Harbor','ME',7,8,'Hiking','Late Spring'),
	(14,'Cannon Mtn','Franconia','NH',6,6,'Hiking','Early Fall'),
	(15,'Crawford Path Presidentials Hike','Crawford Notch','NH',16,4,'Hiking','Summer'),
	(16,'Cherry Pond','Whitefield','NH',6,16,'Hiking','Spring'),
	(17,'Huguenot Head Hike','Bar Harbor','ME',5,10,'Hiking','Early Fall'),
	(18,'Low Bald Spot Hike','Pinkam Notch','NH',8,6,'Hiking','Early Fall'),
	(19,'Mason''s Farm','North Stratford','CT',12,7,'Paddling','Late Spring'),
	(20,'Lake Mephremagog Tour','Newport','VT',8,15,'Paddling','Late Spring'),
	(21,'Long Pond','Rutland','MA',8,12,'Hiking','Summer'),
	(22,'Long Pond Tour','Greenville','ME',12,10,'Paddling','Summer'),
	(23,'Lower Pond Tour','Poland','ME',8,15,'Paddling','Late Spring'),
	(24,'Mt Adams','Randolph','NH',9,6,'Hiking','Summer'),
	(25,'Mount Battie Ride','Camden','ME',20,8,'Biking','Early Fall'),
	(26,'Mount Cardigan Hike','Cardigan','NH',4,16,'Hiking','Late Fall'),
	(27,'Mt. Chocorua','Albany','NH',6,10,'Hiking','Spring'),
	(28,'Mount Garfield Hike','Woodstock','NH',5,10,'Hiking','Early Fall'),
	(29,'Metacomet-Monadnock Trail Hike','Pelham','MA',10,12,'Hiking','Late Spring'),
	(30,'McLennan Reservation Hike','Tyringham','MA',6,16,'Hiking','Summer'),
	(31,'Missisquoi River - VT','Lowell','VT',12,10,'Paddling','Summer'),
	(32,'Northern Forest Canoe Trail','Stark','NH',15,10,'Paddling','Summer'),
	(33,'Park Loop Ride','Mount Desert Island','ME',27,8,'Biking','Late Spring'),
	(34,'Pontook Reservoir Tour','Dummer','NH',15,14,'Paddling','Late Spring'),
	(35,'Pisgah STATE Park Ride','Northborough','NH',12,10,'Biking','Summer'),
	(36,'Pondicherry Trail Ride','White Mountains','NH',15,16,'Biking','Late Spring'),
	(37,'Seal Beach Harbor','Bar Harbor','ME',5,16,'Hiking','Early Spring'),
	(38,'Sawyer River Ride','Mount Carrigain','NH',10,18,'Biking','Early Fall'),
	(39,'Welch and Dickey Mountains Hike','Thorton','NH',5,10,'Hiking','Summer'),
	(40,'Wachusett Mountain','Princeton','MA',8,8,'Hiking','Early Spring'),
	(41,'Westfield River Loop','Fort Fairfield','ME',20,10,'Biking','Late Spring');
INSERT INTO [TerpsTours.Tours] VALUES
	(1,'GZ01'),
	(1,'RH01'),
	(2,'AM01'),
	(2,'SL01'),
	(3,'SL01'),
	(4,'BR01'),
	(4,'GZ01'),
	(5,'KS01'),
	(5,'UG01'),
	(6,'RH01'),
	(7,'SL01'),
	(8,'BR01'),
	(9,'BR01'),
	(10,'GZ01'),
	(11,'DH01'),
	(11,'KS01'),
	(11,'UG01'),
	(12,'BR01'),
	(13,'RH01'),
	(14,'KS02'),
	(15,'GZ01'),
	(16,'KS02'),
	(17,'RH01'),
	(18,'KS02'),
	(19,'DH01'),
	(20,'SL01'),
	(21,'AM01'),
	(22,'UG01'),
	(23,'DH01'),
	(23,'SL01'),
	(24,'BR01'),
	(25,'BR01'),
	(26,'GZ01'),
	(27,'GZ01'),
	(28,'BR01'),
	(29,'DH01'),
	(30,'AM01'),
	(31,'SL01'),
	(32,'KS01'),
	(33,'UG01'),
	(34,'KS01'),
	(35,'GZ01'),
	(36,'KS02'),
	(37,'RH01'),
	(38,'KS02'),
	(39,'BR01'),
	(40,'DH01'), 
	(41,'BR01');
INSERT INTO [TerpsTours.Customer] VALUES
	('101','Northfold','Liam','9 Old Mill Rd.','Londonderry','NH','03053','603-555-7563'),
	('102','Ocean','Arnold','2332 South St. Apt 3','Springfield','MA','01101','413-555-3212'),
	('103','Kasuma','Sujata','132 Main St. #1','East Hartford','CT','06108','860-555-0703'),
	('104','Goff','Ryan','164A South Bend Rd.','Lowell','MA','01854','781-555-8423'),
	('105','McLean','Kyle','345 Lower Ave.','Wolcott','NY','14590','585-555-5321'),
	('106','Morontoia','Joseph','156 Scholar St.','Johnston','RI','02919','401-555-4848'),
	('107','Marchand','Quinn','76 Cross Rd.','Bath','NH','03740','603-555-0456'),
	('108','Rulf','Uschi','32 Sheep Stop St.','Edinboro','PA','16412','814-555-5521'),
	('109','Caron','Jean Luc','10 Greenfield St.','Rome','ME','04963','207-555-9643'),
	('110','Bers','Martha','65 Granite St.','York','NY','14592','585-555-0111'),
	('112','Jones','Laura','373 Highland Ave.','Somerville','MA','02143','857-555-6258'),
	('115','Vaccari','Adam','1282 Ocean Walk','Ocean CITY','NJ','08226','609-555-5231'),
	('116','Murakami','Iris','7 Cherry Blossom St.','Weymouth','MA','02188','617-555-6665'),
	('119','Chau','Clement','18 Ark Ledge Ln.','Londonderry','VT','05148','802-555-3096'),
	('120','Gernowski','Sadie','24 Stump Rd.','Athens','ME','04912','207-555-4507'),
	('121','Bretton-Borak','Siam','10 Old Main St.','Cambridge','VT','05444','802-555-3443'),
	('122','Hefferson','Orlagh','132 South St. Apt 27','Manchester','NH','03101','603-555-3476'),
	('123','Barnett','Larry','25 Stag Rd.','Fairfield','CT','06824','860-555-9876'),
	('124','Busa','Karen','12 Foster St.','South Windsor','CT','06074','857-555-5532'),
	('125','Peterson','Becca','51 Fredrick St.','Albion','NY','14411','585-555-0900'),
	('126','Brown','Brianne','154 Central St.','Vernon','CT','06066','860-555-3234');
INSERT INTO [TerpsTours.Reservation] VALUES
	('1600001',40,'3-26-2016',2,55.00,0.00,'101'),
	('1600002',21,'6-8-2016',2,95.00,0.00,'101'),
	('1600003',28,'9-12-2016',1,35.00,0.00,'103'),
	('1600004',26,'10-16-2016',4,45.00,15.00,'104'),
	('1600005',39,'6-25-2016',5,55.00,0.00,'105'),
	('1600006',32,'6-18-2016',1,80.00,20.00,'106'),
	('1600007',22,'7-9-2016',8,75.00,10.00,'107'),
	('1600008',28,'9-12-2016',2,35.00,0.00,'108'),
	('1600009',38,'9-11-2016',2,90.00,40.00,'109'),
	('1600010',2,'5-14-2016',3,25.00,0.00,'102'),
	('1600011',3,'9-15-2016',3,25.00,0.00,'102'),
	('1600012',1,'6-12-2016',4,15.00,0.00,'115'),
	('1600013',8,'7-9-2016',1,20.00,5.00,'116'),
	('1600014',12,'10-1-2016',2,40.00,5.00,'119'),
	('1600015',10,'7-23-2016',1,20.00,0.00,'120'),
	('1600016',11,'7-23-2016',6,75.00,15.00,'121'),
	('1600017',39,'6-18-2016',3,20.00,5.00,'122'),
	('1600018',38,'9-18-2016',4,85.00,15.00,'126'),
	('1600019',25,'8-29-2016',2,110.00,25.00,'124'),
	('1600020',28,'8-27-2016',2,35.00,10.00,'124'),
	('1600021',32,'6-11-2016',3,90.00,20.00,'112'),
	('1600022',21,'6-8-2016',1,95.00,25.00,'119'),
	('1600024',38,'9-11-2016',1,70.00,30.00,'121'),
	('1600025',38,'9-11-2016',2,70.00,45.00,'125'),
	('1600026',12,'10-1-2016',2,40.00,0.00,'126'),
	('1600029',4,'9-19-2016',4,105.00,25.00,'120'),
	('1600030',15,'7-25-2016',6,60.00,15.00,'104');

/*5.	SQL queries:*/
1)	(3pts) What are the full details of all customers in the alphabetical order of states then zips.
SELECT *
FROM  [TerpsTours.Customer]
ORDER BY state, zip;


/*2)	(3pts) What are the trips in early fall?*/
SELECT *
FROM [TerpsTours.Trip]
WHERE season = ‘Early Fall’;


/*3)	 (3pts) How many guides?*/
SELECT COUNT (DISTINCT guideId)
FROM [TerpsTours.Guide]

/*4)	 (3pts) What is the total number of persons among all reservations?*/
SELECT SUM (numPersons)
FROM [TerpsTours.Reservation]

/*5)	(4pts) What are the trip names and the corresponding dates in the order of dates?*/
SELECT t.tripName, r.tripDate
FROM [TerpsTours.Trip] t, [TerpsTours.Reservation] r
WHERE t.tripID = r.tripID
Order By r.tripDate

/*6)	(4pts) What are the reservations, in which the number of persons exceeds the maximum size of the trip?*/
SELECT r.reservationID
FROM [TerpsTours.Trip] t, [TerpsTours.Reservation] r
WHERE t.tripId = r.tripID AND t.maxSize < r.numPersons

/*7)	(5pts) What are the reservations, in which the customer and the trip are in the same state?*/
SELECT r.reservationID
FROM [TerpsTours.Trip] t, [TerpsTours.Reservation] r, [TerpsTours.customer] c
WHERE  t.tripId = r.tripId AND r.customerID = c.customerID AND c.state=t.state

/*8)	(5pts) What are the guide’s names and their corresponding seasons of trips?*/
SELECT g.firstName, g.lastName, t.season
FROM [TerpsTours.Guide] g, [TerpsTours.Tours] o, [TerpsTours.Trip] t
WHERE g.guideID = o.guideID AND o.tripID = t.tripID

 
/*9)	(6pts) What are the name and the number of trips for each guide?*/
SELECT g.firstName, g.lastName, COUNT (DISTINCT o.tripID) As numberofTrips
FROM [TerpsTours.Guide] g, [TerpsTours.Tours] o, [TerpsTours.Trip] t
WHERE g.guideID = o.guideID AND o.tripID = t.tripID
GROUP by g.firstName, g.lastName


/*10)	(6pts) What are the name, the location, and the number of guides for each trip in the order of the trip location then name?*/
SELECT t.tripName, t.startLocation, COUNT (DISTINCT o.guideID) as numberofGuides
FROM [TerpsTours.Guide] g, [TerpsTours.Tours] o, [TerpsTours.Trip] t
WHERE g.guideID = o.guideID AND o.tripID = t.tripID
Group By t.startLocation, t.tripName


/*11)	(6pts) What are the name, the number of reservations, and the average of other fees for each trip in the order of the trip name?*/
SELECT t.tripName, Count (DISTINCT r.reservationID) As numberofReservation, AVG (otherFees) As averageFees
FROM [TerpsTours.Trip] t, [TerpsTours.Reservation] r
WHERE t.tripId = r.tripID
Group By t.tripName
    
/*12)	 (6pts) What are the name, the first and the last trips by displaying the corresponding dates for each customer in the order of the customer’s first then last names? */
SELECT c.firstName, c.lastName, Min (r.tripDate) As FirstTrip, Max (r.tripDate) As lastTrip
FROM [TerpsTours.Customer] c, [TerpsTours.Reservation] r
Where c.customerId = r.customerId 
Group By c.Firstname, c.lastName

/*13)	(6pts) What are the first and the last names, and the number of trips for each guide and each customer?*/
SELECT g.firstName, g.lastName, COUNT (DISTINCT t.tripId) As guideTotalTrips, 
c.firstName, c.lastName,  COUNT (DISTINCT r.reservationId) As customerTotalTrips
FROM [TerpsTours.Customer] c, [TerpsTours.Reservation] r, [TerpsTours.Guide] g, [TerpsTours.Tours] t
WHERE c.customerId = r.customerId AND g.guideId=t.guideId AND r.tripId= t.tripId
Group by g.firstName, g.lastName , c.firstName, c.lastName


