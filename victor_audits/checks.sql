select RTRIM(LTRIM(dbo.View_Metrics_new.ProgramName)) ProgramName_VM,
       LTRIM(RTRIM(dbo.OutletsMD.[Sub-Channel])) SubChannel_Out

FROM
dbo.View_Metrics_new
INNER JOIN OutletsMD ON
	dbo.View_Metrics_new.[Year] = OutletsMD.[Year] AND
    dbo.View_Metrics_new.OutletCode = OutletsMD.outletcode AND
    dbo.View_Metrics_new.[UserID] = OutletsMD.[users] AND
    dbo.View_Metrics_new.KO_Month = OutletsMD.[Month]
where View_Metrics_new.OutletCode in (select outletcode from MissingOutlets)
and View_Metrics_new.KO_Month = 'OCT'
-- INNER JOIN dbo.Bottler ON dbo.View_Metrics_new.SubClientCode = dbo.Bottler.SubClientCode



----------------------------------------------------------------------------
with outlets as (select outletcode from MissingOutlets),
     -- outletsmt as (select [Sub-Channel], outletcode from OutletsMD where Client = 'CCBA Kenya' and Month = 'Oct' and Year= 2022),

stage as (
select distinct o.outletcode,
       RTRIM(LTRIM(vm.ProgramName)) ProgramName_VM,
	   UserID VM_user,
	   users O_user,
       LTRIM(RTRIM(om.[Sub-Channel])) SubChannel_Out2,
       CASE	WHEN RTRIM(LTRIM(vm.ProgramName))= LTRIM(RTRIM(om.[Sub-Channel])) THEN 1
		WHEN CONCAT(vm.ProgramName,om.[Sub-Channel])
		IN ('Superette (Convinience stores)Superette',
            'Duka Kiosk UrbanDuka-Kiosk IC (Urban)',
            'QSR_without home deliveriesQSR Without Home Deliveries',
            'PFM - Without a Convinien StorePFM Without A Convenience Store',
		    'QSR_with home deliveriesQSR With Home Deliveries') THEN 1
           ELSE 0 END Checks,

       dbo.Bottler.Bottler,
       vm.SubClientCode VM_SCC,
       dbo.Bottler.SubClientCode B_SCC

from outlets o
left join dbo.View_Metrics_new vm on o.outletcode = vm.OutletCode
left join OutletsMD om on o.outletcode = om.outletcode and om.Month = 'oct' and om.Year = 2022
INNER JOIN dbo.Bottler ON vm.SubClientCode = dbo.Bottler.SubClientCode

where vm.Month = 10 and vm.Year = 2022)

select *, row_number() over(partition by outletcode order by outletcode) occurences
from stage

order by outletcode desc
-------------------------------------------------------------------------------------

with outlets as (select outletcode from MissingOutlets)
select o.outletcode,
       l.Checks,


from outlets o
left join View_FullMetric_New_Load l on o.outletcode = l.OutletCode



where l.KO_Month = 'Oct' and l.Year = 2022

----------------------------------------------------
delete from OutletsMD
where outletcode in ('3440095', '3119497', '3072888', '3054451')
---------------------------------------------------------------------

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct  --[Date]
      [Week]
      ,[KO_Week]
      -- ,[Month]
      -- ,[Year]
      ,[KO_Month]
      ,[ClientCode]
      ,View_Metrics_new.[SubClientCode]
      ,view_metrics_new.[CountryCode]
      ,[UserID]
      ,View_Metrics_new.[OutletCode]
      ,[ProgramName]
      ,[ProgramItemName]
	  ,dbo.KPI.KPI
,dbo.KPI.[KPI Item]
,dbo.Bottler.[Group]

  FROM [iRED].[dbo].[View_Metrics_new]
  INNER JOIN OutletsMD ON
	dbo.View_Metrics_new.[Year] = OutletsMD.[Year] AND
    dbo.View_Metrics_new.OutletCode = OutletsMD.outletcode AND
    dbo.View_Metrics_new.[UserID] = OutletsMD.[users] AND
    dbo.View_Metrics_new.KO_Month = OutletsMD.[Month]

  INNER JOIN dbo.Bottler ON dbo.View_Metrics_new.SubClientCode = dbo.Bottler.SubClientCode
  INNER JOIN dbo.KPI ON ltrim(rtrim(CASE
WHEN CHARINDEX('  ', dbo.View_Metrics_new.Description)> 0 THEN REPLACE(REPLACE(dbo.View_Metrics_new.Description, '  ', ' '),'  ',' ')
WHEN CHARINDEX('   ', dbo.View_Metrics_new.Description)> 0 THEN REPLACE(dbo.View_Metrics_new.Description, '   ', '')
WHEN CHARINDEX('    ', dbo.View_Metrics_new.Description)> 0 THEN REPLACE(dbo.View_Metrics_new.Description, '    ', '')
WHEN CHARINDEX(' ', dbo.View_Metrics_new.Description)> 0 THEN REPLACE(dbo.View_Metrics_new.Description, ' ', ' ')
ELSE dbo.View_Metrics_new.[Description] END))= dbo.KPI.Description


  where View_Metrics_new.OutletCode in (select OutletCode from MissingOutlets) and View_Metrics_new.month = 10 and View_Metrics_new.Year = 2022
