USE [iRED]
GO

/****** Object:  View [dbo].[View_MetricsV2]    Script Date: 08-Sep-22 12:36:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[View_MetricsV2] AS
    SELECT
        dbo.KO_Cal.Date,
        dbo.KO_Cal.Week,
        dbo.KO_Cal.KO_Week,
        dbo.KO_Cal.Month,
        dbo.KO_Cal.Year,
        dbo.KO_Cal.KO_Month,
        dbo.View_StageMetrics.ClientCode,
        dbo.View_StageMetrics.SubClientCode,
        dbo.View_StageMetrics.CountryCode,
        dbo.View_StageMetrics.SessionStartDateTime,
        dbo.View_StageMetrics.SessionEndDateTime,
        dbo.View_StageMetrics.UserId,
        dbo.View_StageMetrics.OutletCode,
        dbo.View_StageMetrics.ProgramName,
        dbo.View_StageMetrics.ProgramItemName,
        dbo.View_StageMetrics.Template,
        dbo.View_StageMetrics.Description,
        dbo.View_StageMetrics.Value,
        dbo.View_StageMetrics.Score,
        dbo.View_StageMetrics.[Target Score],
        dbo.View_StageMetrics.[Target Value],
        dbo.View_StageMetrics.Metrics,
        dbo.View_StageMetrics.[Lattitude],
        dbo.View_StageMetrics.[Longitude]
 FROM dbo.View_StageMetrics
          INNER JOIN dbo.KO_Cal
                     ON dbo.View_StageMetrics.SessionStartDateTime = dbo.KO_Cal.Date
 WHERE dbo.View_StageMetrics.UserId NOT LIKE ''Pilot_%''
GO


