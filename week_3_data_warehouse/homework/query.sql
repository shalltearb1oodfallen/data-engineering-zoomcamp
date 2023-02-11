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

-- question 2
select distinct count(affiliated_base_number) as counter
from `datazoomcamp.fhv_2019_big_query`;

select distinct count(affiliated_base_number) as counter
from `datazoomcamp.fhv_2019`;

-- question 3
select count(*) as counter
from `datazoomcamp.fhv_2019_big_query`
where PUlocationID is null
and DOlocationID is null

-- question 4

create table if not exists
datazoomcamp.fhv_2019_partion_cluster
partition by date(pickup_datetime)
cluster by affiliated_base_number as
(select *
from `datazoomcamp.fhv_2019_big_query`);

-- question 5

select distinct Affiliated_base_number 
from `datazoomcamp.fhv_2019_big_query`
where pickup_datetime >= '2019-03-01'
and pickup_datetime <= '2019-03-31';

select distinct Affiliated_base_number 
from `datazoomcamp.fhv_2019_partion_cluster`
where pickup_datetime >= '2019-03-01'
and pickup_datetime <= '2019-03-31';

