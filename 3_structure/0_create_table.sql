--DROP TABLE Employee;

CREATE TABLE Employee(id INT NOT NULL IDENTITY PRIMARY KEY, first_name NVARCHAR(100), manager_id INT);

ALTER TABLE dbo.Employee
ADD CONSTRAINT FK_EMPLOYEE_REFERENCE_1_Employee FOREIGN KEY (manager_id) REFERENCES dbo.Employee (id)
GO;

INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Назаров Алексей Викторович', NULL);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Фомичева Вера Александровна', 1);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Ракова Василиса Марковна', 1);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Алексеева Кира Эмильевна', 1);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Куликова София Павловна', 2);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Попов Иван Ильич', 2);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Иванова Анна Максимовна', 3);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Игнатова Мария Павловна', 3);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Короткова Мария Кирилловна', 4);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Михайлов Александр Максимович', 4);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Рудакова Полина Владимировна', NULL);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Суханова Полина Максимовна', NULL);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Калашников Макар Иванович', 11);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Родина Алиса Владимировна', 12);
INSERT INTO dbo.Employee (first_name, manager_id)
  VALUES (N'Нестерова Екатерина Даниловна', 5);

