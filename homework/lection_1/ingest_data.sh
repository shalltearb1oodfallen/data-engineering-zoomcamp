#!/bin/bash

docker run -d \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5789:5432 \
  postgres:latest

wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-01.csv.gz
gunzip green_tripdata_2019-01.csv.gz

wget https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv

csv_file='./green_tripdata_2019-01.csv'
csv_file2='./taxi+_zone_lookup.csv'
table_name='tripdata'
table_name2='taxi_zone'
export PGPASSWORD='root'
psql -h localhost -p 5789 -U root -d ny_taxi -c "
                                                create table if not exists ${table_name} (
                                                      vendorid                      integer
                                                    , lpep_pickup_datetime          timestamp
                                                    , lpep_dropoff_datetime         timestamp
                                                    , store_and_fwd_flag            boolean
                                                    , ratecodeid                    bigint
                                                    , pulocationid                  bigint
                                                    , dolocationid                  bigint
                                                    , passenger_count               bigint
                                                    , trip_distance                 float
                                                    , fare_amount                   float
                                                    , extra                         float
                                                    , mta_tax                       float
                                                    , tip_amount                    float
                                                    , tolls_amount                  float
                                                    , ehail_fee                     float
                                                    , improvement_surcharge         float
                                                    , total_amount                  float
                                                    , payment_type                  bigint
                                                    , trip_type                     bigint
                                                    , congestion_surcharge          float                                                    
                                                );

                                                create table if not exists ${table_name2} (
                                                      locationid                    integer
                                                    , borough                       varchar
                                                    , zone                          varchar
                                                    , service_zone                  varchar
                                                );
                                                "
psql -h localhost -p 5789 -U root -d ny_taxi -c "\COPY ${table_name} FROM '${csv_file}' with (FORMAT CSV, delimiter ',', HEADER 'true')"
psql -h localhost -p 5789 -U root -d ny_taxi -c "\COPY ${table_name2} FROM '${csv_file2}' with (FORMAT CSV, delimiter ',', HEADER 'true')"
