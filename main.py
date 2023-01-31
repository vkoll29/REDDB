from google.cloud import bigquery
from pprint import pprint
import os



client = bigquery.Client()
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'learnbq-356809-b77a9420f6f9.json'
### TEST CONNECTION
# def implicit():
#     from google.cloud import storage
#     storage_client = storage.Client()
#     datasets = list(storage_client.list_datasets())
#     print(datasets)
#
#
# implicit()


### ------HACKER NEWS dataset----

dataset_ref = client.dataset('hacker_news', project='bigquery-public-data')
hn = client.get_dataset(dataset_ref)
tables = client.list_tables(hn)
# for table in tables:
#     print(table.table_id)

table_ref = dataset_ref.table('full')
table = client.get_table(table_ref)
# pprint(table.schema)
#

query = """
SELECT score
FROM `bigquery-public-data.hacker_news.full`
WHERE type = 'job'
LIMIT 1000
"""

popular_posts = """
SELECT parent, COUNT(1) AS num_comments
FROM `bigquery-public-data.hacker_news.comments`
GROUP BY parent
HAVING num_comments > 10
ORDER BY num_comments DESC
"""

prolific_commentors = """
SELECT author, COUNT(1) AS NumPosts
FROM `bigquery-public-data.hacker_news.comments`
GROUP BY author
HAVING NumPosts > 10000"""

deleted_comments = """
SELECT deleted, COUNT(1) 
FROM `bigquery-public-data.hacker_news.comments`
GROUP BY deleted
HAVING deleted IS True"""

stories_comments = """
WITH c AS 
    (
    SELECT parent, count(1) as NumComments
    FROM `bigquery-public-data.hacker_news.comments`
    GROUP BY parent
    )
SELECT s.id, s.title, s.text, s.author, c.NumComments
FROM `bigquery-public-data.hacker_news.stories` as s
LEFT JOIN c
ON s.id = c.parent
WHERE EXTRACT(DATE FROM s.time_ts) = '2012-01-01'
ORDER BY c.NumComments  DESC 
"""

users = """
SELECT s.author
FROM `bigquery-public-data.hacker_news.stories` AS s
WHERE EXTRACT (DATE FROM s.time_ts) = '2014-01-01'
UNION DISTINCT
SELECT c.author
FROM `bigquery-public-data.hacker_news.comments` as c
WHERE EXTRACT(DATE FROM c.time_ts) = '2014-01-01'
"""

def estimate_query_cost(query):
    dry_run_config = bigquery.QueryJobConfig(dry_run=True)  # estimate size of query without running it
    dry_run_query_job = client.query(query, job_config=dry_run_config)  # API request - dry run query to estimate cost
    return f'The query will process {round(dry_run_query_job.total_bytes_processed/1000000, 2)} MBs'


def run_query_safely(query):
    safe_config = bigquery.QueryJobConfig(maximum_bytes_billed=10**9)  # set max bytes billed to 1GB
    query_job = client.query(query, job_config=safe_config)  # API request - run query
    return query_job.to_dataframe()


# res = run_query_safely(users)
# print(res.head(5))

# query_job = client.query(query1)
# results = query_job.to_dataframe()
# pprint(results.head(5))



##------------------OPENAQ dataset-------------
# Get the list of tables in openaq dataset

dataset_ref = client.dataset('openaq', project='bigquery-public-data')
dataset = client.get_dataset(dataset_ref)
tables = list(client.list_tables(dataset))
#
# for table in tables:
#     print(table.table_id)

table_ref = dataset_ref.table('global_air_quality')
table = client.get_table(table_ref)
# print(client.list_rows(table, max_results=5).to_dataframe())

query = (
    """
    SELECT  city
    FROM `bigquery-public-data.openaq.global_air_quality`
    WHERE country = 'US'
    """
)

query1 = """
SELECT DISTINCT country
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE unit = 'ppm'
LIMIT 100
"""

query2 = """
SELECT country, COUNT(pollutant)
FROM `bigquery-public-data.openaq.global_air_quality`
GROUP BY country
"""
# query_job = client.query(query2)
# res = query_job.to_dataframe()
# print(res.head())


##----------------END------------------------------


##-------- US FATALITY RECORDS DATASET--------------

# trafficds_ref = client.dataset('nhtsa_traffic_fatalities', project='bigquery-public-data')
# traffic = client.get_dataset(trafficds_ref)
# accident_2015_ref = trafficds_ref.table('accident_2015')
# accident_2015 = client.get_table(accident_2015_ref)
# pprint(accident_2015.schema)

day_of_week_most_fatalities = """
SELECT  EXTRACT(DAYOFWEEK FROM timestamp_of_crash) AS DayWeek, 
        COUNT(consecutive_number) AS NumofAccidents, 
        SUM(number_of_fatalities) AS TotalFatalities
FROM `bigquery-public-data.nhtsa_traffic_fatalities.accident_2015`
WHERE number_of_fatalities > 0
GROUP BY DayWeek
ORDER BY TotalFatalities DESC
"""

# res = client.query(day_of_week_most_fatalities).to_dataframe()
# print(res.head(10)) # there are just 7 rows

##-------------------END----------------------------------


##-----------------WORLD BANK DATASET---------------------

education_expenditure = """
SELECT country_name, AVG(value) AS avg_ed_spending_pct
FROM `bigquery-public-data.world_bank_intl_education.international_education`
WHERE indicator_code = 'SE.XPD.TOTL.GD.ZS' AND year >= 2010 AND year <= 2017
GROUP BY country_name
ORDER BY avg_ed_spending_pct DESC

"""

popular_codes_2016 = """
SELECT indicator_code, indicator_name, COUNT(1) as num_rows
FROM `bigquery-public-data.world_bank_intl_education.international_education`
WHERE year = 2016
GROUP BY indicator_code, indicator_name
HAVING num_rows >= 175
ORDER BY num_rows DESC
"""

# res = client.query(popular_codes_2016).to_dataframe()
# print(res.head(10))

## --------------END---------------------------


## ---- CRYPTO BITCOIN --------

btc_transactions_per_month = """
WITH datte AS 
    (
    SELECT DATE(block_timestamp) AS trans_date
    FROM `bigquery-public-data.crypto_bitcoin.transactions`
    )

SELECT trans_date, COUNT(1) as NumTransactions
FROM datte
GROUP BY trans_date
ORDER BY trans_date
"""

# res = client.query(btc_transactions_per_month).to_dataframe()
# print(res.head())

# res.set_index('trans_date').plot()
# import matplotlib.pyplot as plt
# plt.show()

## --------------END------------------


##-------------------- CHICAGO TAXI TRIPS -----------------

trips_per_year = """
SELECT EXTRACT(YEAR FROM trip_start_timestamp) as year, COUNT(1) as num_trips
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
GROUP BY year
ORDER BY year DESC 
"""

trips_in_17 = """
SELECT  EXTRACT(MONTH FROM trip_start_timestamp) AS month, 
        EXTRACT(YEAR FROM trip_start_timestamp) AS year, 
        COUNT(1) as num_trips
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE trip_start_timestamp >= '2017-01-01 00:00:00+00:00' AND trip_start_timestamp < '2018-01-01 00:00:00+00:00'

GROUP BY month, year
ORDER BY month DESC 
"""

hourly_trips_no_with = """
SELECT  EXTRACT(HOUR FROM trip_start_timestamp) as hour_of_day, 
        COUNT(1) as num_trips, 
        (3600 * SUM(trip_miles) / SUM (trip_seconds)) as avg_mph
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE trip_start_timestamp BETWEEN '2017-01-01' AND '2017-07-01' AND trip_seconds > 0 AND trip_miles > 0
GROUP BY hour_of_day
ORDER BY hour_of_day
"""

hourly_trips = """
WITH RelevantRides AS
(
    SELECT trip_start_timestamp, trip_miles, trip_seconds
    FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
    WHERE trip_start_timestamp BETWEEN '2017-01-01' AND '2017-07-01' AND 
            trip_seconds > 0 AND 
            trip_miles > 0
)
SELECT EXTRACT(HOUR FROM trip_start_timestamp) as hour_of_day, 
        COUNT(1) as num_trips, 
        (3600 * SUM(trip_miles) / SUM (trip_seconds)) as avg_mph
FROM RelevantRides
GROUP BY hour_of_day
ORDER BY hour_of_day
"""

taxi_demand_prediction = """
WITH daily_trips AS 
(
    SELECT DATE(trip_start_timestamp) AS trip_date, COUNT(1) as num_trips
    FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
    WHERE trip_start_timestamp >= '2016-01-01' AND trip_start_timestamp <= '2017-12-31'
    GROUP BY trip_date
    ORDER BY trip_date DESC
)
SELECT *,
AVG(num_trips)
OVER(
    ORDER BY trip_date
    ROWS BETWEEN 15 PRECEDING AND 15 FOLLOWING
) as avg_num_trips
FROM daily_trips

"""

trip_numbers = """
SELECT  pickup_community_area,
        trip_start_timestamp,
        trip_end_timestamp,
        RANK() OVER(
        PARTITION BY pickup_community_area
        ORDER BY trip_start_timestamp
        ) as Rank
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE DATE(trip_start_timestamp) = '2017-05-01'
    """

break_btwn_trips = """
SELECT  taxi_id,
        TIME(trip_start_timestamp),
        TIME(trip_end_timestamp),
        TIMESTAMP_DIFF(trip_start_timestamp,
         LAG(trip_end_timestamp, 1) OVER(
            PARTITION BY taxi_id
            ORDER BY trip_start_timestamp
        ), 
        MINUTE) as prev_break
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE DATE(trip_start_timestamp) = '2017-05-01'
"""


## ----------------------END----------------------


## ------- GITHUB REPOS DATASET -----------------

num_files_per_license = """
SELECT L.license, COUNT(1) as num_files
FROM `bigquery-public-data.github_repos.licenses` as L
INNER JOIN `bigquery-public-data.github_repos.sample_files` as sf
ON L.repo_name = sf.repo_name
GROUP BY L.license
ORDER BY num_files DESC 

"""

commiters_ranked = """
SELECT committer.name as committer_name, COUNT(1) as num_commits
FROM `bigquery-public-data.github_repos.sample_commits`
WHERE DATE(committer.date) >= '2016-01-01' AND DATE(committer.date) < '2017-01-01'
GROUP BY committer_name
ORDER BY num_commits DESC
"""

popular_languages = """
SELECT l.name as language_name, COUNT(*) AS num_repos
FROM `bigquery-public-data.github_repos.languages`,
UNNEST(language) as l
GROUP BY language_name
ORDER BY num_repos DESC
"""

languages_in_repo = """
SELECT  l.name as name,
        l.bytes as bytes
FROM `bigquery-public-data.github_repos.languages`,
UNNEST(language) as l
WHERE repo_name = 'polyrabbit/polyglot'
ORDER BY bytes DESC
"""

res = client.query(languages_in_repo).to_dataframe()
print(res.head(10))
##----------------END-------------------------------


##----------------STACKOVERFLOW DATASET-------------

users_topics = """
SELECT DISTINCT (a.owner_display_name), q.tags
FROM `bigquery-public-data.stackoverflow.posts_questions` as q
INNER JOIN `bigquery-public-data.stackoverflow.posts_answers` as a
ON q.id = a.parent_id
WHERE a.owner_display_name <> 'None'
--ORDER BY q.creation_date DESC
LIMIT 100
"""

bq_answers = """
WITH bq_users as 
(
    SELECT a.id, 
            a.body, 
            a.owner_user_id, 
            q.tags,
    FROM  `bigquery-public-data.stackoverflow.posts_answers` as a
    INNER JOIN `bigquery-public-data.stackoverflow.posts_questions` as q
    ON a.parent_id = q.id
    WHERE q.tags LIKE '%bigquery%'
)
SELECT owner_user_id, COUNT(1) AS number_of_answers
FROM bq_users
GROUP BY owner_user_id
ORDER BY number_of_answers DESC
"""

answer_time = """
SELECT q.id as q_id, MIN(TIMESTAMP_DIFF(a.creation_date, q.creation_date, SECOND)) as answer_time
FROM `bigquery-public-data.stackoverflow.posts_questions` as q
LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` as a
ON q.id = a.parent_id
WHERE q.creation_date >= '2018-01-01' and q.creation_date < '2018-02-01'
GROUP BY q.id
ORDER BY answer_time
"""

users_analysis = """
SELECT  q.owner_user_id AS owner_user_id, 
        q.creation_date AS q_creation_date, 
        a.creation_date AS a_creation_date,
FROM `bigquery-public-data.stackoverflow.posts_questions` as q
FULL JOIN `bigquery-public-data.stackoverflow.posts_answers` as a
ON q.owner_user_id = a.owner_user_id
WHERE q.creation_date >= '2019-01-01' AND q.creation_date < '2019-02-01' 
AND a.creation_date >= '2019-01-01' AND a.creation_date < '2019-02-01'
"""

users_analysis_2019 = """
WITH users AS ( 
 SELECT U.id AS user_id, 
        EXTRACT(DATE FROM U.creation_date) AS user_creation_date
FROM `bigquery-public-data.stackoverflow.users` AS U
WHERE U.creation_date >= '2019-01-01' AND U.creation_date < '2019-02-01'  
 )

SELECT  U.user_id, 
        MIN(q.creation_date) AS q_creation_date, 
        MIN(a.creation_date) AS a_creation_date,
FROM users AS U
LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` AS q
ON U.user_id = q.owner_user_id
LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` AS a
ON U.user_id = a.owner_user_id
GROUP BY U.user_id
"""

jan_2019_posters = """
WITH questions AS 
(
    SELECT DISTINCT q.owner_user_id,
    FROM `bigquery-public-data.stackoverflow.posts_questions` as q
    WHERE q.creation_date >= '2019-01-01' AND q.creation_date< '2019-01-02' 
),
answers AS
(
    SELECT DISTINCT a.owner_user_id, 
    FROM `bigquery-public-data.stackoverflow.posts_answers` as a
    WHERE a.creation_date >= '2019-01-01' AND a.creation_date< '2019-01-02' 
)

SELECT q.owner_user_id
FROM questions AS q
UNION DISTINCT
SELECT a.owner_user_id
FROM answers AS a
"""

# res = client.query(jan_2019_posters).to_dataframe()
# print(len(res))
# print(f"Percentage of answered questions is: {round(sum(res['answer_time'].notnull()) / len(res) * 100, 2)}%")

##----------------END-------------------------------


##----------------SAN FRANCISCO DATASET-------------
# ANALYTIC WINDOW FUNCTIONS

sf_ref = client.dataset('san_francisco', 'bigquery-public-data')
sf = client.get_dataset(sf_ref)
tables = list(client.list_tables(sf))
# for table in tables:
#     print(table.table_id)

cumulative_daily_trips = """
    WITH daily_trips AS 
    (
        SELECT EXTRACT(DATE FROM start_date) as datte, COUNT(1) AS num_of_trips
        FROM `bigquery-public-data.san_francisco.bikeshare_trips`
        GROUP BY datte
    )
    SELECT *,
    SUM(num_of_trips) 
    OVER(
    ORDER BY datte
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cum_trips_count
    FROM daily_trips
"""

start_end_stations = """
SELECT bike_number,
TIME(start_date) AS trip_time,
FIRST_VALUE(start_station_id)
OVER(
PARTITION BY bike_number
ORDER BY start_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS first_station,
LAST_VALUE(end_station_id)
OVER(
PARTITION BY bike_number
ORDER BY start_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS last_station
FROM `bigquery-public-data.san_francisco.bikeshare_trips`
WHERE DATE(start_date) = '2015-10-25'
"""

#-----------------END----------------------------------


##---------GOOGLE ANALYTICS SAMPLE DATASET-------------

num_transactions_per_browser = """
SELECT device.browser, SUM(totals.transactions) as total_transactions,
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
GROUP BY device.browser
ORDER BY total_transactions DESC
"""


# res = client.query(num_transactions_per_browser).to_dataframe()
# print(res.head(10))

##----------no dataset-----------

q = """

WITH costume_ids as 
(
select CostumeID FROM CostumeOwners WHERE OwnerID = 'MitzieOwnerID'
),
costume_locations as
(
select ci.CostumeID, cl.Timestamp, cl.location
FROM costume_ids ci,
INNER JOIN CostumeLocations cl
ON ci.CostumeID = cl.CostumeID
)
select cl.costumeID, location, MAX(Timestamp) as most_recent_record
from costume_locations
GROUP BY cl.costumeID, location
"""