insert into admissiongroup(idadmissionGroup) value
	(1),
	(2),
	(3),
	(4),
	(5);
select idadmissionGroup from admissiongroup;

insert into crewinfo(idcrew, idadmissionGroup) values
	(1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 1),
    (7, 2),
    (8, 3),
    (9, 4),
    (10, 5);
select idcrew, idadmissionGroup from crewinfo;

INSERT INTO mark (idmark, name, idadmissionGroup) 
VALUES 
    (1, 'Boeing', 1),
    (2, 'Airbus', 1),
    (3, 'Embraer', 2),
    (4, 'Cessna', 2),
    (5, 'Bombardier', 3),
    (6, 'Gulfstream', 3),
    (7, 'Dassault', 4),
    (8, 'Pilatus', 4),
    (9, 'Beechcraft', 5),
    (10, 'Piper', 5);
select idmark, name, idadmissionGroup from mark;

INSERT INTO airplane (idairplane, speed, height, takeOffWeight, tailNumber, type, seats, fuel, takeoffRun, idmark)
VALUES 
	(1, 700, 10000, 5000, 'ABCD123', 'Passenger', 150, 'Jet Fuel', 2000, 1),
	(2, 600, 8000, 4000, 'EFGH456', 'Cargo', 50, 'Aviation Gasoline', 1500, 2),
	(3, 800, 12000, 6000, 'IJKL789', 'Passenger', 200, 'Jet A-1 Fuel', 2500, 3),
	(4, 500, 7000, 3500, 'MNOP123', 'Cargo', 75, 'Jet B Fuel', 1800, 4),
	(5, 750, 11000, 5500, 'QRST456', 'Passenger', 180, 'AvGas', 2200, 5),
	(6, 550, 7500, 3800, 'UVWX789', 'Cargo', 60, 'Jet A Fuel', 1600, 6),
	(7, 700, 10000, 5000, 'YZAB123', 'Passenger', 150, 'Jet Fuel', 2000, 7),
	(8, 650, 9000, 4500, 'CDEF456', 'Cargo', 70, 'Jet A-1 Fuel', 1700, 8),
	(9, 770, 11500, 5800, 'GHIJ789', 'Passenger', 190, 'Aviation Gasoline', 2300, 9),
	(10, 520, 7200, 3600, 'KLMN123', 'Cargo', 55, 'Jet B Fuel', 1750, 10),
	(11, 720, 9500, 4800, 'OPQR123', 'Passenger', 160, 'Jet Fuel', 1900, 1),
	(12, 580, 7800, 3900, 'STUV456', 'Cargo', 65, 'Aviation Gasoline', 1650, 2),
	(13, 830, 11200, 5600, 'WXYZ789', 'Passenger', 195, 'Jet A-1 Fuel', 2400, 3),
	(14, 530, 7200, 3600, 'ABCD456', 'Cargo', 55, 'Jet B Fuel', 1750, 4),
	(15, 770, 10500, 5200, 'EFGH789', 'Passenger', 170, 'AvGas', 2100, 5),
	(16, 600, 8000, 4000, 'IJKL123', 'Cargo', 45, 'Jet A Fuel', 1500, 6),
	(17, 720, 9500, 4800, 'MNOP456', 'Passenger', 155, 'Jet Fuel', 1900, 7),
	(18, 680, 8900, 4400, 'QRST789', 'Cargo', 75, 'Jet A-1 Fuel', 1800, 8),
	(19, 790, 11500, 5700, 'UVWX123', 'Passenger', 185, 'Aviation Gasoline', 2250, 9),
	(20, 540, 7200, 3600, 'YZAB456', 'Cargo', 60, 'Jet B Fuel', 1750, 10);
select idairplane, speed, height, takeOffWeight, tailNumber, type, seats, fuel, takeoffRun, idmark from airplane;

INSERT INTO Country (idCountry, Countrycol) 
	VALUES 
	(1, 'USA'),
	(2, 'UK'),
	(3, 'Germany'),
	(4, 'France'),
	(5, 'Japan');
select idCountry, Countrycol from Country;

INSERT INTO City (idCity, name, idCountry) 
	VALUES 
	(1, 'New York', 1),
	(2, 'London', 2),
	(3, 'Berlin', 3),
	(4, 'Paris', 4),
	(5, 'Tokyo', 5),
	(6, 'Los Angeles', 1),
	(7, 'Manchester', 2),
	(8, 'Munich', 3),
	(9, 'Nice', 4),
	(10, 'Kyoto', 5);
select idCity, name, idCountry from City;

INSERT INTO route (idroute, name, whereTo, fromTo) 
VALUES 
	(1, 'London-Tokyo', 5, 1),
	(2, 'Munich-Paris', 2, 3),
	(3, 'Nice-Manchester', 4, 7),
	(4, 'New York-Tokyo', 1, 5),
	(5, 'Berlin-Munich', 3, 8),
	(6, 'Los Angeles-London', 5, 2),
	(7, 'Paris-Los Angeles', 4, 6),
	(8, 'New York-Nice', 1, 9),
	(9, 'London-Kyoto', 2, 10),
	(10, 'Berlin-New York', 3, 1),
	(11, 'Tokyo-Berlin', 5, 3),
	(12, 'Manchester-Paris', 2, 4),
	(13, 'Paris-Nice', 4, 7),
	(14, 'Tokyo-New York', 1, 5),
	(15, 'Munich-London', 3, 8),
	(16, 'Los Angeles-Tokyo', 5, 2),
	(17, 'Paris-Los Angeles', 4, 6),
	(18, 'New York-Nice', 1, 9),
	(19, 'London-Kyoto', 2, 10),
	(20, 'Berlin-New York', 3, 1);
select idroute, name, whereTo, fromTo from route;


