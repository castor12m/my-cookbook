### Installation

https://gist.github.com/mark05e/d9cccae129dd11a21d7219eddd7d9923

```batch
    :: Create directory to host the files
    mkdir D:\superset
    cd /d D:\superset

    :: Check Versions
    python --version
    pip --version
    systeminfo | findstr /C:"OS"

    :: Upgrade Setuptools & PIP
    pip install --upgrade setuptools pip

    :: Create Virtual Environment named venv
    python -m venv venv

    :: Activate Virtual Environment
    venv\Scripts\activate

    :: Workaround - Install PIP within Virtual Environment
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py --ssl-no-revoke
    python get-pip.py

    :: Workaround - Upgrade Setuptools & PIP within venv
    pip install --upgrade setuptools pip

    :: (OUTDATED) Install Superset Requirements - Not required towards end of 2020
    :: -- ref: https://gist.github.com/mark05e/d9cccae129dd11a21d7219eddd7d9923#gistcomment-3614048
    :: curl https://raw.githubusercontent.com/apache/incubator-superset/master/requirements.txt -o requirements.txt --ssl-no-revoke
    :: pip install -r requirements.txt

    :: Install Superset
    pip install apache-superset

    :: (OUTDATED) Workaround - Install specific versions for compatibility (USE WITH CAUTION - ONLY IF NEEDED)
    :: pip uninstall pandas
    :: pip install pandas==0.23.4
    :: pip install Flask==1.0
    :: pip install SQLAlchemy==1.2.18

    :: Install DB Drivers - Postgres & MS SQL
    pip install psycopg2
    pip install pymssql

    :: Open Scripts folder to do superset related stuff
    cd venv\Scripts

    :: Create application database
    python superset db upgrade

    :: Create admin user
    set FLASK_APP=superset
    flask fab create-admin

    :: Load some data to play with (optional)
    python superset load_examples

    :: Create default roles and permissions
    python superset init

    :: Start web server on port 8088
    python superset run -p 8088 --with-threads --reload --debugger

    (https://vishalsinghji.medium.com/apache-superset-installation-in-windows-492cf85535a7)
    http://127.0.0.1:8088/
```


### 주의

https://zambbon.tistory.com/entry/AttributeError-sqlparse


##### AttributeError: module 'sqlparse.keywords' has no attribute 'FLAGS

```bash

    pip show sqlparse

    (만약에 0.4.4 버전 이상이라면 다운그레이드가 필요하다.)
    pip install sqlparse==0.4.3
```


##### secret_key 관련 경고

```
    --------------------------------------------------------------------------------
                                        WARNING
    --------------------------------------------------------------------------------
    A Default SECRET_KEY was detected, please use superset_config.py to override it.
    Use a strong complex alphanumeric string and use a tool to help you generate 
    a sufficiently random sequence, ex: openssl rand -base64 42
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    Refusing to start due to insecure SECRET_KEY
```

본인의 특정 폴더에 superset_config.py 생성

```py
    (config/superset_config.py)
    FEATURE_FLAGS = {
        'CLIENT_CACHE': True,
        'ENABLE_EXPLORE_JSON_CSRF_PROTECTION': True,
        'PRESTO_EXPAND_DATA': True,
    }


    SECRET_KEY = ''
```

```bash
    # ubuntu
    $ export SUPERSET_CONFIG_PATH='config/superset_config.py'

    # window
    $ set SUPERSET_CONFIG_PATH='config/superset_config.py'
```


##### FLASK_APP 관련 에러

https://github.com/apache/superset/issues/23861

```
    $env:FLASK_APP="{SupersetPath}\venv\Lib\site-packages\superset\app.py"
```

#### ModuleNotFoundError: No module named 'marshmallow-enum'


```bash
    $ pip install marshmallow-enum
```