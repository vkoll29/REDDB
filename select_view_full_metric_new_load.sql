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
       KPI,
       [KPI Item],
       Metrics

from View_FullMetric_New_Load
where [ClientCode] like 'kenya'
  and [Date] BETWEEN '2022-09-02' AND '2022-09-10'
  and Template like '%composite%'
  --AND Description  like '%soci%'