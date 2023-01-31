USE [iRED]
GO

/****** Object:  StoredProcedure [dbo].[FullMetricReportingData]    Script Date: 21-Aug-22 1:43:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<George Owino>
-- Create date: <2022-08-21>
-- Description:	<Working on KE Dealer Chiller>
-- =============================================
CREATE PROCEDURE [dbo].[KEFullMetricReportingData_Aug]
	-- Add the parameters for the stored procedure here
(@Year INT,
@KO_Month varchar(50),
@KO_Week varchar(50)='%',
@CountryCode varchar(50),
@OutletCode varchar(MAX)='%',
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
	SELECT
     *
    FROM
      View_KEFullMetric_New_Aug
      LEFT OUTER JOIN [dbo].[View_OutletBase] K
          ON CONCAT([Year],[SubClientCode],[KO_Month],[Region],[City],[Customer Tier],
      [Sales Organization],[Sales Office],[Sales Group],[BD territory code],[BD Territory])=K.[ckey]
    WHERE
      View_KEFullMetric_New_Aug.[Year] = @Year
      AND View_KEFullMetric_New_Aug.KO_Month LIKE @KO_Month
      AND View_KEFullMetric_New_Aug.KO_Week LIKE @KO_Week
      AND View_KEFullMetric_New_Aug.CountryCode = @CountryCode
      AND (View_KEFullMetric_New_Aug.OutletCode IN( SELECT * FROM string_split( @OutletCode,' '))
               OR View_KEFullMetric_New_Aug.OutletCode LIKE @OutletCode)
     -- AND View_KEFullMetric_New_Aug.[Date] >= @Date
     -- AND View_KEFullMetric_New_Aug.[Date] <= @Date2
     END

    IF @StartDate IS NOT NULL AND @EndDate IS NOT NULL
    BEGIN
    SELECT
     *
    FROM
      View_KEFullMetric_New_Aug
      LEFT OUTER JOIN [dbo].[View_OutletBase] K ON CONCAT([Year],[SubClientCode],[KO_Month],[Region],[City],[Customer Tier],
      [Sales Organization],[Sales Office],[Sales Group],[BD territory code],[BD Territory])=K.[ckey]
    WHERE
      View_KEFullMetric_New_Aug.[Year] = @Year
      AND View_KEFullMetric_New_Aug.KO_Month LIKE @KO_Month
      AND View_KEFullMetric_New_Aug.KO_Week LIKE @KO_Week
      AND View_KEFullMetric_New_Aug.CountryCode = @CountryCode
     AND (View_KEFullMetric_New_Aug.OutletCode IN( SELECT * FROM string_split( @OutletCode,' ')) OR
      View_KEFullMetric_New_Aug.OutletCode LIKE @OutletCode)
     AND View_KEFullMetric_New_Aug.[Date] >= @StartDate
     AND View_KEFullMetric_New_Aug.[Date] <= @EndDate
     END
    END
GO


