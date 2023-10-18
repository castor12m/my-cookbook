mkdir ./config
echo 'ROW_LIMIT = 5000' >> ./config/superset_config.py
echo SECRET_KEY = \'Po4kCDDZnHK9cfhytBrke8Bti99L8A9Rj7BPRhV/fnHwM/iQJUkctrhL\' >> ./config/superset_config.py
#echo SQLALCHEMY_DATABASE_URI = \'sqlite:////db/superset.db\' >> ./config/superset_config.py
echo SQLALCHEMY_DATABASE_URI = \'sqlite:////sqlite_db/superset.db\' >> ./config/superset_config.py
echo 'WTF_CSRF_ENABLED = True' >> ./config/superset_config.py
echo 'WTF_CSRF_EXEMPT_LIST = []' >> ./config/superset_config.py
echo 'WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365' >> ./config/superset_config.py
echo MAPBOX_API_KEY = \'\' >> ./config/superset_config.py
