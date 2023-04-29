-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
create table student
(
	student_id serial primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	birthday date,
	phone varchar(15)
)

-- 2. Добавить в таблицу student колонку middle_name varchar
alter table student add column middle_name varchar(20)

-- 3. Удалить колонку middle_name
ALTER TABLE student
    DROP COLUMN middle_name;

-- 4. Переименовать колонку birthday в birth_date
ALTER TABLE student RENAME birthday TO birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
alter table student alter column phone set data type varchar(32)

-- 6. Вставить три любых записи с автогенерацией идентификатора
insert into student(first_name, last_name, birth_date, phone) values('alex', 'sidorov', '1991-01-15', '555555')
insert into student(first_name, last_name, birth_date, phone) values('lexa', 'lexov', '1999-01-12', '229911')
insert into student(first_name, last_name, birth_date, phone) values('petya', 'utkonosov', '1993-06-15', '990022')

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE student RESTART IDENTITY;
