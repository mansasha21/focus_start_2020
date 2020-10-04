create table weather_train (
	site_id SERIAL NOT NULL,
	timestamp_measurement timestamp without time zone not null DEFAULT NULLIF('0000-00-00 00:00:00','0000-00-00 00:00:00')::timestamp,
	air_temperature float(8),
	cloud_coverage float(8), 
	dew_temperature float(8),
	precip_depth_1_hr float(8), 
	sea_level_pressure float(8), 
	wind_direction float(8), 
	wind_speed float(8)
);

COPY weather_train(
	site_id,
	timestamp_measurement,
	air_temperature, 
	cloud_coverage, 
	dew_temperature, 
	precip_depth_1_hr, 
	sea_level_pressure, 
	wind_direction, 
	wind_speed
) 
FROM '/home/lapltop/Рабочий стол/FocusStart/raw_data/weather_train.csv' DELIMITER ',' CSV HEADER;

create table building_metadata (
	site_id SERIAL NOT NULL,
	building_id SERIAL NOT NULL,
	primary_use varchar(128), 
	square_feet integer, 
	year_built integer, 
	floor_count integer
);

COPY building_metadata(
	site_id, 
	building_id, 
	primary_use, 
	square_feet, 
	year_built, 
	floor_count
) 
FROM '/home/lapltop/Рабочий стол/FocusStart/raw_data/building_metadata.csv' DELIMITER ',' CSV HEADER;

create table measurement_results (
	building_id SERIAL NOT NULL,
	meter integer,
	timestamp_measurement timestamp without time zone not null DEFAULT NULLIF('0000-00-00 00:00:00','0000-00-00 00:00:00')::timestamp, 
	meter_reading float(8)
);

COPY measurement_results(
	building_id, 
	meter, 
	timestamp_measurement, 
	meter_reading
) 
FROM '/home/lapltop/Рабочий стол/FocusStart/raw_data/measurement_results.csv' DELIMITER ',' CSV HEADER;

