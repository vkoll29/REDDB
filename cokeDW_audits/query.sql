select DISTINCT
    dbo.REDTEST.KPI+
    ltrim(rtrim(CASE
        WHEN CHARINDEX('  ', dbo.REDTEST.subitem)> 0 THEN REPLACE(REPLACE(dbo.REDTEST.subitem, '  ', ' '),'  ',' ')
        WHEN CHARINDEX('   ', dbo.REDTEST.subitem)> 0 THEN REPLACE(dbo.REDTEST.subitem, '   ', '')
        WHEN CHARINDEX('    ', dbo.REDTEST.subitem)> 0 THEN REPLACE(dbo.REDTEST.subitem, '    ', '')
        WHEN CHARINDEX(' ', dbo.REDTEST.subitem)> 0 THEN REPLACE(dbo.REDTEST.subitem, ' ', ' ')
        ELSE dbo.REDTEST.subitem
        END)) as Key_from_redtest,

    RedMap_1.KPI0+RedMap_1.subitem

	FROM CokeDW.dbo.REDTEST
	LEFT OUTER JOIN dbo.RedMap AS RedMap_1


With stage as (
select *, row_number() over(partition by subitem order by ID ) dup
from redmap        )
select * from stage
where dup > 1

