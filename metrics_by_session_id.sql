USE iRED

/*SELECT s.[SessionUid],
[CountryCode],
[OutletCode],
[OutletName],
[ProgramName],
[Template],
[Description]
FROM dbo.SessionsWtTimeStamp s
RIGHT JOIN dbo.IRMetricsV2 m
on s.SessionUid = m.SessionUid
where [CountryCode]= 'ken'
  --and [Template] = 'Custom SOVI'
  and YEAR ( [SessionStartDateTime] ) = 2022
  and MONTH ( [SessionStartDateTime] ) = 9

	--AND [Value] > [Target Value]
	AND [OutletCode] = '3000232'
	*/
	-- 5022464e-5f86-44b7-8a4d-32fa2fbec8fa
select
[SessionUid],
[SceneUID],
[ProgramItemName],
[Template],
[Description],
[Domain],
[DomainValue],
[Value],
[MaxTarget],
[Score],
[Metrics]


from dbo.IRMetricsV2
where [SessionUid] = '17975ca9-52b8-49f6-beb6-d600478f3b61'