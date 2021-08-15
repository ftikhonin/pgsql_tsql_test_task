CREATE SEQUENCE Countries_seq
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;


CREATE TABLE dbo.Countries (
  id OID PRIMARY KEY DEFAULT NEXTVAL('Countries_seq'),
  name VARCHAR NOT NULL,
  capitalName VARCHAR NOT NULL,
  officialLanguage VARCHAR DEFAULT 'Английский'
);

INSERT INTO dbo.countries (id, name, capitalname, officiallanguage)
  VALUES (DEFAULT, 'Австралия', 'Канберра', DEFAULT);
INSERT INTO dbo.countries (id, name, capitalname, officiallanguage)
  VALUES (DEFAULT, 'Австрия', 'Канберра', 'Немецкий');
INSERT INTO dbo.countries (id, name, capitalname, officiallanguage)
  VALUES (DEFAULT, 'Азербайджан', 'Канберра', 'Азербайджанский');
INSERT INTO dbo.countries (id, name, capitalname, officiallanguage)
  VALUES (DEFAULT, 'Албания', 'Канберра', 'Албанский');
INSERT INTO dbo.countries (id, name, capitalname, officiallanguage)
  VALUES (DEFAULT, 'Алжир', 'Канберра', 'Арабский');