SELECT * FROM (
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

      FROM [dbo].[View_FullMetric_New_Load] WHERE Year=2022 and  [KO_Month] ='SEP'
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

      FROM [dbo].[View_FullMetric_New_Load] WHERE Year=2022 and  [KO_Month] ='SEP'
      AND CountryCode='KEN' AND [Checks]=1

  )K


select distinct
    ms.[outlet code],
    ltrim([dbo].[ClearNumericCharacters] ( m.ProgramName )) ProgramNameParq,
    om.[Sub-Channel] SubChannel_OutletsMD


from MissingSessions ms
join   IRMetricsV2 m

on m.[SessionUid] = ms.[Session uid]

join OutletsMD om
on ms.[Outlet Code] = om.outletcode
where om.Month = 'Oct'