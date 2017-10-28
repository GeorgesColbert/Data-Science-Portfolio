

data = LOAD 's3://budt758b-colbert/loudacre/ad_data2.txt' USING PigStorage(',')
            AS (campaign_id:chararray,
                date:chararray, 
                time:chararray,
                display_site:chararray, 
                placement:chararray,
                was_clicked:int, 
                cpc:int,
                keyword:chararray);


unique = DISTINCT data;

reordered2 = FOREACH unique GENERATE campaign_id, 
               REPLACE(date, '-', '/'),
               time,
               UPPER(TRIM(keyword)),
               display_site,
               placement,
               was_clicked,
               cpc;

STORE reordered2 INTO 's3://budt758b-colbert/home/output_ssh/ad_data2_ssh';
