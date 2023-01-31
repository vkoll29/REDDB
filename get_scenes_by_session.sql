/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SessionUid]
      ,[SceneUid]
      ,[SceneDateTime]
      ,[VerifiedOn]
      ,[Source]
      ,[SceneType]
      ,[SubSceneType]
      ,[CreatedOnTime]
      ,[LastModifiedTime]
      ,[FileCreatedTime]
      ,[SliceStartTime]
      ,[SliceEndTime]
      ,[Bottler]
      ,[ReProcessedTime]
      ,[ReProcessedStatus]
  FROM [iRED].[dbo].[IRScenes]
  where SessionUid = '5022464e-5f86-44b7-8a4d-32fa2fbec8fa'

--- Dealer chiller scene is: 3b2132d9-a2f5-42fe-b347-f93e6ff91f04