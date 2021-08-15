
--4.5) Создать обычное и материализованное представление для созданной таблицы.
CREATE MATERIALIZED VIEW countriesmatview AS SELECT * FROM dbo.countries;
CREATE VIEW countriesview AS SELECT * FROM dbo.countries;

SELECT * FROM countriesmatview;
SELECT * FROM countriesview;

--4.6) Провести выборку oid, наименования схем и наименование созданных объектов
SELECT oid 
  FROM pg_class 
  WHERE relname = 'countries';

SELECT schema_name 
FROM information_schema.schemata;

SELECT * 
  FROM pg_attribute
  WHERE attrelid = (SELECT oid FROM pg_class WHERE relname = 'countries');


