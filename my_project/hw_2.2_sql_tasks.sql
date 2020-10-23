--ЗАДАНИЕ 1: Посчитайте количество зданий, где установлено 2 и более типа счетчиков. 

 WITH meter_with_building AS (
SELECT  DISTINCT(meter) AS meter_1
       ,building_id
FROM measurement_results )
SELECT  COUNT(*)
FROM 
(
	SELECT  building_id
	FROM meter_with_building
	GROUP BY  building_id
	HAVING COUNT(meter_1) > 1
) AS result

/*ЗАДАНИЕ 2 (JOIN): Представим, что мы решили построить модель на этих данных и хотим собрать все признаки в кучу 
за последние день 2016 года. (если менее 5гб свободной оперативки, можете добавить ещё фильтры к основной таблице)
Соединить между собой все три таблицы (measurement_results, building_metadata, weather_train), 
с фильтром по дате от 30 декабря 2016 года. 
Учитывайте, что measurement_results является основной таблицей, где находится целевая переменная. 
*/
SELECT  A.*
       ,B.*
       ,C.site_id
       ,C.air_temperature
       ,C.cloud_coverage
       ,C.dew_temperature
       ,C.precip_depth_1_hr
       ,C.sea_level_pressure
       ,C.wind_direction
       ,C.wind_speed
FROM 
(measurement_results A
	LEFT JOIN building_metadata B
	ON A.building_id = B.building_id
)
LEFT JOIN weather_train C
ON B.site_id = C.site_id AND A.timestamp_measurement = C.timestamp_measurement
WHERE A.timestamp_measurement > '2016-12-30' 
/*ЗАДАНИЕ 3 (WITH): Давайте по генерируем гипотезы на основе наших данных! (не более 2ух - не нужно придумывать, те которые сложно посчитать).
Попробуем используя конструкцию WITH в одном запросе получить:
	2.1 Основную часть данных, которая состоит из:
		- идентификатор здания
		- тип счетчика
		- целевая переменная (показания счетчика)
	2.2 Запрос насчитывающий признак №1
	2.3 Запрос насчитывающий признак №2
Объединить все в один набор данных.
*/
 WITH main_table AS (
SELECT  building_id AS bid
       ,meter
       ,meter_reading
FROM measurement_results), feature_1_table AS (
SELECT  building_id
       ,LOG(square_feet) AS logfeet
FROM building_metadata), feature_2_table AS (
SELECT  building_metadata.building_id
       ,2017.0 - year_built AS age
FROM building_metadata)
SELECT  bid
       ,meter
       ,meter_reading
       ,logfeet
       ,age
FROM main_table
LEFT JOIN feature_1_table AS f1
ON main_table.bid = f1.building_id
LEFT JOIN feature_2_table AS f2
ON main_table.bid = f2.building_id
--ЗАДАНИЕ 4: Посчитайте накопительную сумму(используя оконную функцию) для каждого здания и типа счетчика.
SELECT  building_id
       ,meter
       ,meter_reading
       ,SUM(meter_reading) OVER(PARTITION BY building_id,meter ORDER BY timestamp_measurement) AS mr_cumsum
FROM measurement_results
/*ЗАДАНИЕ 5 (WITH): Напишите запрос(используя оконные функции), 
который уберет все дублирующие записи по полям building_id, meter 
и вернет самое новое значение.
*/
SELECT  building_id
       ,meter
       ,timestamp_measurement
FROM 
(
	SELECT  building_id
	       ,meter
	       ,timestamp_measurement
	       ,ROW_NUMBER() OVER (PARTITION BY building_id,meter ORDER BY timestamp_measurement DESC) rn
	FROM measurement_results 
) AS tmp
WHERE tmp.rn = 1  