CREATE PROCEDURE [dbo].[OutletScores]

    (@Year INT=2022,
    @KO_Month varchar(50),
    @KO_Week varchar(50)='%',
    @CountryCode varchar(50),
    @OutletCode varchar(250)='%',
    @StartDate datetime=null,
    @EndDate datetime=null)


    AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        IF @StartDate IS NULL AND @EndDate IS NULL

        BEGIN
            SELECT [Date],
                   Outletcode,
                   Sum(case when KPI = 'Cooler' then score else 0 end) as Cooler_Score,
                   sum(case When KPI = 'Activation' then Score else 0 end) as Activation_score,
                   sum(case When KPI = 'Price Compliance' then Score else 0 end) as Price_score,
                   sum(case When KPI = 'Availability' then Score else 0 end) as Availability_score

            FROM View_FullMetric_New
            WHERE View_FullMetric_New.[Year] = @Year AND
                  View_FullMetric_New.KO_Month LIKE @KO_Month AND
                  View_FullMetric_New.KO_Week LIKE @KO_Week AND
                  View_FullMetric_New.CountryCode = @CountryCode AND
                  View_FullMetric_New.OutletCode LIKE @OutletCode
            Group by Date, Outletcode
            order by Cooler_Score desc
        END

        IF @StartDate IS NOT NULL AND @EndDate IS NOT NULL
            BEGIN
                SELECT [Date],
                       Outletcode,
                       Sum(case when KPI = 'Cooler' then score else 0 end) as Cooler_Score,
                       sum(case When KPI = 'Activation' then Score else 0 end) as Activation_score,
                       sum(case When KPI = 'Price Compliance' then Score else 0 end) as Price_score,
                       sum(case When KPI = 'Availability' then Score else 0 end) as Availability_score

                FROM View_FullMetric_New
                WHERE View_FullMetric_New.[Year] = @Year AND
                      View_FullMetric_New.KO_Month LIKE @KO_Month AND
                      View_FullMetric_New.KO_Week LIKE @KO_Week AND
                      View_FullMetric_New.CountryCode = @CountryCode AND
                      View_FullMetric_New.OutletCode LIKE @OutletCode AND
                      View_FullMetric_New.[Date] >= @StartDate AND
                      View_FullMetric_New.[Date] <= @EndDate
                Group by Date, Outletcode
                order by Cooler_Score desc
            END
    END

GO

