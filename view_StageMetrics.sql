USE [iRED]
GO

/****** Object:  View [dbo].[View_StageMetrics]    Script Date: 21-Aug-22 12:51:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_StageKEMetricsAug] AS SELECT * FROM (

SELECT
	dbo.SessionsWtTimeStamp.ClientCode,
	dbo.SessionsWtTimeStamp.SubClientCode,
	dbo.SessionsWtTimeStamp.CountryCode,
	CAST ( dbo.SessionsWtTimeStamp.SessionStartDateTime AS DATE ) SessionStartDateTime,
	CAST ( dbo.SessionsWtTimeStamp.SessionEndDateTime AS DATE ) SessionEndDateTime,
	dbo.SessionsWtTimeStamp.UserId,
	dbo.SessionsWtTimeStamp.OutletCode,
	dbo.KE_Metrics.ProgramId,
	ltrim(
	[dbo].[ClearNumericCharacters] ( dbo.KE_Metrics.ProgramName )) ProgramName,
	dbo.KE_Metrics.ProgramItemId,
	ltrim(
	[dbo].[ClearNumericCharacters] ( dbo.KE_Metrics.ProgramItemName )) ProgramItemName,
	dbo.KE_Metrics.Template,
	dbo.KE_Metrics.Description,
	dbo.KE_Metrics.Value,
	dbo.KE_Metrics.Score,
	dbo.KE_Metrics.[Target Score],
	dbo.KE_Metrics.[Target Value],
	dbo.KE_Metrics.Metrics,
	dbo.SessionsWtTimeStamp.[Lattitude],
	dbo.SessionsWtTimeStamp.[Longitude] ,
		dbo.SessionsWtTimeStamp.SessionUid
FROM
	dbo.KE_Metrics
	INNER JOIN dbo.SessionsWtTimeStamp ON CONCAT (
		dbo.KE_Metrics.SessionUid,
		dbo.KE_Metrics.Bottler
		) = CONCAT (
		dbo.SessionsWtTimeStamp.SessionUid ,
		dbo.SessionsWtTimeStamp.Bottler
	)
WHERE
	dbo.SessionsWtTimeStamp.SessionUid NOT LIKE 'Pilot_%'
	EXCEPT
SELECT
	dbo.SessionsWtTimeStamp.ClientCode,
	dbo.SessionsWtTimeStamp.SubClientCode,
	dbo.SessionsWtTimeStamp.CountryCode,
	dbo.SessionsWtTimeStamp.SessionStartDateTime,
	dbo.SessionsWtTimeStamp.SessionEndDateTime,
	dbo.SessionsWtTimeStamp.UserId,
	dbo.SessionsWtTimeStamp.OutletCode,
	dbo.KE_Metrics.ProgramId,
	ltrim(
	[dbo].[ClearNumericCharacters] ( dbo.KE_Metrics.ProgramName )) ProgramName,
	dbo.KE_Metrics.ProgramItemId,
	ltrim(
	[dbo].[ClearNumericCharacters] ( dbo.KE_Metrics.ProgramItemName )) ProgramItemName,
	dbo.KE_Metrics.Template,
	dbo.KE_Metrics.Description,
	dbo.KE_Metrics.Value,
	dbo.KE_Metrics.Score,
	dbo.KE_Metrics.[Target Score],
	dbo.KE_Metrics.[Target Value],
	dbo.KE_Metrics.Metrics,
	dbo.SessionsWtTimeStamp.[Lattitude],
	dbo.SessionsWtTimeStamp.[Longitude],
	dbo.SessionsWtTimeStamp.SessionUid
FROM
	dbo.KE_Metrics
	INNER JOIN dbo.SessionsWtTimeStamp ON CONCAT (
		dbo.KE_Metrics.SessionUid,
		dbo.KE_Metrics.Bottler
		) = CONCAT (
		dbo.SessionsWtTimeStamp.SessionUid ,
		dbo.SessionsWtTimeStamp.Bottler
	)
WHERE
	dbo.KE_Metrics.SessionUid = 'd2ce4dcc-d93c-40e3-a450-d0657d6d9537'
	EXCEPT
SELECT
	dbo.SessionsWtTimeStamp.ClientCode,
	dbo.SessionsWtTimeStamp.SubClientCode,
	dbo.SessionsWtTimeStamp.CountryCode,
	dbo.SessionsWtTimeStamp.SessionStartDateTime,
	dbo.SessionsWtTimeStamp.SessionEndDateTime,
	dbo.SessionsWtTimeStamp.UserId,
	dbo.SessionsWtTimeStamp.OutletCode,
	dbo.KE_Metrics.ProgramId,
	ltrim(
	[dbo].[ClearNumericCharacters] ( dbo.KE_Metrics.ProgramName )) ProgramName,
	dbo.KE_Metrics.ProgramItemId,
	ltrim(
	[dbo].[ClearNumericCharacters] ( dbo.KE_Metrics.ProgramItemName )) ProgramItemName,
	dbo.KE_Metrics.Template,
	dbo.KE_Metrics.Description,
	dbo.KE_Metrics.Value,
	dbo.KE_Metrics.Score,
	dbo.KE_Metrics.[Target Score],
	dbo.KE_Metrics.[Target Value],
	dbo.KE_Metrics.Metrics,
	dbo.SessionsWtTimeStamp.[Lattitude],
	dbo.SessionsWtTimeStamp.[Longitude],
	dbo.SessionsWtTimeStamp.SessionUid
FROM
	dbo.KE_Metrics
	INNER JOIN dbo.SessionsWtTimeStamp ON CONCAT (
		dbo.KE_Metrics.SessionUid,
		dbo.KE_Metrics.Bottler
		) = CONCAT (
		dbo.SessionsWtTimeStamp.SessionUid ,
		dbo.SessionsWtTimeStamp.Bottler
	)
WHERE
	dbo.KE_Metrics.Value = 'N/A')K
	WHERE K.SessionUid NOT IN (SELECT DISTINCT SessionUid FROM DeacitvateSessions)
GO

