USE [iRED]
GO

/****** Object:  View [dbo].[View_Metrics_new]    Script Date: 08-Sep-22 12:31:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[View_Metrics_new] AS
--SELECT [Date]
--      ,[Week]
--      ,[KO_Week]
--      ,[Month]
--      ,[Year]
--      ,[KO_Month]
--      ,[ClientCode]
--      ,[SubClientCode]
--      ,[CountryCode]
--      ,[UserID]
--      ,[OutletCode]
--      ,[ProgramName]
--      ,[ProgramItemName]
--      ,[Template]
--      ,[Description]
--      ,[Value]
--      ,[Target Value]
--      ,[Score]
--      ,[Target Score]
--      ,[Metrics]
--	--  ,NULL [Lattitude]
--	 --- ,NULL [Longitude]
--  FROM [dbo].[View_Metrics] where [Date]<='2021-12-31'
--UNION ALL
SELECT [Date]
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
      ,CAST([Score] AS FLOAT)[Score]
	  ,CASE WHEN
              [Description] IN (
              SELECT [KPIDescription]
              FROM   [dbo].[KPIDescription-DC]
              WHERE [KPIDescription] IS NOT NULL
              )
	        --AND dbo.IRMetricsV2.[DomainValue] like '%Cold-Dealer%'
            AND CountryCode='ken'
            AND [YEAR] = 2022
            AND MONTH = 8
            AND [Value] IN('0')

	      THEN 0 ELSE
	    [Target Score] END [Target Score]
      ,[Metrics]
	 -- ,[Lattitude]
	 -- ,[Longitude]
    FROM [dbo].[View_MetricsV2]where [Date]>='2021-11-01'
GO


