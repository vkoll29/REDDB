/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ClientCode]

      ,MONTH ( [SessionStartDateTime] )  [Month]
      ,[UserId]
      ,[OutletCode]

      ,[ProgramItemName]
      ,[Template]
      ,[Description]
      ,[Value]
      ,[Score]
      ,[Target Score]
      ,[Target Value]
      ,[Metrics]

      ,[SessionUid]
  FROM [iRED].[dbo].[View_StageMetrics]
  where [CountryCode]= 'ken'
  and [SessionStartDateTime] BETWEEN '2022-09-02' AND '2022-06-10'
  and Template like '%composite%'
  AND Description not like '%soci%'

  /*and [Description] in (
      SELECT [KPIDescription]
      FROM   [dbo].[KPIDescription-DC]
      WHERE [KPIDescription] IS NOT NULL
      )*/
	--AND [Value] > [Target Value]
	AND [OutletCode] = '3000232'