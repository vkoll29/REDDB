USE [iRED]
GO

/****** Object:  View [dbo].[View_ActualsStage2]    Script Date: 16-Sep-22 8:50:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER VIEW [dbo].[View_ActualsStage2]
AS
SELECT        dbo.SessionsWtTimeStamp.ClientCode,
              dbo.SessionsWtTimeStamp.SubClientCode,
              dbo.SessionsWtTimeStamp.SessionUid,
              dbo.IRScenes.SceneUid,
              CAST(dbo.SessionsWtTimeStamp.SessionStartDateTime AS DATE)SessionStartDateTime,
              CAST(dbo.SessionsWtTimeStamp.SessionEndDateTime AS DATE)SessionEndDateTime,
              dbo.SessionsWtTimeStamp.UserId,
              dbo.SessionsWtTimeStamp.OutletCode,
              dbo.IRScenes.SceneType,
              dbo.IRScenes.SubSceneType,
              dbo.[View_ActualInventoryStage].ProductId,
              dbo.[View_ActualInventoryStage].DoorIndex,
              dbo.[View_ActualInventoryStage].InventoryUnit,
              dbo.[View_ActualInventoryStage].Price,
              dbo.SessionsWtTimeStamp.CountryCode,
              dbo.SessionsWtTimeStamp.UserId AS UserProfile
FROM          dbo.IRScenes
INNER JOIN    dbo.SessionsWtTimeStamp
ON dbo.IRScenes.SessionUid = dbo.SessionsWtTimeStamp.SessionUid
INNER JOIN    [dbo].[View_ActualInventoryStage]
ON dbo.SessionsWtTimeStamp.SessionUid = dbo.[View_ActualInventoryStage].SessionUid
where dbo.SessionsWtTimeStamp.SessionUid Not like 'Pilot%'
AND dbo.SessionsWtTimeStamp.CountryCode='KEN'
GO


