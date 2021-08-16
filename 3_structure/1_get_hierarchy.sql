SELECT * 
FROM dbo.Employee e

--все дочерние элементы определенного узла
DECLARE @manager_id INT = 4
SELECT *
FROM GetAllChildByParent(@manager_id);


--все подчиненные элементы для произвольного узла самого верхнего уровня
SELECT TOP 1 @manager_id = e.id
FROM dbo.Employee e
WHERE e.manager_id IS NULL --если нет manager_id - значит это элемент самого высокого уровня
ORDER BY NEWID();

SELECT *
FROM GetAllChildByParent(@manager_id);

--все подчиненные элементы для произвольного узла самого верхнего уровня
SELECT TOP 1 @manager_id = e.id
FROM dbo.Employee e
ORDER BY NEWID();

SELECT *
FROM GetAllChildByParent(@manager_id);
