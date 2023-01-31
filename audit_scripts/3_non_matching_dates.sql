declare @sessions_dt table (uid varchar(100))

insert into @sessions_dt values ('c8a10cf8-7a54-41bb-9e1d-a5f6ce707a54'),
                             ('fcf32a1d-88c9-44cb-af0f-ba68b9e651d7'),
                             ('81b24b42-e6de-4a1a-ac04-a336f867a9c6'),
                             ('d5e68e92-df01-45a0-a4bb-c9fe375baae7'),
                             ('a21d042a-b1f1-450a-8f9a-28c5a68a8802'),
                             ('387e6f8b-276d-4e56-b556-be6750b2fb25'),
                             ('a01dc439-aa32-4dd3-81fe-8fa0f9112cae'),
                             ('793c0232-decb-4e80-872c-3b19e7dd6576'),
                             ('149d917d-784c-458d-b804-13165aa9c66d'),
                             ('3527cfeb-4fc1-41e1-8194-1dd2544b6e8e'),
                             ('3527cfeb-4fc1-41e1-8194-1dd2544b6e8e'),
                             ('e809e6b7-ab3d-46a7-88c8-beeac933f36f'),
                             ('e809e6b7-ab3d-46a7-88c8-beeac933f36f'),
                             ('318c1633-098b-4a50-84e6-01b98d3582f4'),
                             ('93e99862-969b-40f1-8d79-1979265d84c9'),
                             ('f107635d-78af-46e8-846d-ae71944efd67'),
                             ('a214cce5-29d2-4e74-925d-c8672749bc8e'),
                             ('a9fb3747-d988-472a-8a28-c08378ad0ab7'),
                             ('fb4f3d95-18cc-49d7-a538-65d7ccb0af7c'),
                             ('fb4f3d95-18cc-49d7-a538-65d7ccb0af7c'),
                             ('7404e40e-57ff-41c5-bcd8-29089ce746cc'),
                             ('7404e40e-57ff-41c5-bcd8-29089ce746cc'),
                             ('8c8b9624-a1aa-4ad0-8255-ecbbe8c14f07'),
                             ('8c8b9624-a1aa-4ad0-8255-ecbbe8c14f07'),
                             ('8c8b9624-a1aa-4ad0-8255-ecbbe8c14f07');

WITH cte as (
select SessionUid, CAST(SessionStartDateTime AS DATE) MaxerienceDate, c.Date SunesisDate
from SessionsWtTimeStamp s
INNER JOIN KO_Cal c ON CAST (s.SessionStartDateTime AS DATE) = c.Date
where SessionUid in (select uid from @sessions_dt)
)
select MaxerienceDate,
       SunesisDate,
       CASE WHEN MaxerienceDate = SunesisDate
           THEN CAST(1 AS BIT)
           ELSE CAST(0 AS BIT) END
from cte