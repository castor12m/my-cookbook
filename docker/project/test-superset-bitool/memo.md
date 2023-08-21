

### superset

```bash
    $ docker run -it -d -p 8088:8088 -v ./sqlite_db:/sqlite_db --name superset_test naraspace/base:0.1
    $ docker exec -it superset_test /bin/bash
```


#### 방법 1

https://passwd.tistory.com/entry/Superset-%EC%84%A4%EC%B9%98-%EB%B0%8F-%EC%8B%A4%ED%96%89


```
apt -y update
apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip libsasl2-dev libldap2-dev

python3 -m venv venv
. ./venv/bin/activate

#apt-get install -y sqlite libsqlite-dev
#mkdir /db
#/usr/bin/sqlite /db/test.db
apt-get install -y libsqlite-dev

echo 'export FLASK_APP=superset' >> ~/.bashrc
echo 'export PYTHONPATH="${PYTHONPATH}:/src/config"' >> ~/.bashrc
. ~/.bashrc

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
```
 postgresql-devel
```bash
    $ apt -y update
    $ apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip libsasl2-dev libldap2-dev

    $ python3 -m venv venv
    $ . ./venv/bin/activate

    $ apt-get install -y sqlite libsqlite-dev
    $ mkdir /db
    $ /usr/bin/sqlite /db/test.db
    
    $ echo 'export FLASK_APP=superset' >> ~/.bashrc
    $ echo 'export PYTHONPATH="${PYTHONPATH}:/src/config"' >> ~/.bashrc
    $ . ~/.bashrc

    $ mkdir ./config
    $ echo 'ROW_LIMIT = 5000' >> ./config/superset_config.py
    $ echo SECRET_KEY = \'Po4kCDDZnHK9cfhytBrke8Bti99L8A9Rj7BPRhV/fnHwM/iQJUkctrhL\' >> ./config/superset_config.py
    $ echo SQLALCHEMY_DATABASE_URI = \'sqlite:////db/superset.db\' >> ./config/superset_config.py
    $ echo 'WTF_CSRF_ENABLED = True' >> ./config/superset_config.py
    $ echo 'WTF_CSRF_EXEMPT_LIST = []' >> ./config/superset_config.py
    $ echo 'WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365' >> ./config/superset_config.py
    $ echo MAPBOX_API_KEY = \'\' >> ./config/superset_config.py

    #$ pip install wtforms==2.3.3
    $ pip install psycopg2-binary
    $ pip install pysqlite
    $ pip install sqlparse==0.4.3
    $ pip install marshmallow-enum
    $ pip install --upgrade setuptools pip
    $ pip install apache-superset


    $ superset --help
    결과 >>>
        Error: Could not locate a Flask application. You did not provide the "FLASK_APP" environment variable, and a "wsgi.py" or "app.py" module was not found in the current directory.

        Usage: superset [OPTIONS] COMMAND [ARGS]...

        This is a management script for the Superset application.

        Options:
        - .....

    $ superset db upgrade


    # 직접해야함..
    $ superset fab create-admin

    # 예제 확인하고 싶으면...
    #$ superset load_examples

    $ superset init

    # $ superset run -p 8088 --with-threads --reload --debugger
    # or

    # 도커에서 할려면 이거 사용
    $ superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger
```


#### 방법 1. 과정 중 에러

##### ERROR: Failed building wheel for apache-superset 에러 발생 시

아래 명령어를 실행하여 해결한다.

```bash
    $ pip install wheel
```

##### AttributeError: module 'sqlparse.keywords' has no attribute 'FLAGS

os_settings/window/superset/memo.md 참조


##### A Default SECRET_KEY was detected, please use superset_config.py to override it. 발생 시

```
    $ openssl rand -base64 42.
```

{원하는 곳}/superset_config.py

```bash
    $ export PYTHONPATH="${PYTHONPATH}:{원하는 곳}"

```

```py
    # Superset specific config
    ROW_LIMIT = 5000

    # Flask App Builder configuration
    # Your App secret key will be used for securely signing the session cookie
    # and encrypting sensitive information on the database
    # Make sure you are changing this key for your deployment with a strong key.
    # Alternatively you can set it with `SUPERSET_SECRET_KEY` environment variable.
    # You MUST set this for production environments or the server will not refuse
    # to start and you will see an error in the logs accordingly.
    SECRET_KEY = 'YOUR_OWN_RANDOM_GENERATED_SECRET_KEY'

    # The SQLAlchemy connection string to your database backend
    # This connection defines the path to the database that stores your
    # superset metadata (slices, connections, tables, dashboards, ...).
    # Note that the connection information to connect to the datasources
    # you want to explore are managed directly in the web UI
    SQLALCHEMY_DATABASE_URI = 'sqlite:////path/to/superset.db'

    # Flask-WTF flag for CSRF
    WTF_CSRF_ENABLED = True
    # Add endpoints that need to be exempt from CSRF protection
    WTF_CSRF_EXEMPT_LIST = []
    # A CSRF token that expires in 1 year
    WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365

    # Set this API key to enable Mapbox visualizations
    MAPBOX_API_KEY = ''
```
or
```
    $ export SUPERET_SECRET_KEY='YOUR_OWN_RANDOM_GENERATED_SECRET_KEY'

    ex)
    $ export SUPERET_SECRET_KEY=Po4kCDDZnHK9cfhytBrke8Bti99L8A9Rj7BPRhV/fnHwM/iQJUkctrhL
```

파이썬 환경 변수 확인법

```bash
    $ echo $PYTHONPATH
    >>>
    :/src

    $ echo $pythonpath
    >>>
    # 소문자로 확인시 없는 거보니 대소문자 가림! 주의!

    $ python -c "import sys; print('\n'.join(sys.path))"
    >>>
    /src
    /usr/lib/python310.zip
    /usr/lib/python3.10
    /usr/lib/python3.10/lib-dynload
    /src/venv/lib/python3.10/site-packages
```

##### Error: Could not locate a Flask application. You did not provide the "FLASK_APP" environment variable, and a "wsgi.py" or "app.py" module was not found in the current directory.

```bash
    $ export FLASK_APP=superset
    $ pip install wtforms==2.4.3
```

##### ERROR:flask_appbuilder.security.sqla.manager:DB Creation and initialization failed: (sqlite3.OperationalError) unable to open database file

```
    $ pip install pysqlite3
```

```
    $ apt install sqlite3
```


##### postgreSQL

```bash
    (cd ~/temp)
    $ bash -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list. d/pgdg.list'
    $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    $ apt-get update

    # postgresql 설치
    $ apt install -y postgresql postgresql-contrib
    or
    # 특정 버전의 PostgreSQL를 설치하면 아래와 같이 작성합니다.
    $ sudo apt-get -y install postgresql-14

    # postgresql python 라이브러리 설치
    $ pip install psycopg[binary]

    # 실행
    $ service postgresql start

    # 실행 확인
    $ service postgresql status

```

##### sqlite3

https://stackoverflow.com/questions/33711818/embed-sqlite-database-to-docker-container

```
    FROM ubuntu:trusty
    RUN sudo apt-get -y update
    RUN sudo apt-get -y upgrade
    RUN sudo apt-get install -y sqlite3 libsqlite3-dev
    apt-get install -y sqlite libsqlite-dev
    RUN mkdir /db
    RUN /usr/bin/sqlite3 /db/test.db
    CMD /bin/bash
```