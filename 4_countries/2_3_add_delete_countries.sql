--4.2) Создать функции по добавлению и удалению данных.

CREATE OR REPLACE FUNCTION addCountry(countryName VARCHAR, capitalname VARCHAR, officiallanguage VARCHAR) RETURNS VOID AS $$
        BEGIN
                INSERT INTO dbo.countries (id, NAME, capitalname, officiallanguage) VALUES (DEFAULT,countryName,capitalname,officiallanguage);
        END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION DeleteCountry(countryId OID) RETURNS VOID AS $$
        BEGIN
                DELETE FROM dbo.countries WHERE id = countryId;
        END;
$$ LANGUAGE plpgsql;


--4.3) Написать скрипт по добавлению/удалению данных в созданную таблицу.
SELECT * FROM addCountry('test','test','test');

WITH myconstants (var1) AS (
   SELECT max(id) 
     FROM dbo.countries c
)

SELECT *
FROM myconstants as cc, 
DeleteCountry(cc.var1);

SELECT * FROM dbo.countries;

