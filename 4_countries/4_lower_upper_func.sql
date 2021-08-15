/** 
 * Функция для приведения текстовых данных в любой таблице к верхнему или нижнему регистру (опционально).
 * @param columnName - имя столбца
 * @param tableName - имя таблицы
 * @param operationType - тип операции (0 - к нижнему регистру, 1 - к верхнему регистру)
 * @author Тихонин Ф.И. <fredr7@yandex.ru>
 */
CREATE OR REPLACE FUNCTION dbo.UpperOrLowerText (columnName TEXT, tableName TEXT, operationType INT) RETURNS VOID
AS $$
  DECLARE update_statement TEXT := CASE 
                                     WHEN operationType = 0 THEN FORMAT('UPDATE dbo.%s SET %s = LOWER(c.%s) FROM dbo.%s c', tableName, columnName, columnName, tableName)
                                     WHEN operationType = 1 THEN FORMAT('UPDATE dbo.%s SET %s = UPPER(c.%s) FROM dbo.%s c', tableName, columnName, columnName, tableName)
                                   END;
  BEGIN
    EXECUTE update_statement;
end;
$$
LANGUAGE PLPGSQL;


--Соберём все таблицы и столбцы
CREATE TEMP TABLE cols (
  column_name NAME,
  table_name NAME
);

INSERT INTO cols
  SELECT
    col.column_name,
    col.table_name
  FROM information_schema.columns col
    JOIN information_schema.tables tab
      ON tab.table_schema = col.table_schema
      AND tab.table_name = col.table_name
      AND tab.table_type = 'BASE TABLE'
  WHERE col.data_type IN ('character varying', 'character',
  'text', '"char"', 'name')
  AND col.table_schema NOT IN ('information_schema', 'pg_catalog')
  ORDER BY col.table_schema,
  col.table_name,
  col.ordinal_position;

SELECT
  *
FROM cols,
     dbo.UpperOrLowerText(cols.column_name, cols.table_name, 0); -- к нижнему регистру

SELECT
  *
FROM dbo.countries c;

SELECT
  *
FROM cols,
     dbo.UpperOrLowerText(cols.column_name, cols.table_name, 1); -- к верхнему регистру

SELECT
  *
FROM dbo.countries c