with temp as (SELECT DISTINCT CONCAT(
                                      dbo.View_Metrics_new.[Year],
                                      dbo.View_Metrics_new.OutletCode,
                                      dbo.View_Metrics_new.[UserID],
                                      dbo.View_Metrics_new.KO_Month) AS VMN_key,

                              CONCAT(
                                      OutletsMD.[Year],
                                      OutletsMD.outletcode,
                                      OutletsMD.[users],
                                      OutletsMD.[Month])             AS OutletsMD_key


              FROM dbo.View_Metrics_new
                  INNER JOIN OutletsMD ON
                           dbo.View_Metrics_new.[Year] = OutletsMD.[Year] AND
                           dbo.View_Metrics_new.OutletCode = OutletsMD.outletcode AND
                           dbo.View_Metrics_new.[UserID] = OutletsMD.[users] AND
                           dbo.View_Metrics_new.KO_Month = OutletsMD.[Month]

              where OutletsMD.outletcode = '3913906'
AND OutletsMD.[Month] IN ('Sep', 'Oct')
              )
select VMN_key,
       OutletsMD_key,

       IIF(VMN_key = OutletsMD_key, 1, 0) AS CHECKED
from temp