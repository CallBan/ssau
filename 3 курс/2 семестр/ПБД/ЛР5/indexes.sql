-- Найти информацию по заданному исполнителю, используя его имя
select * from artist
where name = 'Stereo People';

-- Найти всех участников указанного музыкального коллектива (по
-- названию коллектива).
SELECT a.*
FROM artist AS a
JOIN `group` AS g ON a.ARTIST_ID = g.GROUP_ARTIST_ID
JOIN artist AS main_artist ON main_artist.ARTIST_ID = g.MAIN_ARTIST_ID
WHERE main_artist.NAME = 'Toka Project';

-- Найти всех исполнителей, в описании (профиле) которых встречается
-- указанное выражение, с использованием полнотекстового запроса.
ALTER TABLE artist ADD FULLTEXT(PROFILE);
SELECT *
FROM artist
WHERE MATCH (PROFILE) AGAINST
('rapper');

-- Оценивается время выполнения запросов. 
-- 5.938 sec
-- 232.156 sec
-- 204.594 sec

-- Анализируется план выполнения запросов. 
explain select * from artist where name = 'Stereo People';
explain SELECT a.*
FROM artist AS a
JOIN `group` AS g ON a.ARTIST_ID = g.GROUP_ARTIST_ID
JOIN artist AS main_artist ON main_artist.ARTIST_ID = g.MAIN_ARTIST_ID
WHERE main_artist.NAME = 'Toka Project';
explain SELECT *
FROM artist
WHERE MATCH (PROFILE) AGAINST
('rapper');

-- Создаются необходимые индексы для повышения быстродействия запросов.
-- Выполнение запроса должно исключать полное сканирование таблицы
-- (отсутствие Table Scan в анализе запроса). 
create index idx_artist_id on artist(artist_id);
create index idx_name on artist(name);
create fulltext index idx_profile on artist(profile);
create index idx_group_artist_id on `group`(group_artist_id);
create index idx_released on `release`(released);
create index idx_release_id on `release`(release_id);
create index idx_release_id on `release_artist`(release_id);
create index idx_release_artist_id on `release_artist`(release_artist_id);

-- 1. Найти информацию по заданному исполнителю, используя его имя
select * from artist
where name = 'Stereo People';

-- 2. Найти всех участников указанного музыкального коллектива (по
-- названию коллектива).
SELECT *
FROM artist 
JOIN `group` ON artist.ARTIST_ID = `group`.GROUP_ARTIST_ID
JOIN artist AS main_artist ON main_artist.ARTIST_ID = `group`.MAIN_ARTIST_ID
WHERE main_artist.NAME = 'Skillet';


-- 3. Найти все релизы заданного исполнителя и отсортировать их по дате выпуска.
-- Вывести имя исполнителя, название релиза, дату выхода. 
select distinct artist.NAME, `release`.title, `release`.RELEASED  
from `release`
join `release_artist` on `release_artist`.RELEASE_ID = `release`.RELEASE_ID
join artist on artist.ARTIST_ID = `release_artist`.ARTIST_ID
where artist.NAME = 'Stereo People'
order by `release`.RELEASED;

-- 4. Найти все главные релизы, выпущенные в указанный год, с указанием стиля
-- релиза. Релиз является главным, если поле release.IS_MAIN_RELEASE = 1. 
select * from `release`
join style on style.RELEASE_ID = `release`.RELEASE_ID
where year(`release`.RELEASED) = 2005 and style.STYLE_NAME = 'Techno' and `release`.IS_MAIN_RELEASE = 1;

-- 5. Найти всех исполнителей, в описании (профиле) которых встречается
-- указанное выражение, с использованием полнотекстового запроса.
ALTER TABLE artist ADD FULLTEXT(PROFILE);
SELECT *
FROM artist
WHERE MATCH (PROFILE) AGAINST
('rapper');

