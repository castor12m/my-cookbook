apt -y update
apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip libsasl2-dev libldap2-dev

apt-get install -y libsqlite-dev
echo 'export FLASK_APP=superset' >> ~/.bashrc
echo 'export PYTHONPATH="${PYTHONPATH}:/src/config"' >> ~/.bashrc

export FLASK_APP=superset
export PYTHONPATH="${PYTHONPATH}:/src/config"

mkdir ./config
echo 'ROW_LIMIT = 5000' >> ./config/superset_config.py
echo SECRET_KEY = \'Po4kCDDZnHK9cfhytBrke8Bti99L8A9Rj7BPRhV/fnHwM/iQJUkctrhL\' >> ./config/superset_config.py
#echo SQLALCHEMY_DATABASE_URI = \'sqlite:////db/superset.db\' >> ./config/superset_config.py
echo SQLALCHEMY_DATABASE_URI = \'sqlite:////sqlite_db/superset.db\' >> ./config/superset_config.py
echo 'WTF_CSRF_ENABLED = True' >> ./config/superset_config.py
echo 'WTF_CSRF_EXEMPT_LIST = []' >> ./config/superset_config.py
echo 'WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365' >> ./config/superset_config.py
echo MAPBOX_API_KEY = \'\' >> ./config/superset_config.py

#pip install wtforms==2.3.3
pip install psycopg2-binary
pip install pysqlite
pip install sqlparse==0.4.3
pip install marshmallow-enum
pip install --upgrade setuptools pip
pip install apache-superset

superset db upgrade

# #https://github.com/apache/superset/discussions/12997
superset fab create-admin --username admin --firstname admin --lastname admin --email admin@admin.com  --password admin

superset init
