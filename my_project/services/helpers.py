import psycopg2
import pandas as pd

def send_sql_query(query):
    params = {
        'database': 'focus_start',
        'host': 'localhost',
        'user': 'focus',
        'password': 'start'
    }
    conn = psycopg2.connect(**params)
    raw_data = pd.read_sql_query(query, conn)
    conn.close()
    return raw_data
