Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). 
Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. 
В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), 
скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), 
скорость считывающего устройства - cd (например, '4x') и цена - price. Таблица Laptop аналогична таблице РС за исключением того, 
что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, 
является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.

Задание 1:
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd
Решение:
Select model,speed,hd from pc where price<500

Задание 2:
Найдите производителей принтеров. Вывести: maker
Решение:
Select maker from product where type='printer' group by maker

Задание 3:
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
Решение:
Select model,ram,screen from laptop where price>1000;

Задание 4:
Найдите все записи таблицы Printer для цветных принтеров.
Решение:
Select *from printer where color='y'

Задание 5:
Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
Решений: 
Select model,speed,hd from pc where (cd='12x' or cd='24x') and (price<600)
Задание 6:
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
Решений: 
SELECT distinct product.maker,laptop.speed 
from product join laptop on product.model=laptop.model and laptop.hd>=10;

тоже самое с использованием альянсов

SELECT DISTINCT p.maker,l.speed
FROM product as p JOIN laptop as l on p.model=l.model and l.hd>=10;

Задание 7 :
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
Решений: 
SELECT pc.model,pc.price 
FROM pc JOIN product on pc.model=product.model WHERE maker='B'
UNION 
SELECT laptop.model,laptop.price
FROM laptop JOIN product ON laptop.model=product.model WHERE maker='B'
UNION 
SELECT printer.model,printer.price 
FROM printer JOIN product ON printer.model=product.model WHERE maker='B';

Задание 8 :
Найдите производителя, выпускающего ПК, но не ПК-блокноты.
Решений: 
SELECT DISTINCT maker 
FROM product WHERE type='PC' and maker NOT IN (SELECT maker FROM product WHERE type='laptop');

Задание 9 :
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
Решений: 
SELECT DISTINCT maker 
FROM product JOIN pc on product.model=pc.model WHERE pc.speed>=450;

Задание 10:
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
Решений: 
SELECT model,price 
FROM printer where price=(SELECT max(price) FROM printer);

Задание 11:
Найдите среднюю скорость ПК.
Решений: 
SELECT AVG(speed) 
FROM pc;

Задание 12 :
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
Решений: 
SELECT AVG(speed) 
FROM laptop where laptop.price>1000;

Задание 13:
Найдите среднюю скорость ПК, выпущенных производителем A.
Решений: 
SELECT AVG(speed) 
FROM pc JOIN product ON pc.model=product.model WHERE product.maker='A';


Рассматривается БД кораблей, участвовавших во второй мировой войне. Имеются следующие отношения:
Classes (class, type, country, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
Корабли в «классах» построены по одному и тому же проекту, и классу присваивается либо имя первого корабля, построенного по данному проекту, либо названию класса дается имя проекта, которое не совпадает ни с одним из кораблей в БД. Корабль, давший название классу, называется головным.
Отношение Classes содержит имя класса, тип (bb для боевого (линейного) корабля или bc для боевого крейсера), страну, в которой построен корабль, число главных орудий, калибр орудий (диаметр ствола орудия в дюймах) и водоизмещение ( вес в тоннах). В отношении Ships записаны название корабля, имя его класса и год спуска на воду. В отношение Battles включены название и дата битвы, в которой участвовали корабли, а в отношении Outcomes – результат участия данного корабля в битве (потоплен-sunk, поврежден - damaged или невредим - OK).
Замечания. 1) В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships. 2) Потопленный корабль в последующих битвах участия не принимает.

Задание 14 :
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
Решений: 
SELECT classes.class,ships.name,classes.country 
FROM classes JOIN ships ON classes.class=ships.class WHERE numGuns>=10;

Задание 15:
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
Решений: 
Select hd 
FROM pc GROUP BY(hd) HAVING COUNT(model)>=2;

Задание 16:
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), 
но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
Решений: 
SELECT DISTINCT p1.model,p2.model,p1.speed,p1.ram
FROM pc as p1,pc as p2 
WHERE p1.speed=p2.speed and p1.ram=p2.ram and p1.model >p2.model


Задание 17:
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed
Решений: 
SELECT DISTINCT p.type,l.model,l.speed
FROM laptop AS l JOIN product AS p ON l.model=p.model 
WHERE l.speed<(SELECT MIN(speed) FROM pc)

Задание 18:
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
Решений: 
SELECT DISTINCT product.maker, printer.price
FROM product, printer
WHERE product.model = printer.model
AND printer.color = 'y'
AND printer.price = (SELECT MIN(price) FROM printer WHERE printer.color = 'y') 

Задание 19:
Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.
Решений: 
SELECT p.maker,avg(screen)
FROM laptop AS l JOIN product AS p ON l.model=p.model 
GROUP BY (p.maker)

Задание 20:
Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
Решений: 
SELECT maker,count(model)
FROM product 
WHERE type='pc'
GROUP BY product.maker
HAVING count(model)>=3

Задание 21:
Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.
Решений: 
SELECT p.maker,max(price)
FROM product AS p JOIN pc ON p.model=pc.model
GROUP BY p.maker

Задание 22:
Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.
Решений: 
SELECT speed,avg(price)
FROM pc 
WHERE pc.speed>600
GROUP BY pc.speed

Задание 23:
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker
Решений: 
SELECT DISTINCT maker 
FROM product 
WHERE model IN (SELECT model FROM PC WHERE speed >= 750) 
OR model IN (SELECT model FROM Laptop WHERE speed >= 750)

Задание 24:
Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.
Решений: 
WITH max_type AS 
(SELECT model,price FROM pc WHERE price=(SELECT max(price) FROM pc) 
UNION 
SELECT model,price FROM laptop WHERE price=(SELECT max(price) FROM laptop) 
UNION 
SELECT model,price FROM printer WHERE price=(SELECT max(price) FROM printer)
)
SELECT model FROM max_type WHERE price=(SELECT max(price) FROM max_type)

Задание:
Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
Решений: 
SELECT DISTINCT maker 
FROM product 
WHERE model IN (SELECT model FROM pc 
                WHERE ram=(SELECT min(ram) FROM pc) 
                AND 
                speed=(SELECT max(speed) FROM pc WHERE ram=(SELECT min(ram) FROM pc ))
                )
            AND maker IN (SELECT maker FROM product WHERE type='printer')

Задание:
Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.
Решений: 
WITH avg_price AS
(
SELECT model,price 
FROM pc where model IN(SELECT model FROM product WHERE maker='A')
UNION 
SELECT model,price 
FROM laptop WHERE model IN (SELECT model FROM product WHERE maker='A')
)
SELECT avg(price) 
FROM avg_price

ВТОРОЙ ВАРИАНТ РЕШЕНИЯ 
SELECT avg(price) 
FROM ( 
    SELECT pc.model,price 
    FROM pc 
    WHERE model IN (
        SELECT model 
        FROM product WHERE maker='a'
    )
    UNION 
    SELECT laptop.model,price 
    FROM laptop WHERE model IN 
    ( 
    SELECT model     
    FROM product WHERE maker='a'
    )
) table_name;

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 

Задание:

Решений: 


