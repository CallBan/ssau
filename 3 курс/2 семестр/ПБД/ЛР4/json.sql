-- 4. Создать новую таблицу или изменить существующую, добавив поле типа JSON,
-- заполнить таблицу данными. Минимум одно из значений записи должно
-- представлять из себя вложенную структуру, одно – массив.

CREATE TABLE IF NOT EXISTS helicopter (
  id INT AUTO_INCREMENT PRIMARY KEY,
  model VARCHAR(100) NOT NULL,
  max_height INT NOT NULL,
  capacity INT NOT NULL,
  specifications JSON NOT NULL
);

INSERT INTO helicopter (model, max_height, capacity, specifications) VALUES
('HeliA', 4500, 4, '{"engine": {"type": "piston", "power": "600hp"}, "available_colors": ["white", "black"] }'),
('HeliB', 5000, 6, '{"engine": {"type": "turboshaft", "power": "1100hp"}, "available_colors": ["yellow", "green", "black"] }'),
('HeliC', 3500, 3, '{"engine": {"type": "electric", "power": "500hp"}, "available_colors": ["blue", "silver"] }'),
('HeliD', 7000, 8, '{"engine": {"type": "twin-turboshaft", "power": "1500hp"}, "available_colors": ["red", "blue", "green", "black", "white"] }'),
('HeliE', 6500, 7, '{"engine": {"type": "turboshaft", "power": "1200hp"}, "available_colors": ["gold", "silver", "black"] }');

-- 5. Выполнить запрос, возвращающий содержимое данной таблицы,
-- соответствующее некоторому условию, проверяющему значение атрибута
-- вложенной структуры.
SELECT *
FROM helicopter
WHERE JSON_EXTRACT(specifications, '$.engine.type') = 'turboshaft';

-- 6. Выполнить запрос, изменяющий значение по некоторому существующему ключу
-- в заданной строке таблицы.
UPDATE helicopter
SET specifications = JSON_REPLACE(specifications, '$.engine.power', '1300hp')
WHERE id = 2;