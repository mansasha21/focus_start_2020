# Нужно реализовать насчет признак в рамках вашей гипотезы №2
import pandas as pd
from helpers import send_sql_query


def get_feature2():
    return send_sql_query(
        """
        SELECT  building_metadata.building_id
       ,2017.0 - year_built AS age
        FROM building_metadata
        """
    )


df = get_feature2()
df.to_feather("../data/feature2.fthr")
