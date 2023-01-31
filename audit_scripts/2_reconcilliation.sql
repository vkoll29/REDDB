declare @tb_sessions_in_recon table (uid varchar(100));
insert into @tb_sessions_in_recon values ('37617b6c-6e99-4d6b-8475-7326de2eaaa8'),
                                         ('3f44ee8c-cc21-4460-aaa6-df7b307486fc'),
                                         ('6bc3eaf7-5c10-4649-b1cb-42a7e21ad19c'),
                                         ('b289f6ff-60f0-450d-87e2-4bcb218e4079'),
                                         ('b289f6ff-60f0-450d-87e2-4bcb218e4079')

select * from IRMetricsV2 -- or SessionsWtTimestamp
where SessionUid in (select uid from @tb_sessions_in_recon)