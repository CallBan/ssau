--
-- Скрипт сгенерирован Devart dbForge Studio 2019 for MySQL, Версия 8.1.22.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 15.11.2023 13:42:43
-- Версия сервера: 5.7.39-log
-- Версия клиента: 4.1
--

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

--
-- Установка базы данных по умолчанию
--
CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;

--
-- Удалить таблицу `order_list`
--
DROP TABLE IF EXISTS order_list;

--
-- Удалить таблицу `dish`
--
DROP TABLE IF EXISTS dish;

--
-- Удалить таблицу `dish_type`
--
DROP TABLE IF EXISTS dish_type;

--
-- Удалить таблицу `order_client`
--
DROP TABLE IF EXISTS order_client;

--
-- Удалить таблицу `client`
--
DROP TABLE IF EXISTS client;

--
-- Установка базы данных по умолчанию
--
USE food_delivery;

--
-- Создать таблицу `client`
--
CREATE TABLE client (
  id_client int(11) NOT NULL,
  FIO varchar(255) DEFAULT NULL,
  Address varchar(255) DEFAULT NULL,
  telefon bigint(20) DEFAULT NULL,
  email varchar(50) DEFAULT NULL,
  PRIMARY KEY (id_client)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1820,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Создать таблицу `order_client`
--
CREATE TABLE order_client (
  id_order int(11) NOT NULL,
  date datetime DEFAULT NULL,
  id_client int(11) DEFAULT NULL,
  PRIMARY KEY (id_order)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1489,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Создать внешний ключ
--
ALTER TABLE order_client
ADD CONSTRAINT FK_order_id_client FOREIGN KEY (id_client)
REFERENCES client (id_client) ON DELETE NO ACTION;

--
-- Создать таблицу `dish_type`
--
CREATE TABLE dish_type (
  id_type int(11) NOT NULL,
  name_type varchar(50) DEFAULT NULL,
  PRIMARY KEY (id_type)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Создать таблицу `dish`
--
CREATE TABLE dish (
  id_dish int(11) NOT NULL,
  name_dish varchar(100) DEFAULT NULL,
  description blob DEFAULT NULL,
  price int(11) DEFAULT NULL,
  id_type int(11) DEFAULT NULL,
  PRIMARY KEY (id_dish)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 468,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Создать внешний ключ
--
ALTER TABLE dish
ADD CONSTRAINT FK_dish_id_type FOREIGN KEY (id_type)
REFERENCES dish_type (id_type) ON DELETE NO ACTION;

--
-- Создать таблицу `order_list`
--
CREATE TABLE order_list (
  id_order int(11) NOT NULL,
  id_dish int(11) NOT NULL,
  amount int(11) DEFAULT NULL,
  PRIMARY KEY (id_order, id_dish)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 712,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Создать внешний ключ
--
ALTER TABLE order_list
ADD CONSTRAINT FK_order_list_id_dish FOREIGN KEY (id_dish)
REFERENCES dish (id_dish) ON DELETE NO ACTION;

--
-- Создать внешний ключ
--
ALTER TABLE order_list
ADD CONSTRAINT FK_order_list_id_order FOREIGN KEY (id_order)
REFERENCES order_client (id_order) ON DELETE NO ACTION;

-- 
-- Вывод данных для таблицы client
--
INSERT INTO client VALUES
(1, 'Aksenov AA', 'Proseka, 95-25', 89064545678, 'rew@mail.ru'),
(2, 'Aminev DD', 'Lenina, 34-78', 83453434356, 'am@yandex.ru'),
(3, 'Bubnov FG', 'Proseka, 56-45', 89065657789, 'bub@mail.ru'),
(4, 'Bulkin NN', 'Lukacheva, 37-23', 89061212345, 'bulk@mail.ru'),
(5, 'Fedorov KH', 'Gagarina GD, 56-56', 89275654321, 'fed@yandex.ru'),
(6, 'Kozlov GS', 'Shvernika, 46-9', 89076768675, 'koz@mail.ru'),
(7, 'Gorbunov ER', 'Moskovskay, 4-8', 89277111111, 'gorbun@mail.ru'),
(8, 'Fursov KT', 'Lukacheva, 67-90', 89061111111, 'Fur@yandex.ru'),
(9, 'Yrcev VV', 'Lukacheva, 67-12', 89085555555, 'yr@mail.ru'),
(10, 'Tupolev TU', 'Vilonovskay, 8-23', 89274544444, 'tula@mail.ru'),
(11, 'Popov IA', 'Boot, 3-78', 3456789, 'Boo@mail.ru');

-- 
-- Вывод данных для таблицы dish_type
--
INSERT INTO dish_type VALUES
(1, 'Rolls'),
(2, 'Sushi'),
(3, 'Soups'),
(4, 'Salads'),
(5, 'Pizza'),
(6, 'Drinks');

-- 
-- Вывод данных для таблицы order_client
--
INSERT INTO order_client VALUES
(101, '2022-11-05 00:17:00', 1),
(102, '2022-11-01 00:18:00', 1),
(103, '2022-10-03 00:13:19', 2),
(104, '2022-11-10 00:09:00', 2),
(105, '2022-10-12 00:12:00', 3),
(106, '2022-11-17 00:13:09', 4),
(107, '2022-11-02 00:00:00', 5),
(108, '2022-11-11 00:09:00', 6),
(109, '2022-11-14 00:14:00', 7),
(110, '2022-11-06 00:00:00', 8),
(111, '2022-10-07 00:00:00', 9),
(112, '2022-10-31 00:17:00', 10),
(113, '2022-10-31 00:21:00', 10),
(114, '2022-11-15 00:12:00', 10),
(115, '2022-11-05 00:00:00', 1);

-- 
-- Вывод данных для таблицы dish
--
INSERT INTO dish VALUES
(1, 'Maguro', NULL, 100, 2),
(2, 'Sake', NULL, 110, 2),
(3, 'Unigi', NULL, 130, 2),
(4, 'Tobiko', NULL, 100, 2),
(5, 'Chukka', NULL, 100, 2),
(6, 'Ikura', NULL, 130, 2),
(7, 'Filadelfia', x'D4E8EBE0E4E5EBFCF4E8FF20EEE1E5F0EDF3F2E0FF20E220EDE5E6EDEEE520F4E8EBE520EBEEF1EEF1FF2C20F120F2E5ECEFF3F0EDEEE920EAF0E5E2E5F2EAEEE9', 560, 1),
(8, 'Naomi', NULL, 355, 1),
(9, 'Kioto', NULL, 480, 1),
(10, 'Canada', NULL, 620, 1),
(11, 'Asay', NULL, 345, 1),
(12, 'Bonito', NULL, 310, 1),
(13, 'Futari', NULL, 370, 1),
(14, 'Segun', NULL, 480, 1),
(15, 'Mashed soup', NULL, 210, 3),
(16, 'Tom yam', NULL, 270, 3),
(17, 'Ramen with chiken ', NULL, 210, 3),
(18, 'Miso shrimp soup', NULL, 210, 3),
(19, 'Chicken soup', NULL, 200, 3),
(20, 'Solyanka', NULL, 260, 3),
(21, 'Caesar with shrimp', NULL, 360, 4),
(22, 'Caesar with chicken', NULL, 310, 4),
(23, 'Reikan', NULL, 300, 4),
(24, 'Greek', NULL, 270, 4),
(25, 'Roman', NULL, 460, 5),
(26, 'Hunter''s', NULL, 480, 5),
(27, 'Venice', NULL, 830, 5),
(28, 'Kaprichoza', NULL, 540, 5),
(29, 'Naples', NULL, 460, 5),
(30, 'Meat-based', NULL, 480, 5),
(31, 'Ham and mushrooms', NULL, 370, 5),
(32, 'Vanilla 0,33', NULL, 85, 6),
(33, 'Vanilla 1л', NULL, 160, 6),
(34, 'Kvass 0,33', NULL, 50, 6),
(35, 'Ice tea', NULL, 76, 6);

-- 
-- Вывод данных для таблицы order_list
--
INSERT INTO order_list VALUES
(101, 1, 1),
(101, 2, 2),
(102, 19, 1),
(102, 32, 1),
(103, 31, 2),
(104, 7, 1),
(104, 16, 1),
(104, 35, 1),
(105, 17, 3),
(105, 27, 1),
(106, 18, 1),
(106, 20, 1),
(107, 30, 1),
(108, 22, 5),
(109, 15, 1),
(109, 16, 2),
(110, 28, 1),
(110, 35, 2),
(111, 27, 1),
(112, 27, 1),
(113, 3, 1),
(113, 4, 1),
(113, 5, 1),
(113, 6, 1);

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;