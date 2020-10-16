import pandas as pd
from helpers import send_sql_query
import sys

def get_base_part():
    """Реализуйте функцию которая будет извлекать из базы данных 
    
    1. Целевую переменную; (meter_reading)
    2. Идентификаторы для объединения с другими признаками; (building_id, meter)
    3. Время измерения. (timestamp_measurement)
    """
    return pd.DataFrame({
        "for_example": [1, 2, 3]
    })
    
df = get_base_part()
df.to_feather('../data/base_part.fthr')
