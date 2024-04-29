-- Пример представления 
create view artist_info as 
select name, realname, profile from artist;

select * from artist_info;

-- Пример процедуры
DELIMITER //

CREATE PROCEDURE add_new_artist(IN new_artist_name VARCHAR(255))
BEGIN
    INSERT INTO artist(name)
    VALUES (new_artist_name);
END //

DELIMITER ;

-- Создайте нового пользователя и предоставьте ему привилегии на выборку
-- информации из созданных вами представлений и запуска процедур.
create user 'test_user'@'localhost' identified by '12345';
-- drop user 'test_user'@'localhost';
grant select on discogs.artist_info to 'test_user'@'localhost';
grant execute on procedure discogs.add_new_artist to 'test_user'@'localhost';

-- Соединитесь с СУБД от своего имени и предоставьте новому пользователю
-- привилегии на выборку, вставку, изменение и удаление данных из ваших
-- таблиц.
grant update, select, delete on discogs.* to 'test_user'@'localhost';

-- Соединитесь с СУБД от своего имени и отберите у нового пользователя все
-- предоставленные ему привилегии.
revoke update, select, delete on discogs.* from 'test_user'@'localhost';