/**
 * Функция возвращает все дочерние элементы определенного узла
 * 
 * @author Тихонин Ф.И. <fredr7@yandex.ru>
 */
CREATE FUNCTION dbo.GetAllChildByParent(
@managerId INT
)
RETURNS @result TABLE 
(
    id INT
   ,first_name NVARCHAR(100)
   ,lvl INT
   ,manager_name NVARCHAR(100)
)
AS
BEGIN
  DECLARE @lvl INT = 1; --Уровень в иерархии

  --Заполним таблицу родительским элементом
  INSERT INTO @result (id, first_name, lvl)
  SELECT e.id
        ,e.first_name
        ,0  
  FROM dbo.Employee e
  WHERE e.id = @managerId;
  
  --Будем искать до тех пор, пока не дойдем до последнего уровня
  WHILE EXISTS (SELECT 1
                  FROM dbo.Employee e
                  JOIN @result hc ON hc.id = e.manager_id
                  LEFT JOIN @result hd ON hd.id = e.id
                  WHERE hd.id IS NULL)
  BEGIN
  
    INSERT INTO @result (id, first_name, lvl, manager_name)
    SELECT e.id
          ,e.first_name
          ,@lvl
          ,hc.first_name
    FROM dbo.Employee e
    JOIN @result hc ON hc.id = e.manager_id
    LEFT JOIN @result hd ON hd.id = e.id
    WHERE hd.id IS NULL
    
    SET @lvl += 1;
  
  END;

  --Не будем выводить родительский узел
  DELETE FROM @result
  WHERE lvl = 0;

  RETURN;
END;
GO
