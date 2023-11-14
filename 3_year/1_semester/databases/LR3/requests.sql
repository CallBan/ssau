-- 1) вывести группы, в которых студенты не получают стипендии
-- select distinct students_group.group_id as 'Номер группы'
-- from student, session_result, students_group
-- where session_result.category_id in (1, 2) and student.student_id = session_result.student_id 
-- and student.group_id = students_group.group_id;

-- 2) выбрать всех студентов, обучающихся по целевым договорам, сдавших на 3
-- или вообще не сдавших сессию, по группам
-- select distinct students_group.group_id as 'Номер группы', student.student_id as 'id', student.full_name as 'ФИО'
-- from student, students_group, contract, session_result
-- where contract.type = 'Целевое' and contract.student_id = student.student_id
-- and student.student_id = session_result.student_id and session_result.category_id in (1, 2)
-- and student.group_id = students_group.group_id
-- order by students_group.group_id;

-- 3) выбрать всех студентов, сдавших сессию на 5, по группам
-- select distinct students_group.group_id as 'Номер группы', student.full_name as 'ФИО'
-- from student, session_result, students_group
-- where session_result.category_id = 5 and session_result.student_id = student.student_id and student.group_id = students_group.group_id
-- order by students_group.group_id;

-- 4) подсчитать сумму стипендий студентов по курсам
-- select student.year as "Курс", sum(category.scholarship) as "Сумма стипендии"
-- from student, session_result, category
-- where student.student_id = session_result.student_id and session_result.category_id = category.category_id
-- group by student.year order by student.year;

-- 5) вывести размер назначенной стипендии студентов, обучающихся по целевым
-- договорам, по предприятиям
-- select distinct contract.company as "Предприятие", student.full_name as "ФИО", category.scholarship as "Стипендия"
-- from student, contract, category, session_result
-- where contract.student_id = student.student_id and student.student_id = session_result.student_id
-- and session_result.category_id = category.category_id and contract.type = "Целевое" order by contract.company;


-- 6) подсчитать сумму стипендий по группам
select students_group.group_id as "Номер группы", sum(category.scholarship) as "Сумма стипендии"
from student, students_group, category, session_result
where student.student_id = session_result.student_id and session_result.category_id = category.category_id and student.group_id = students_group.group_id
group by student.group_id order by students_group.group_id;
