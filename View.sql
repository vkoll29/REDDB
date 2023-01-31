USE [iRED]
GO

/****** Object:  View [dbo].[View_FullMetric_New_Load]    Script Date: 21-Aug-22 12:48:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_KEFullMetric_New_Aug] AS SELECT
DISTINCT
dbo.View_KEMetricsAug_new.[Date],
dbo.View_KEMetricsAug_new.Week,
dbo.View_KEMetricsAug_new.KO_Week,
dbo.View_KEMetricsAug_new.[Month],
dbo.View_KEMetricsAug_new.[Year],
dbo.View_KEMetricsAug_new.KO_Month,
dbo.View_KEMetricsAug_new.ClientCode,
dbo.View_KEMetricsAug_new.SubClientCode,
dbo.View_KEMetricsAug_new.CountryCode,
dbo.View_KEMetricsAug_new.UserID,
dbo.View_KEMetricsAug_new.OutletCode,
dbo.View_KEMetricsAug_new.ProgramName [Sub-Channel],
-- case when dbo.View_KEMetricsAug_new.ProgramName IN('Duka Kiosk Urban',
-- 'Duka-Kiosk IC (Urban)-Bronze',
-- 'Duka-Kiosk IC (Urban)-Gold',
-- 'Duka-Kiosk IC (Urban)-Silver'
-- ) THEN 'Duka-Kiosk IC (Urban)'
-- WHEN dbo.View_KEMetricsAug_new.ProgramName IN('EATING & DRINKING',
-- 'EATING & DRINKING Bronze',
-- 'EATING & DRINKING Gold',
-- 'EATING & DRINKING Silver'
-- ) THEN 'EATING & DRINKING'
-- WHEN dbo.View_KEMetricsAug_new.ProgramName IN('GROCERY & SHOPPING',
-- 'GROCERY & SHOPPING Bronze',
-- 'GROCERY & SHOPPING Gold',
-- 'GROCERY & SHOPPING Silver'
-- ) THEN 'GROCERY & SHOPPING'
-- WHEN dbo.View_KEMetricsAug_new.ProgramName IN('HORECA',
-- 'HORECA Bronze',
-- 'HORECA Gold',
-- 'HORECA Silver'
-- ) THEN 'HORECA'
-- ELSE
-- dbo.View_KEMetricsAug_new.ProgramName
-- end AS [Sub-Channel],
dbo.View_KEMetricsAug_new.ProgramItemName,
dbo.View_KEMetricsAug_new.Template,
dbo.View_KEMetricsAug_new.Description,
dbo.View_KEMetricsAug_new.[Value],
CASE
    WHEN dbo.View_KEMetricsAug_new.Template IN( 'Composite metrics','SOVI')
        then dbo.View_KEMetricsAug_new.[Metrics]
    ELSE  dbo.View_KEMetricsAug_new.[Target Value]
    END
    AS [Target Value],
--SUM(
CASE
    WHEN dbo.View_KEMetricsAug_new.[Value] LIKE '%Yes%'
        then dbo.View_KEMetricsAug_new.[Target Score]
    WHEN dbo.View_KEMetricsAug_new.[Value] NOT IN(' ','0','')
             AND dbo.View_KEMetricsAug_new.Description='Still Water - Dasani & Keringet ( bulk )'
             AND dbo.View_KEMetricsAug_new.ProgramName='Superette (Convinience stores)'
        then dbo.View_KEMetricsAug_new.[Target Score]
    WHEN dbo.View_KEMetricsAug_new.[Value] LIKE '%NO%'
        then '0'
    else dbo.View_KEMetricsAug_new.Score
    end
--)
AS
Score,

--Sum(dbo.View_KEMetricsAug_new.Score) AS Score,
--Sum(
CASE
    WHEN dbo.View_KEMetricsAug_new.Template IN( 'Composite metrics')
             AND dbo.View_KEMetricsAug_new.Score>0
        THEN dbo.View_KEMetricsAug_new.Score
    ELSE dbo.View_KEMetricsAug_new.[Target Score]
    END
--)
AS
[Target Score],

dbo.Outlets.[Customer name],
dbo.Outlets.[Customer Tier],
dbo.Outlets.Barcode,
dbo.Outlets.[Address 1],
dbo.Outlets.Street,
dbo.Outlets.City,
dbo.Outlets.[Trade Channel] as Channel,
CASE
    WHEN dbo.Outlets.Region LIKE'DAR CENTRAL%'
        THEN 'DAR CENTER'
    WHEN dbo.Outlets.Region LIKE'WESTERN%'
             and dbo.View_KEMetricsAug_new.SubClientCode<>'70'
        THEN 'North Rift'
    WHEN [dbo].[First_LastName] ([dbo].[fn_TextToProperCase](RTRIM(LTRIM(dbo.Outlets.[Sales Office])))) LIKE '%Alex Ishengoma%'
        THEN 'DAR NORTH'
    ELSE dbo.Outlets.Region
    END Region ,
[dbo].[First_LastName](
    [dbo].[fn_TextToProperCase](
        RTRIM(LTRIM(dbo.Outlets.[Sales Office]))
        )
    ) AS [Sales Office],
dbo.Outlets.[Trade Channel],
dbo.Outlets.[Sub-Channel] AS [Sub-Channel2],
dbo.Bottler.Bottler,
dbo.KPI.KPI,
dbo.KPI.[KPI Item],
dbo.Bottler.[Group],
[dbo].[fn_TextToProperCase](
    case
        when dbo.Outlets.[BD territory]='RAMADHANI SAID MRISHO'
            then 'HENELICKO BUCHARD MJUNI'
        else dbo.Outlets.[BD territory]
    end)
    AS [BD Territory],
dbo.Outlets.[Sales Group] AS [Sales Group],
case
    when [dbo].[First_LastName](
        [dbo].[fn_TextToProperCase](
            RTRIM(LTRIM(dbo.Outlets.[Sales Organization])))
        )='RSM-WESTERN'
        THEN 'John Kibaara'
    ELSE [dbo].[First_LastName](
        [dbo].[fn_TextToProperCase](
            RTRIM(LTRIM(dbo.Outlets.[Sales Organization]))
            )
        )
END  AS [Sales Organization],
dbo.Outlets.[BD territory code],
dbo.View_KEMetricsAug_new.[Metrics],
CASE
    WHEN dbo.Outlets.City LIKE '%Key Accounts%'
        then 'MT'
    WHEN dbo.View_KEMetricsAug_new.ProgramName = 'DOSA'
        then 'DOSA'
    else 'GT'
    END
    Trade,
dbo.Outlets.[PICOS Channel & Tier],
CASE
    WHEN RTRIM(LTRIM(dbo.View_KEMetricsAug_new.ProgramName))= LTRIM(RTRIM(dbo.Outlets.[Sub-Channel]))
        THEN 1
	WHEN CONCAT(dbo.View_KEMetricsAug_new.ProgramName,dbo.Outlets.[Sub-Channel])
		IN ('Superette (Convinience stores)Superette',
		'Duka Kiosk UrbanDuka-Kiosk IC (Urban)',
		'QSR_without home deliveriesQSR Without Home Deliveries',
		'PFM - Without a Convinien StorePFM Without A Convenience Store',
		'QSR_with home deliveriesQSR With Home Deliveries'
		   )
		THEN 1
    ELSE 0
    END Checks
--dbo.Outlets.users

FROM
dbo.View_KEMetricsAug_new
INNER JOIN
    dbo.Outlets ON CONCAT(dbo.View_KEMetricsAug_new.[Year],dbo.View_KEMetricsAug_new.OutletCode,dbo.View_KEMetricsAug_new.SubClientCode,dbo.View_KEMetricsAug_new.KO_Month) = CONCAT(dbo.Outlets.[Year],dbo.Outlets.outletcode,dbo.Outlets.[Sub Client Code],dbo.Outlets.[Month] )
INNER JOIN
    dbo.Bottler ON dbo.View_KEMetricsAug_new.SubClientCode = dbo.Bottler.SubClientCode

--
-- INNER JOIN dbo.KPI ON
-- RTRIM( LTRIM( REPLACE(REPLACE(REPLACE(dbo.View_KEMetricsAug_new.Description,' ','{}'),'}{',''),'{}',' ')))=dbo.KPI.Description

INNER JOIN dbo.KPI ON ltrim(rtrim(
    CASE
        WHEN CHARINDEX('  ', dbo.View_KEMetricsAug_new.Description)> 0
            THEN REPLACE(REPLACE(dbo.View_KEMetricsAug_new.Description, '  ', ' '),'  ',' ')
        WHEN CHARINDEX('   ', dbo.View_KEMetricsAug_new.Description)> 0
            THEN REPLACE(dbo.View_KEMetricsAug_new.Description, '   ', '')
        WHEN CHARINDEX('    ', dbo.View_KEMetricsAug_new.Description)> 0
            THEN REPLACE(dbo.View_KEMetricsAug_new.Description, '    ', '')
        WHEN CHARINDEX(' ', dbo.View_KEMetricsAug_new.Description)> 0
            THEN REPLACE(dbo.View_KEMetricsAug_new.Description, ' ', ' ')
        ELSE dbo.View_KEMetricsAug_new.Description END))= dbo.KPI.Description

GO

