-- 1. Создать хранимую процедуру, которая выполняет арифметическую операцию
-- над полями таблицы по вводимому параметру процедуры.
DELIMITER //

CREATE PROCEDURE UpdateSeatingCapacity(IN multiplier FLOAT)
BEGIN
    UPDATE airplane SET seats = seats * multiplier;
END //

DELIMITER ;

-- 2. Создать хранимую процедуру, которая возвращает связанные записи нескольких
-- таблиц. 
DELIMITER //

CREATE PROCEDURE GetDepartureInfo()
BEGIN
    select d.date, d.departureTime, d. arrivalTime, a.seats, m.name
    from departures d 
    join airplane a on d.idairplane = a.idairplane
    join mark m on m.idmark = a.idmark;
END //

DELIMITER ;

-- 3. Создать хранимую процедуру, вычисляющую агрегированные характеристики
-- записей таблицы (например, минимальное, максимальное и среднее значение
-- некоторых полей).
DELIMITER //

CREATE PROCEDURE GetPlaneSpeed()
BEGIN
    select avg(speed), max(speed), min(speed) from airplane;
END //

DELIMITER ;

-- 4. Создать функцию, использующую конструкцию CASE (например,
-- преобразование номера дня недели в текст), вывести результат выполнения
-- функции в запросе. 
DELIMITER //

CREATE FUNCTION DayOfWeekName(dayNumber INT) 
RETURNS VARCHAR(20)
DETERMINISTIC 
NO SQL 
BEGIN
    RETURN CASE dayNumber
        WHEN 1 THEN 'Понедельник'
        WHEN 2 THEN 'Вторник'
        WHEN 3 THEN 'Среда'
        WHEN 4 THEN 'Четверг'
        WHEN 5 THEN 'Пятница'
        WHEN 6 THEN 'Суббота'
        WHEN 7 THEN 'Воскресенье'
        ELSE 'Неизвестно'
    END;
END//

DELIMITER ;

-- 5. Создайте курсор для вывода записей из таблицы, удовлетворяющих заданному
-- условию.
DELIMITER //

CREATE PROCEDURE GetBoeingAirplanes()
BEGIN
    DECLARE finished INT DEFAULT FALSE;
    DECLARE plane_id INT;
    DECLARE plane_speed INT;
    DECLARE plane_height INT;
    DECLARE plane_takeoff_weight INT;
    DECLARE plane_tail_number VARCHAR(45);
    DECLARE plane_type VARCHAR(45);
    DECLARE plane_seats INT;
    DECLARE plane_fuel VARCHAR(45);
    DECLARE plane_takeoff_run INT;
    DECLARE plane_idmark INT;
    
    DECLARE cur_airplanes CURSOR FOR 
        SELECT idairplane, speed, height, takeOffWeight, tailNumber, type, seats, fuel, takeoffRun, idmark
        FROM airport.airplane
        WHERE idmark = 1;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN cur_airplanes;

    get_airplane: LOOP
        FETCH cur_airplanes INTO plane_id, plane_speed, plane_height, plane_takeoff_weight, plane_tail_number, plane_type, plane_seats, plane_fuel, plane_takeoff_run, plane_idmark;
        IF finished THEN
            LEAVE get_airplane;
        END IF;
        SELECT plane_id, plane_speed, plane_height, plane_takeoff_weight, plane_tail_number, plane_type, plane_seats, plane_fuel, plane_takeoff_run, plane_idmark;
    END LOOP;

    CLOSE cur_airplanes;
END //

DELIMITER ;

-- 6. Создать хранимую процедуру, которая записывает в новую таблицу все картежи
-- из существующей таблицы по определенному критерию отбора. Предварительно
-- необходимо создать новую пустую таблицу со структурой, аналогичной
-- структуре существующей таблицы. Хранимая процедура должна использовать
-- курсор, который в цикле читает данные из существующей таблицы и добавляет
-- их в новую таблицу.
DELIMITER //

CREATE PROCEDURE GetTopPlanes()
BEGIN
    DECLARE plane_speed INT;
    DECLARE plane_height INT;
    DECLARE finished INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT speed, height FROM airplane;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    DROP TEMPORARY TABLE IF EXISTS top_planes;
    CREATE TEMPORARY TABLE top_planes (
        top_plane_speed INT,
        top_plane_height INT
    );

    OPEN cur;

    get_data: LOOP
        FETCH cur INTO plane_speed, plane_height;
        IF finished THEN
            LEAVE get_data;
        END IF;
        IF plane_speed > 800 AND plane_height > 10000 THEN
            INSERT INTO top_planes VALUES (plane_speed, plane_height);
        END IF;
    END LOOP;

    CLOSE cur;

    SELECT * FROM top_planes;
END //

DELIMITER ;

-- 1
select * from airplane;
CALL UpdateSeatingCapacity(1.1);
select * from airplane;
-- 2
call GetDepartureInfo();
-- 3
call GetPlaneSpeed();
-- 4
SELECT DayOfWeekName(1) AS DayName;
-- 5 
CALL GetBoeingAirplanes();
-- 6
call GetTopPlanes();
