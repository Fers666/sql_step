use project_simple;
select 
	project_start,#вывод поля
	project_finish,#вывод поля
	avg(datediff(project_finish,project_start)) as avg_days,#вывод среднего значения ( из подсчета дней с начала работ до окончания) и присвоение столбцу avg_days
    MAX(datediff(project_finish,project_start)) as max_days,# максимальное значение из дней работ
    min(datediff(project_finish,project_start)) as min_days,# минимальное значенеи из дней работ
    client_name
from project where project_finish is not null  -- условие что бы проект был закончен ( не был равен нул)
group by client_name   -групировка по клиентам ( всех их проектов) 
order by max_days desc  - сортировка 
limit 10;  - вывод только 10 элементов