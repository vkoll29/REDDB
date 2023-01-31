select top(100)
    Date,
       ClientCode,
       UserId,
       OutletCode,
       ProgramItemName,
       Template,
       Description,
       Value,
       Score,
       [Target Score],
       [Target Value],
       [Metrics]

from View_MetricsV2
where [ClientCode]= 'CCBAKE'
  and [SessionStartDateTime] BETWEEN '2022-09-02' AND '2022-09-10'
  and Template like '%composite%'
  --AND Description  like '%soci%'