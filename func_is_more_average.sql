CREATE FUNCTION is_more_average(building bigint, meter_type bigint, meter_reading_float float(8)) 
RETURNS boolean AS $$
DECLARE average_meter_reading float(8);
DECLARE answer boolean;

BEGIN
	SELECT 
	    AVG(mr.meter_reading) INTO average_meter_reading
	FROM measurement_results as mr
	WHERE mr.meter = $1 AND mr.building_id = $2;

	if average_meter_reading <= $3 then
		SELECT TRUE INTO answer;
	else
		SELECT FALSE INTO answer;
	end if;
	RETURN answer;
END;
$$ LANGUAGE PLpgSQL;
 
