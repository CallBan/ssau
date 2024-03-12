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

INSERT INTO departures (iddepartures, idcrew, idairplane, date, departureTime, arrivalTime, idroute, name) 
VALUES 
	(1, 1, 1, '2024-03-12', '09:00:00', '12:00:00', 1, 'Departure 1'),
	(2, 2, 2, '2024-03-13', '10:00:00', '14:00:00', 2, 'Departure 2'),
	(3, 3, 3, '2024-03-14', '11:00:00', '16:00:00', 3, 'Departure 3'),
	(4, 4, 4, '2024-03-15', '12:00:00', '18:00:00', 4, 'Departure 4'),
	(5, 5, 5, '2024-03-16', '13:00:00', '20:00:00', 5, 'Departure 5'),
	(6, 6, 6, '2024-03-17', '14:00:00', '22:00:00', 6, 'Departure 6'),
	(7, 7, 7, '2024-03-18', '15:00:00', '10:00:00', 7, 'Departure 7'),
	(8, 8, 8, '2024-03-19', '16:00:00', '12:00:00', 8, 'Departure 8'),
	(9, 9, 9, '2024-03-20', '17:00:00', '14:00:00', 9, 'Departure 9'),
	(10, 10, 10, '2024-03-21', '18:00:00', '16:00:00', 10, 'Departure 10');
select iddepartures, idcrew, idairplane, date, departureTime, arrivalTime, idroute, name from departures;

INSERT INTO post (idpost, name) 
VALUES 
	(1, 'Pilot'),
	(2, 'Flight Attendant'),
	(3, 'Mechanic'),
	(4, 'Air Traffic Controller'),
	(5, 'Ground Crew'),
	(6, 'Ticket Sales Agent');
select idpost, name from post;

INSERT INTO employee (idemployee, full_name, idpost) 
VALUES 
	(1, 'John Smith', 1),      -- Pilot
	(2, 'Emily Johnson', 2),   -- Flight Attendant
	(3, 'Michael Brown', 3),   -- Mechanic
	(4, 'Sarah Davis', 4),     -- Air Traffic Controller
	(5, 'James Wilson', 5),    -- Ground Crew
	(6, 'Emma Martinez', 6),   -- Ticket Sales Agent
	(7, 'Daniel Thompson', 1), 
	(8, 'Olivia White', 2),
	(9, 'William Lee', 3),
	(10, 'Sophia Harris', 4),
	(11, 'Alexander Clark', 5),
	(12, 'Ava Rodriguez', 6),
	(13, 'Matthew Lewis', 1),
	(14, 'Chloe Hall', 2),
	(15, 'Christopher Allen', 3),
	(16, 'Victoria Young', 4),
	(17, 'Andrew King', 5),
	(18, 'Lily Anderson', 6),
	(19, 'Jacob Scott', 1),
	(20, 'Grace Baker', 2);
select idemployee, full_name, idpost from employee;

INSERT INTO passenger (idpassenger, surname, name, patronymic) 
VALUES 
	(1, 'Smith', 'John', 'Patrick'),
	(2, 'Johnson', 'Emily', 'Anne'),
	(3, 'Brown', 'Michael', 'David'),
	(4, 'Davis', 'Sarah', 'Michelle'),
	(5, 'Wilson', 'James', 'Robert'),
	(6, 'Martinez', 'Emma', 'Maria'),
	(7, 'Thompson', 'Daniel', 'Joseph'),
	(8, 'White', 'Olivia', 'Grace'),
	(9, 'Lee', 'William', 'Thomas'),
	(10, 'Harris', 'Sophia', 'Elizabeth'),
	(11, 'Clark', 'Alexander', 'John'),
	(12, 'Rodriguez', 'Ava', 'Sofia'),
	(13, 'Lewis', 'Matthew', 'Jacob'),
	(14, 'Hall', 'Chloe', 'Madison'),
	(15, 'Allen', 'Christopher', 'George'),
	(16, 'Young', 'Victoria', 'Louise'),
	(17, 'King', 'Andrew', 'Charles'),
	(18, 'Anderson', 'Lily', 'Rose'),
	(19, 'Scott', 'Jacob', 'Benjamin'),
	(20, 'Baker', 'Grace', 'Victoria'),
	(21, 'Garcia', 'Sophie', 'Marie'),
	(22, 'Lopez', 'David', 'Daniel'),
	(23, 'Adams', 'Madison', 'Katherine'),
	(24, 'Cooper', 'Henry', 'Edward'),
	(25, 'Morgan', 'Hannah', 'Paige'),
	(26, 'Cruz', 'Carlos', 'Miguel'),
	(27, 'Reed', 'Abigail', 'Noelle'),
	(28, 'Perez', 'Gabriel', 'Antonio'),
	(29, 'Griffin', 'Leah', 'Marie'),
	(30, 'Ward', 'Peter', 'Alexander');
select idpassenger, surname, name, patronymic from passenger;

INSERT INTO ticket (idticket, iddepartures, idemployee, idpassenger) 
VALUES 
	(1, 1, 6, 1),
	(2, 2, 12, 2),
	(3, 3, 18, 3),
	(4, 4, 6, 4),
	(5, 5, 12, 5),
	(6, 1, 18, 6),      
	(7, 2, 6, 7),      
	(8, 3, 12, 8),       
	(9, 4, 18, 9),       
	(10, 5, 6, 10),
	(11, 1, 6, 11),
	(12, 2, 12, 12),
	(13, 1, 18, 13),    
	(14, 4, 12, 14),
	(15, 5, 18, 15),
	(16, 1, 6, 16),
	(17, 3, 12, 17),
	(18, 4, 18, 18),
	(19, 5, 6, 19),
	(20, 1, 12, 20),
	(21, 3, 12, 1),       
	(22, 4, 18, 2),
	(23, 5, 6, 3),
	(24, 1, 12, 4),      
	(25, 2, 6, 5),
	(26, 3, 12, 6),       
	(27, 4, 18, 7),
	(28, 5, 18, 8),
	(29, 1, 6, 9),     
	(30, 2, 6, 10),
	(31, 3, 12, 11),    
	(32, 4, 18, 12),
	(33, 5, 12, 13),
	(34, 1, 18, 14),    
	(35, 2, 6, 15),
	(36, 3, 12, 16),
	(37, 4, 18, 17),
	(38, 5, 6, 18),
	(39, 1, 12, 19),     
	(40, 2, 6, 20);    
 select idticket, iddepartures, idemployee, idpassenger from ticket;
 
INSERT INTO crew (idcrew, idemployee) 
VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 10);
select idcrew, idemployee from crew;



