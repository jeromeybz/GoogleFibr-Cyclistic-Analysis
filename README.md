# Google Business Intelligence Projects


## Google Fiber Analysis

### Overview
Google Fiber provides people and businesses with fiber optic internet. Currently, the customer service team working in their call centers answers calls from
customers in their established service areas. In this fictional scenario, the team is
interested in exploring trends in repeat calls to reduce the number of times
customers have to call in order for an issue to be resolved.

### Business Problems
#### Goals: Explore trends in repeat callers 
- Understand how often customers are calling customer support after theirfirst inquiry
- Provide insights into the types of customer issues that seem to generatemore repeat calls
- Explore repeat caller trends and volume in the three different marketcities and type of problems
- Make view trends by weeks, months quearter and year

### Questions for people with dashboard viewing
- How often does the customer service team receive repeat calls from customers?
- What problem types generate the most repeat calls?
- Which market city’s customer service team receives the most repeat calls?

---
1. Get Datasets
```sql
CREATE OR REPLACE TABLE `red-airline-483900-r2.fibr.combined_markets` AS
SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `red-airline-483900-r2.fibr.market_1`
UNION ALL
SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `red-airline-483900-r2.fibr.market_2`
UNION ALL
SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `red-airline-483900-r2.fibr.market_3`
```

2. Initialize type
```sql
update `red-airline-483900-r2.fibr.combined_markets`
set new_type = case
    when new_type = 'type_1' then 'Account Management'
    when new_type = 'type_2' then 'Technician Troubleshooting'
    when new_type = 'type_3' then 'Scheduling'
    when new_type = 'type_4' then 'Construction'
    when new_type = 'type_5' then 'Internet and Wifi'
    ELSE new_type 
  end
where new_type in ('type_1', 'type_2', 'type_3', 'type_4', 'type_5');
```
---

[View Live Google Fiber Dashboard](https://public.tableau.com/app/profile/marc.jerome.colobong/viz/googlefibr_project/Home1)

### Analysis Report
This report analyzes customer support efficiency across three primary markets
during the first quarter. The data focuses on First Contact Resolution and the
frequency of Repeat Calls required to resolve customer issues.

March has peak most especially in First Calls. Market 1 has significantly higher
volume than Markets 2 or 3. You should check if Market 1 is simply larger, or if
their support team is struggling to resolve issues on the first try compared to the
others.
  
In the "Repeat Calls by Market" chart, Internet and Wi-Fi and Technician
Troubleshooting have the highest volume of repeat calls. These are your "trouble" areas that need more training or better technical tools.

Market Performance shows that Market 1 has significantly higher volume than
Markets 2 or 3. You should check if Market 1 is simply larger, or if their support
team is struggling to resolve issues on the first try compared to the others.

There is a consistent spike every Monday. This can be that customers who have
issues over the weekend are all calling in on Monday, or that weekend repairs are
failing and triggering callbacks at the start of the week.


## Cyclistic Analysis

### Overview
In this fictitious workplace scenario, the imaginary company Cyclistic has
partnered with the city of New York to provide shared bikes. Currently, there are
bike stations located throughout Manhattan and neighboring boroughs. Customers
are able to rent bikes for easy travel among stations at these locations.

### Business Problem
Grow Cyclistic’s Customer Base
- Understand what customers want, what makes a successful product, and how new stations might alleviate demand in different locations.
- The team wants to understand how the current line of bikes is used.
- Customer growth team wants to understand how different users (subscribers and non-subscribers) use our bikes.

--- 
1. Gather specific Datasets

```sql
SELECT
  TRI.usertype,
  ZIPSTART.zip_code AS zip_code_start,
  ZIPSTARTNAME.borough borough_start,
  ZIPSTARTNAME.neighborhood AS neighborhood_start,
  ZIPEND.zip_code AS zip_code_end,
  ZIPENDNAME.borough borough_end,
  ZIPENDNAME.neighborhood AS neighborhood_end,
  -- Since this is a fictional dashboard, you can add 5 years to make it look recent
  DATE_ADD(DATE(TRI.starttime), INTERVAL 5 YEAR) AS start_day,
  DATE_ADD(DATE(TRI.stoptime), INTERVAL 5 YEAR) AS stop_day,
  WEA.temp AS day_mean_temperature, -- Mean temp
  WEA.wdsp AS day_mean_wind_speed, -- Mean wind speed
  WEA.prcp day_total_precipitation, -- Total precipitation
  -- Group trips into 10 minute intervals to reduces the number of rows
  ROUND(CAST(TRI.tripduration / 60 AS INT64), -1) AS trip_minutes,
  COUNT(TRI.bikeid) AS trip_count
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips` AS TRI
INNER JOIN
  `bigquery-public-data.geo_us_boundaries.zip_codes` ZIPSTART
  ON ST_WITHIN(
    ST_GEOGPOINT(TRI.start_station_longitude, TRI.start_station_latitude),
    ZIPSTART.zip_code_geom)
INNER JOIN
  `bigquery-public-data.geo_us_boundaries.zip_codes` ZIPEND
  ON ST_WITHIN(
    ST_GEOGPOINT(TRI.end_station_longitude, TRI.end_station_latitude),
    ZIPEND.zip_code_geom)
INNER JOIN
  `bigquery-public-data.noaa_gsod.gsod20*` AS WEA
  ON PARSE_DATE("%Y%m%d", CONCAT(WEA.year, WEA.mo, WEA.da)) = DATE(TRI.starttime)
INNER JOIN `zip_codes.zip_code` AS ZIPSTARTNAME
  ON ZIPSTART.zip_code = CAST(ZIPSTARTNAME.zip AS STRING)

INNER JOIN `zip_codes.zip_code` AS ZIPENDNAME
  ON ZIPEND.zip_code = CAST(ZIPENDNAME.zip AS STRING)

WHERE
  -- This takes the weather data from one weather station
  WEA.wban = '94728' -- NEW YORK CENTRAL PARK
  -- Use data from 2014 and 2015
  AND EXTRACT(YEAR FROM DATE(TRI.starttime)) BETWEEN 2014 AND 2015
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13
```

---

[View Live Cyclistic Dashboard](https://public.tableau.com/app/profile/marc.jerome.colobong/viz/cyclistic_17723417749830/Home)

### Analysis Report
The analysis of New York City trip data from 2019 to 2020 transforms the initial
business problem into several high-value strategic insights regarding user behavior
and growth potential. While the service is highly seasonal, with total trip counts
beginning a steady rise in March and peaking in August or September before
dropping in December, the data reveals that the current product functions
primarily as a successful utility for daily transit. This is evidenced by the fact that
Subscribers account for the vast majority of trip minutes across almost all top
stations, particularly in core Manhattan and Brooklyn hubs like the Lower East
Side, Chelsea/Clinton, and Greenwich Village.

Regarding geographic expansion, the report identifies Northwest Queens as a
significant opportunity for the customer growth team. While the borough showed
no trip activity throughout 2019 and the first half of 2020, low-volume trips began
to emerge in the 3rd and 4th quarters of 2020. This shift indicates that the lack of
previous activity was likely due to a lack of infrastructure rather than a lack of
demand. To address the goal of understanding what customers want and how new
stations might alleviate demand, the data suggests that clustering new stations in
Northwest Queens. By targeting these emerging markets and timing major
marketing pushes for the March "shoulder" season to lead into the summer peak, Cyclistic can effectively transition casual users into long-term subscribers.

