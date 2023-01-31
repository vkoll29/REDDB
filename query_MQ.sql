/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SessionUid]
      ,[SceneUid]
      ,[SceneType]
      ,[SubSceneType]

      ,[ProgramItemName]

      ,[QuestionCategory]
      ,[QuestionText]
      ,[LocalQuestionText]
      ,[ParentQuestionId]
      ,[Options]
      ,[AnswerValue]

      ,[LastModifiedTime]
      ,[FileCreatedTime]
      ,[SceneLevel]
      ,[SessionLevel]
      ,[Description]

      ,[Bottler]
FROM [iRED].[dbo].[IRManualQuestions]
where [Bottler] LIKE '%CCBAKE%'
AND [FileCreatedTime] = '2022-09-06'
AND [ProgramItemName] LIKE '%Supermarket%'
AND [SessionUID] = '5022464e-5f86-44b7-8a4d-32fa2fbec8fa'
