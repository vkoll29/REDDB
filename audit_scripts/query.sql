/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [Date]
      ,[SessionUID]
      ,[SceneUID]
      ,[ClientCode]
      ,[UserId]
      ,[OutletCode]
      ,[ProgramItemName]
      ,[Description]
      ,[Value]
      ,[Score]
      ,[Target Score]
      ,[Target Value],
       row_number() over (partition by [SessionUid], [SceneUid]) dup

  FROM [iRED].[dbo].[View_MetricsV2_wt_UID]
  where [Date] >= '2022-03-01'

  order by [SessionUid], [SceneUid]