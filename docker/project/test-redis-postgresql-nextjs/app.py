import redis
import psycopg2
import json
from datetime import datetime
from time import sleep

# Connect to Redis
r = redis.Redis(host='localhost', port=6379, db=0)

# Connect to PostgreSQL
conn = psycopg2.connect(database="yourdb", user="youruser", password="yourpassword", host="localhost", port="5432")
cursor = conn.cursor()

while True:
    data_values = r.hgetall("data_values")
    for key, value in data_values.items():
        # Parse key and extract data type
        data_type = key.split('.')[1]
        
        # Parse value using data format
        # ...

        # Insert data into PostgreSQL table
        cursor.execute("INSERT INTO data_table (data_type, value, timestamp) VALUES (%s, %s, %s)", (data_type, parsed_value, datetime.now()))
        conn.commit()
    sleep(0.5)