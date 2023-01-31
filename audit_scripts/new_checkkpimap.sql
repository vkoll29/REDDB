
WITH newitems as
    (SELECT DISTINCT trim
        (CASE
            WHEN CHARINDEX('  ', IRMetricsV2.Description)> 0
                THEN REPLACE(
                        REPLACE(IRMetricsV2.Description, '  ', ' '),
                    '  ',' ')
            WHEN CHARINDEX('   ', IRMetricsV2.Description)> 0
                THEN REPLACE(IRMetricsV2.Description, '   ', '')
            WHEN CHARINDEX('    ', IRMetricsV2.Description)> 0
                THEN REPLACE(IRMetricsV2.Description, '    ', '')
            WHEN CHARINDEX(' ', IRMetricsV2.Description)> 0
                THEN REPLACE(IRMetricsV2.Description, ' ', ' ')
            ELSE IRMetricsV2.Description
        END)[Description],
        Template [KPI] ,
        ''AS [KPI Item]
    FROM IRMetricsV2
    WHERE MONTH(LastModifiedTime) IN ( MONTH( GETDATE()), MONTH(DATEADD(MM,-1 ,GETDATE())) ) )
select * from newitems where [Description] not in (SELECT  [Description] FROM [dbo].[KPI] )

UNION ALL

SELECT [Description]
      ,[KPI]
      ,[KPI Item]
  FROM [dbo].[KPI];
END
GO


USE iRED
UPDATE OutletsMD

SET [Customer Tier] =  'Bronze',
    [Address 1] = 'Dandora/Kariobangi',
    City = 'Dandora/Kariobangi',
    Region = 'Nairobi',
    [Country code] = 'ken',
    [Geo coordinates Lat.] = '-1.258671',
    [Geo coordinates Long.] = '36.867918',
    [Sales OrganizationCode] = '66859',
    [Sales Organization] = 'Alfred Mabu',
    [Sales OfficeCode] = '55320',
    [Sales Office] = 'Michael Chege',
    [Sales GroupCode] = '55320',
    [Sales Group] = 'Michael Chege',
    [BD territory code] = '71719',
    [BD territory] = 'Kelvin Macharia',
    [Trade Channel] = 'Non Traditional',
    [Sub-Channel] = 'Non Traditional',
    [PICOS Channel & Tier] = 'Non Traditional Bronze',
    Date = '2022-11-01',
    Month = 'Nov'



WHERE outletcode = '3022902' and Month = 'nov' and Year = 2022




USE iRED
UPDATE OutletsMD

SET [Customer Tier] =  'Bronze',
    [Address 1] = 'Dandora/Kariobangi',
    City = 'Dandora/Kariobangi',
    Region = 'Nairobi',
    [Country code] = 'ken',
    [Geo coordinates Lat.] = '-1.262289',
    [Geo coordinates Long.] = '36.870549',
    [Sales OrganizationCode] = '66859',
    [Sales Organization] = 'Alfred Mabu',
    [Sales OfficeCode] = '55320',
    [Sales Office] = 'Michael Chege',
    [Sales GroupCode] = '55320',
    [Sales Group] = 'Michael Chege',
    [BD territory code] = '71719',
    [BD territory] = 'Kelvin Macharia',

    [Sub-Channel] = 'Duka-Kiosk Ic',
    [PICOS Channel & Tier] = 'Duka-Kiosk Ic Bronze',
    Date = '2022-11-01',
    Month = 'Nov'



"SELECT * FROM (
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
      ,[Sub-Channel]
      ,[ProgramItemName]
      ,[Template]
      ,[Description]
      ,[Value]
      ,[Target Value]
      ,[Score]
      ,[Target Score]
      ,[Customer name]
      ,[Customer Tier]
      ,[Barcode]
      ,[Address 1]
      ,[Street]
      ,[City]
      ,[Region]
      ,[Sales Office]
      ,[Trade Channel]
      ,[Sub-Channel2]
      ,[Bottler]
      ,[KPI]
      ,[KPI Item]
      ,[Group]
      ,[BD Territory]
      ,[Sales Group]
      ,[Sales Organization]
      ,[BD territory code]
      ,[Metrics]
      ,[Trade]
      ,[PICOS Channel & Tier]
      ,[Checks]

  FROM [dbo].[View_FullMetric_New_Load] WHERE Year="+ (DT_WSTR, 10) @[$Project::Year] +" and  [KO_Month] ='"+ @[$Project::month]+"'
  AND CountryCode<>'KEN'

UNION ALL

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
      ,[Sub-Channel]
      ,[ProgramItemName]
      ,[Template]
      ,[Description]
      ,[Value]
      ,[Target Value]
      ,[Score]
      ,[Target Score]
      ,[Customer name]
      ,[Customer Tier]
      ,[Barcode]
      ,[Address 1]
      ,[Street]
      ,[City]
      ,[Region]
      ,[Sales Office]
      ,[Trade Channel]
      ,[Sub-Channel2]
      ,[Bottler]
      ,[KPI]
      ,[KPI Item]
      ,[Group]
      ,[BD Territory]
      ,[Sales Group]
      ,[Sales Organization]
      ,[BD territory code]
      ,[Metrics]
      ,[Trade]
      ,[PICOS Channel & Tier]
      ,[Checks]

  FROM [dbo].[View_FullMetric_New_Load] WHERE Year="+ (DT_WSTR, 10) @[$Project::Year] +" and  [KO_Month] ='"+ @[$Project::month]+"'
          AND CountryCode='KEN' AND [Checks]=1

  )K"


 SELECT
OBJECT_NAME(p.OBJECT_ID) AS TableName,
resource_type, resource_description
FROM
sys.dm_tran_locks l
JOIN sys.partitions p ON l.resource_associated_entity_id = p.hobt_id

SELECT
    
OBJECT_NAME(P.object_id) AS TableName,

Resource_type,

request_session_id

FROM

sys.dm_tran_locks L

join sys.partitions P

ON L.resource_associated_entity_id = p.hobt_id

WHERE   OBJECT_NAME(P.object_id) <> 'outletsmd'



