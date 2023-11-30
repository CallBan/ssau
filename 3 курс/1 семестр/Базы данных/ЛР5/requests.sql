-- ПРЕДСТАВЛЕНИЯ
-- 1. Создать два не обновляемых представления, возвращающих пользователю
-- результат из нескольких таблиц, с разными алгоритмами обработки представления.

-- Первое необновляемое представление
create algorithm=merge view ViewStudentContract
as select student.full_name as "Студент", contract.type as "Форма обучения"
from student
join contract on student.student_id =  contract.student_id;

select * from ViewStudentContract;

-- Второе необновляемое представление
create algorithm=temptable view ViewYearScholarship
as select student.year as "Курс", sum(category.scholarship) as "Сумма стипендии"
from student
join session_result on student.student_id = session_result.student_id
join category on session_result.category_id = category.category_id
group by student.year order by student.year;

select * from ViewYearScholarship;

-- 2. Создать обновляемое представление, не позволяющее выполнить команду INSERT.
create view ViewScholarship(category_name, category_scholarship)
as select category.name, category.scholarship
from category;

select * from ViewScholarship;

insert into ViewScholarship(category_name, category_scholarship) value
("Социальная", 3400);

drop view ViewScholarship;
-- 3. Создать обновляемое представление, позволяющее выполнить команду INSERT.
create view ViewScholarship(category_id, category_name, category_scholarship)
as select category.category_id, category.name, category.scholarship
from category;

select * from ViewScholarship;

insert into ViewScholarship(category_id, category_name, category_scholarship) value
(6, "Социальная", 3400);

-- 4. Создать вложенное обновляемое представление с проверкой ограничений (WITH CHECK OPTION). 
create view ViewStudent(student_id, full_name, year, group_id)
as select student.student_id, student.full_name, student.year, student.group_id
from student
where year = 1
with check option;

select * from ViewStudent;

insert into ViewStudent(student_id, full_name, year, group_id) value
	(32, "Шевелев Павел Тимурович", 2, 2);

select * from student;
    
-- ТРАНЗАКЦИИ
-- 5. Выберите любую таблицу, созданную в предыдущих лабораторных работах.
-- Создайте транзакцию, произведите ее откат и фиксацию:
select * from category;
set SQL_SAFE_UPDATES = 0;
-- a. Отключите режим автоматического завершения;
set AUTOCOMMIT = 0;
start transaction;
-- b. Добавьте в выбранную таблицу новые записи, проверьте добавились ли они;
update category
set scholarship =  4000
where scholarship =  3600;
select * from category;
-- c. Произведите откат транзакции, т. е. отмену произведенных действий;
rollback;
-- d. Откатите транзакцию оператором ROLLBACK(изменения не сохранились);
select * from category;
-- e. Воспроизведите транзакцию и сохраните действия оператором COMMIT.
start transaction;
update category
set scholarship =  4000
where scholarship =  3600;
commit;
select * from category;

-- 6. Продемонстрировать возможность чтения незафиксированных изменений при
-- использовании уровня изоляции READ UNCOMMITTED и отсутствие такой
-- возможности при уровне изоляции READ COMMITTED.

-- Пример с READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

select * from category;

update category
set scholarship =  3000
where scholarship =  4000;

select * from category;

ROLLBACK;

-- Пример с READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

select * from category;

update category
set scholarship =  3000
where scholarship =  4000;

select * from category;

ROLLBACK;

-- 7. Продемонстрировать возможность записи в уже прочитанные данные при
-- использовании уровня изоляции READ COMMITTED и отсутствие такой
-- возможности при уровне изоляции REPEATABLE READ. 

-- Пример с READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

select * from category;

insert into category(category_id, name, scholarship) value
(7, "Суперсоциальная", 34000);

select * from category;

commit;

delete from category where category_id = 7;

-- Пример с REPEATABLE READ. 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

select * from category;

insert into category(category_id, name, scholarship) value
(7, "Суперсоциальная", 34000);

select * from category;

commit;
