-- Note: You need to replace the s3 directory to your own 

data = LOAD 's3://budt758b-colbert/loudacre/ad_data1.txt' AS (keyword:chararray, 
               campaign_id:chararray,
               date:chararray, 
               time:chararray,
               display_site:chararray, 
               was_clicked:int, 
               cpc:int,
               country:chararray, 
               placement:chararray);

usa_only = FILTER data BY country == 'USA';

reordered = FOREACH usa_only GENERATE campaign_id, 
               date,
               time,
               UPPER(TRIM(keyword)),
               display_site,
               placement,
               was_clicked,
               cpc;

STORE reordered INTO 's3://budt758b-colbert/home/output_ssh/ad_data1_ssh';

