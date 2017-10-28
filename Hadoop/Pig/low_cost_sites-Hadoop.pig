-- A: This glob loads only the ad_data1 and ad_data2 directories
data = LOAD '/user/training/ad_data[12]' AS (campaign_id:chararray,
             date:chararray, time:chararray,
             keyword:chararray, display_site:chararray,   
             placement:chararray, was_clicked:int, cpc:int);

-- B: Includes only records where the ad was clicked
clicked = FILTER data BY was_clicked == 1;


-- C: Groups the data by the 'display_site' field
grouped = GROUP clicked BY display_site;


-- D: Creates relation with 'display_site' and sum of click cost
totals = FOREACH grouped GENERATE group, SUM(clicked.cpc) AS cost;


-- E: Sorts the new relation in ascending order of cost
sorted = ORDER totals BY cost;


-- F: Displays just the first three records to the screen
top_three = LIMIT sorted 3;

DUMP top_three;
