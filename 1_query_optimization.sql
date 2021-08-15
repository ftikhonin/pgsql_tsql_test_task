DECLARE @p1 NVARCHAR(4000) = N'ф%'
       ,@p2 NVARCHAR(4000) = N'к%'
       ,@p3 NVARCHAR(4000) = N'423'; --А зачем тут 4000 символов? :)

--Скалярные функции вынести в отдельную переменную
DECLARE @region INT = dbo.GetRegion();
DECLARE @tzGetDate DATE = dbo.tzGetDate();

--предварительно соберем всех "персон"
IF OBJECT_ID('tempdb..#persons') IS NOT NULL
  DROP TABLE #persons;

CREATE TABLE #persons(person_id INT NOT NULL PRIMARY KEY);
INSERT INTO #persons
SELECT p.person_id
FROM tmp.person(NOLOCK) p
WHERE ISNULL(p.person_deleted, 1) = 1
  AND p.Person_updDT <= @tzGetDate;


SELECT PersonSurName_SurName
      ,PersonFirName_FirName
      ,PersonSecName_SecName
      ,PersonBirthDay_BirthDay
      --Если не будет достигнута желаемая производительность - можно попробовать вынести сбор полей work.Org_Nick, PersonCard_Code 
      --в отдельный UPDATE(предварительно собрав остальные данные (PersonSurName_SurName, PersonFirName_FirName и тд) в временную таблицу
      ,work.Org_Nick
      ,PersonCard_Code
FROM #persons p
LEFT JOIN tmp.personstate(nolock) ps ON p.person_id = ps.person_id
OUTER APPLY (
      SELECT TOP 1
        o.Org_Nick
      FROM dbo.org(NOLOCK) o --в зависимости от объема данных можно попробовать поменять порядок таблиц в запросе(начать запрос с dbo.job)
      INNER JOIN dbo.job(nolock) j ON j.org_id = o.org_id
                                  AND j.job_id = ps.job_id
      WHERE ISNULL(o.Region_id, @region) = @region      
      ORDER BY o.Org_endDate DESC
) work
OUTER APPLY (
      SELECT TOP 1
        PersonCard_Code --вывожу только необходимые столбцы
      FROM v_PersonCard PC WITH (NOLOCK)
      WHERE PC.Person_id = PS.Person_id
      AND PC.Lpu_id = @P3
      ORDER BY LpuAttachType_id
) PersonCard
WHERE ps.sex_id = 2
  AND (ps.PersonSurName_SurName LIKE @p1
  OR ps.PersonSurName_SurName LIKE @p2)
ORDER BY PersonSurName_SurName, PersonFirName_FirName, PersonSecName_SecName;