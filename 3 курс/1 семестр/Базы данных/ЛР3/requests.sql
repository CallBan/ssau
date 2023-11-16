-- 1) вывести группы, в которых студенты не получают стипендии
 select distinct students_group.group_id as 'Номер группы'
 from student, session_result, students_group
 where session_result.category_id in (1, 2) and student.student_id = session_result.student_id 
 and student.group_id = students_group.group_id;

-- 2) выбрать всех студентов, обучающихся по целевым договорам, сдавших на 3
-- или вообще не сдавших сессию, по группам
 select distinct students_group.group_id as 'Номер группы', student.student_id as 'id', student.full_name as 'ФИО'
 from student, students_group, contract, session_result
 where contract.type = 'Целевое' and contract.student_id = student.student_id
 and student.student_id = session_result.student_id and session_result.category_id in (1, 2)
 and student.group_id = students_group.group_id
 order by students_group.group_id;

-- 3) выбрать всех студентов, сдавших сессию на 5, по группам
 select distinct students_group.group_id as 'Номер группы', student.full_name as 'ФИО'
 from student, session_result, students_group
 where session_result.category_id = 5 and session_result.student_id = student.student_id and student.group_id = students_group.group_id
 order by students_group.group_id;

-- 4) подсчитать сумму стипендий студентов по курсам
 select student.year as "Курс", sum(category.scholarship) as "Сумма стипендии"
 from student, session_result, category
 where student.student_id = session_result.student_id and session_result.category_id = category.category_id
 group by student.year order by student.year;

-- 5) вывести размер назначенной стипендии студентов, обучающихся по целевым
-- договорам, по предприятиям
select distinct contract.company as "Предприятие", student.full_name as "ФИО", category.scholarship as "Стипендия"
from student, contract, category, session_result
where contract.student_id = student.student_id and student.student_id = session_result.student_id
and session_result.category_id = category.category_id and contract.type = "Целевое" order by contract.company;


-- 6) подсчитать сумму стипендий по группам
select students_group.group_id as "Номер группы", sum(category.scholarship) as "Сумма стипендии"
from student, students_group, category, session_result
where student.student_id = session_result.student_id and session_result.category_id = category.category_id and student.group_id = students_group.group_id
group by student.group_id order by students_group.group_id;


-- вывод групп, в которых сумма стипендий студентов больше 3000 за 5 семестр
select student.group_id, sum(category.scholarship)
from student 
join session_result on student.student_id = session_result.student_id
join category on session_result.category_id = category.category_id
group by student.group_id, session_result.semester
having session_result.semester = 5 and sum(category.scholarship) > 3000;

-- вывод студентов, сдавших сессию ( для целевиков - ещё и вывод предприятия)
select student.full_name, contract.company
from student
join session_result on student.student_id = session_result.student_id
join category on session_result.category_id = category.category_id
join contract on student.student_id = contract.student_id
where session_result.semester = 5 and category.category_id between 2 and 5;

-- вывод студентов без контракта
select  *
from student s left join contract ct on ct.student_id = s.student_id
where contract_id is null;

-- вывод Id студентов-целевиков и id студентов, не сдавших сессию
select student.student_id AS 'id' 
from student 
join contract on student.student_id = contract.student_id
where contract.company IS NOT NULL 
UNION select student.student_id 
from student
join session_result on student.student_id = session_result.student_id
join category on session_result.category_id = category.category_id
where category.category_id IN (0,1);

-- вывод студентов из определенной группы
select student.full_name as 'ФИО' 
from student 
where exists(select * from students_group
where student.group_id = students_group.group_id and students_group.group_id = 1);


-- вывод студентов-бюджетников, у которых стипендия больше, чем у всех студентов-платников
select student.full_name AS 'ФИО', category.scholarship AS 'Стипендия' 
from student, category, contract, session_result
where student.student_id = contract.student_id and contract.type = 'Бюджет' and
student.student_id = session_result.student_id and session_result.category_id = category.category_id
and category.scholarship > all (
select category.scholarship 
from student, session_result, category
where student.student_id = session_result.student_id and session_result.category_id = category.category_id);

-- вывод студентов-бюджетников, у которых стипендия больше, чем у какого либо студента-платника
select student.full_name AS 'ФИО', category.scholarship AS 'Стипендия' 
from student, category, contract, session_result
where student.student_id = contract.student_id and contract.type = 'Бюджет' and
student.student_id = session_result.student_id and session_result.category_id = category.category_id
and category.scholarship > any (
select category.scholarship 
from student, session_result, category
where student.student_id = session_result.student_id and session_result.category_id = category.category_id);