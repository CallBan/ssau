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
  SET NEW.name = CONCAT('Mark-', NEW.name);
END //

DELIMITER ;

INSERT INTO mark VALUE (11, 'Boeing1', 1);
-- delete from mark where idmark = 11;

-- 2. Создать триггер ведения аудита изменения записей в таблицах.

