# Нужно реализовать насчет признак в рамках вашей гипотезы №1
import pandas as pd
from helpers import send_sql_query


def get_feature1():
    return send_sql_query(
        """
        SELECT  building_id
            ,LOG(square_feet) AS logfeet
        FROM building_metadata
        """
    )


df = get_feature1()
df.to_feather("../data/feature1.fthr")
