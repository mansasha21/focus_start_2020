import pandas as pd
from helpers import send_sql_query
import sys


def get_base_part():
    """Реализуйте функцию которая будет извлекать из базы данных

    1. Целевую переменную; (meter_reading)
    2. Идентификаторы для объединения с другими признаками; (building_id, meter)
    3. Время измерения. (timestamp_measurement)
    """
    return send_sql_query(
        """
            SELECT  meter_reading
                ,building_id
                ,meter
                ,timestamp_measurement
            FROM measurement_results
            """
    )


df = get_base_part()
df.to_feather("../data/base_part.fthr")
