
-- Question 1
-- docker build --help

-- Question 2
-- docker run -it python:3.9 bash
-- pip list

-- Question 3

select count(*) as counter
from tripdata
where date(lpep_pickup_datetime) = '2019-01-15'
and date(lpep_dropoff_datetime) = '2019-01-15';

-- Question 4

select max(trip_distance) as distance
	, date(lpep_pickup_datetime) as pickup
from tripdata t  
group by date(lpep_pickup_datetime)
order by distance desc
limit 1;


-- Question 5

select count(passenger_count) as counter
	, passenger_count 
from tripdata 
where passenger_count in (2,3)
and date(lpep_pickup_datetime) = '2019-01-01'
group by passenger_count ;


-- Question 6

select max(tpd.tip_amount) as max_amount
	, txz.zone as dropout_zone 
from tripdata as tpd

inner join taxi_zone as txz
	on tpd.dolocationid = txz.locationid
	
inner join taxi_zone as tze
	on tpd.pulocationid = tze.locationid 
	
where tze.zone = 'Astoria'

group by txz.zone

order by max_amount desc

limit 1;

	