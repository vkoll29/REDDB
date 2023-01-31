/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Date]
      ,[Week]
      ,[KO_Week]
      ,[Month]
      ,[Year]
      ,[KO_Month]
      ,[ClientCode]
      ,[SubClientCode]
      ,[CountryCode]
      ,[UserID]
      ,[OutletCode]
      ,[ProgramName]
      ,[ProgramItemName]
      ,[Template]
      ,[Description]
      ,[Value]
      ,[Target Value]
      ,[Score]
      ,[Target Score]
      ,[Metrics]
  FROM [iRED].[dbo].[View_Metrics_new]
  where [CountryCode]= 'ken'
  and [Template] = 'Custom SOVI'
  and [Year] = 2022
  and [Month] = 8
  and [Description] in (
      SELECT [KPIDescription]
      FROM   [dbo].[KPIDescription-DC]
      WHERE [KPIDescription] IS NOT NULL
      )
  order by [Date] desc