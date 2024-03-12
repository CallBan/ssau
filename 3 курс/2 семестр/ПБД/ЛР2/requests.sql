-- Выдать расписание аэропорта на определенную дату.
select date, route.name, departureTime, arrivalTime from departures 
join route on departures.idroute = route.idroute
where date = '2024-03-12';
 
 -- Выдать список самолетов, имеющих более 300 посадочных мест
 select * from airplane 
 where seats > 100;
 
-- В связи с участившимися террористическими актами для охранных служб
-- аэропорта создается запрос на выборку – «Продажа билетов», в котором
-- отражается информация о том, сколько и кому каждый кассир продал билетов,
-- на какой рейс.
select employee.full_name, passenger.surname, passenger.name, passenger.patronymic, route.name, count(passenger.idpassenger) from employee
join ticket on ticket.idemployee = employee.idemployee
join passenger on passenger.idpassenger = ticket.idpassenger
join departures on departures.iddepartures = ticket.iddepartures
join route on route.idroute = departures.idroute
group by passenger.idpassenger, employee.full_name, route.name;

-- Выдать информацию об экипаже, назначенном на определенный рейс
select employee.full_name, post.name from employee 
join post on post.idpost = employee.idpost
join crew on crew.idemployee = employee.idemployee
join crewinfo on crewinfo.idcrew = crew.idcrew
join departures on departures.idcrew = crewinfo.idcrew
where departures.iddepartures = 1;

-- Выдать список самолетов, совершивших полеты в определенный день
select mark.name, airplane.tailNumber from mark
join airplane on airplane.idmark = mark.idmark
join departures on departures.idairplane = airplane.idairplane
where departures.date = '2024-03-13';

-- Выдать список всех направлений, по которым осуществляются авиаперевозки
select name from route;



