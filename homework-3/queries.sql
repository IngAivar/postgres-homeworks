-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select company_name as customer, CONCAT(first_name, ' ', last_name) as employee
from orders
join customers using (customer_id)
join employees using (employee_id)
where exists (select 1 from shippers 
              where orders.ship_via=shippers.shipper_id 
              and shippers.company_name = 'United Package')  
              and customers.city = 'London' 
              and employees.city = 'London'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, contact_name, phone
from products
join suppliers using (supplier_id)
where exists (select 1 from categories 
              where categories.category_id=products.category_id 
              and categories.category_name in ('Dairy Products', 'Condiments')) 
              and products.units_in_stock < 25 
              and products.discontinued = 0
order by units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name
from customers
where not exists (select 1 from orders 
				  where orders.customer_id=customers.customer_id)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT product_name
FROM products
WHERE product_id = ANY (SELECT product_id
					    FROM order_details
					    WHERE quantity = 10)
