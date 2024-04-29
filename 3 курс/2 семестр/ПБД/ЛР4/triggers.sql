-- 1. Создать триггер:
-- a. запрещающий вставку в таблицу новой строки с заданным параметром;

delimiter //
create trigger canceling_insertion before insert on airplane
for each row
begin
	if new.height < 7000
    then
	signal sqlstate '45000'
	set message_text = 'Самолет не соответствует техническим требованиям';
	end if;
    
	if new.tailNumber in 
    (select tailNumber from airplane)
	then
	signal sqlstate '45000'
	set message_text = 'Ошибка. Такой самолет уже зарегистрирован';
	end if;
end //
delimiter ;

INSERT INTO airplane VALUE (101, 700, 5000, 5000, 'ABCD124', 'Passenger', 150, 'Jet Fuel', 2000, 1);

-- drop trigger canceling_insertion;
-- delete from airplane where idairplane = 101;

-- 1. Создать триггер:
-- b. заполняющий одно из полей таблицы на основе вводимых данных.
DELIMITER //

CREATE TRIGGER before_mark_insert
BEFORE INSERT ON mark
FOR EACH ROW
BEGIN
	if new.name not regexp 'Mark-$' then
		SET NEW.name = CONCAT('Mark-', NEW.name);
	end if;
END //

DELIMITER ;

INSERT INTO mark VALUE (11, 'Boeing1', 1);
-- drop trigger before_mark_insert;
-- delete from mark where idmark = 11;

-- 2. Создать триггер ведения аудита изменения записей в таблицах.
DELIMITER //

CREATE TABLE IF NOT EXISTS Plane_audit 
(
 tailNumber VARCHAR(20),
 takeOffWeight INT,
 speed INT,
 height INT,
 type VARCHAR(20),
 seats INT,
 fuel  VARCHAR(20),
 takeoffRun INT,
 action VARCHAR(20),
 audit_timestamp DATETIME
);

CREATE TRIGGER plane_auditor AFTER UPDATE ON airplane
FOR EACH ROW
BEGIN
 INSERT INTO Plane_audit (tailNumber, takeOffWeight, speed, height, type, seats, fuel, takeoffRun, action, audit_timestamp)
 VALUES (OLD.tailNumber, OLD.takeOffWeight, OLD.speed, OLD.height, OLD.type, OLD.seats, OLD.fuel, OLD.takeoffRun, 'UPDATE', NOW());
END //

DELIMITER ;

update airplane
set fuel = 'Jet A Fuel'
where fuel = 'Jet B Fuel';

select * from plane_audit;