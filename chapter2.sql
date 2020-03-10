CREATE TABLE IF NOT EXISTS `billing_simple`.`billing` (
  `payer_email` VARCHAR(255) NULL,
  `recipient_email` VARCHAR(255) NULL,
  `sum` DECIMAL(18,2) NULL,
  `currency` VARCHAR(3) NULL,
  `billing_date` DATE NULL,
  `comment` TEXT NULL)
ENGINE = InnoDB;

# создать бд billing_simple с таблицей billing

select *from billing 	
	where payer_email='vasya@mail.com';

#вывести из таблицы биллинг клиента с емейлом vasya@mail.ru

insert into billing values (
    'pasha@mail.com',
    'katya@mail.com',
    '300.00','EUR',
    '2016-02-14',
    'Valentines day present)');

#добавить в биллинг нового клиента 

update billing 
	set payer_email='igor@mail.com'
where  payer_email='alex@mail.com';

#Измените адрес плательщика на 'igor@mail.com' для всех записей таблицы, 
где адрес плательщика 'alex@mail.com'.

delete from billing 
where (payer_email is null or payer_email='')
    or (recipient_email is null or recipient_email='');

#Удалите из таблицы записи, где адрес плательщика или адрес получателя 
установлен в неопределенное значение или пустую строку.


#Новая таблица ( заказов )

CREATE TABLE IF NOT EXISTS `store_simple`.`store` (
  `product_name` VARCHAR(255) NULL,
  `category` VARCHAR(255) NULL,
  `price` DECIMAL(18,2) NULL,
  `sold_num` INT NULL)
ENGINE = InnoDB;

#Выведите общее количество заказов компании.

select count(1) from project;

#Выведите количество товаров в каждой категории. Результат должен содержать два столбца: 
название категории, 
количество товаров в данной категории.

select category,count(1) from store
group by category;

#Выведите 5 категорий товаров, продажи которых принесли наибольшую выручку. 
Под выручкой понимается сумма произведений стоимости товара на количество проданных единиц. 
Результат должен содержать два столбца: 
название категории,
выручка от продажи товаров в данной категории.

select
	category,
    sum(price*sold_num) as vir
from store 
group by category
order by vir desc
limit 5;

#Выведите в качестве результата одного запроса общее количество заказов, 
сумму стоимостей (бюджетов) всех проектов, средний срок исполнения заказа в днях.

NB! Для вычисления длительности проекта удобно использовать встроенную функцию datediff().

SELECT
	count(project_name),
    sum(budget),
    avg(datediff(project_finish, project_start))
FROM project;



