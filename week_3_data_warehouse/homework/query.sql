-- preparation:

LOAD DATA OVERWRITE datazoomcamp.fhv_2019_big_query
FROM FILES (
  format = 'CSV',
  uris = ['gs://zoomcamp_us/lection_3/*.csv.gz']);


CREATE EXTERNAL TABLE datazoomcamp.fhv_2019 
OPTIONS (
  format = 'csv',
  uris = ['gs://zoomcamp_us/lection_3/*.csv.gz']
);

-- question 1:
select count(*) as counter
from datazoomcamp.fhv_2019;


