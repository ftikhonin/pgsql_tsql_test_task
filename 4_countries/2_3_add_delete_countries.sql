--4.2) Создать функции по добавлению и удалению данных.

CREATE OR REPLACE FUNCTION AddCountry(countryName VARCHAR, capitalname VARCHAR, officiallanguage VARCHAR) RETURNS VOID AS $$
        BEGIN
                INSERT INTO dbo.countries (id, NAME, capitalname, officiallanguage) VALUES (DEFAULT,countryName,capitalname,officiallanguage);
        END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION DeleteCountry(countryId OID) RETURNS VOID AS $$
        BEGIN
                DELETE FROM dbo.countries WHERE id = countryId;
        END;
$$ LANGUAGE PLPGSQL;


--4.3) Написать скрипт по добавлению/удалению данных в созданную таблицу.
SELECT * FROM AddCountry('test','test','test');

WITH myconstants (var1) AS (
   SELECT max(id) 
     FROM dbo.countries c
)

SELECT *
FROM myconstants as cc, 
DeleteCountry(cc.var1);

SELECT * FROM dbo.countries;

