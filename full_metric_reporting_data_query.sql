DECLARE @Year INT=2022,
@KO_Month varchar(50)='SEP',
@KO_Week varchar(50)='%',
@CountryCode varchar(50)='CCBA-Kenya',
@OutletCode varchar(250)='%',
@StartDate datetime=null,
@EndDate datetime=null


SELECT
 *
FROM
  View_FullMetric_New
  LEFT OUTER JOIN [dbo].[View_OutletBase] K ON CONCAT([Year],[SubClientCode],[KO_Month],[Region],[City],[Customer Tier],
  [Sales Organization],[Sales Office],[Sales Group],[BD territory code],[BD Territory])=K.[ckey]
WHERE
  View_FullMetric_New.[Year] = @Year
  AND View_FullMetric_New.KO_Month LIKE @KO_Month
  AND View_FullMetric_New.KO_Week LIKE @KO_Week
  AND View_FullMetric_New.CountryCode = @CountryCode
  AND View_FullMetric_New.OutletCode LIKE @OutletCode