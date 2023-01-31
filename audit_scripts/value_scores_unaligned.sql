with cte as (
    SELECT
        [SessionUid],
        [SceneUID],
        [Value],
        [Target Score],
        [Target Value],
        [Metrics],
        [Score],
        [CreatedOnTime],
        COUNT(1) over (
        partition by SessionUid
        ) as num_rows

  FROM [iRED].[dbo].[IRMetricsV2]
  where
   [Template]  = 'SOVI'
   and Value <> 0

  and [Description] = ' Water -20% SOVI - Permanent Bev'
)

select  *
from cte
ORDER BY num_rows desc, SessionUid