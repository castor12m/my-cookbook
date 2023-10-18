FROM naraspace/base:0.1 AS base
WORKDIR /src

ENV SUPERSET_SECRET_KEY 1234

COPY . .

RUN apt update
RUN apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip libsasl2-dev libldap2-dev
RUN apt install -y libsqlite-dev

RUN echo 'export FLASK_APP=superset' >> ~/.bashrc
RUN echo 'export PYTHONPATH="${PYTHONPATH}:/src/config"' >> ~/.bashrc
RUN export FLASK_APP=superset
RUN export PYTHONPATH="${PYTHONPATH}:/src/config"

RUN bash ./script/file_setting.sh

RUN pip install psycopg2-binary

# https://stackoverflow.com/questions/19530974/how-can-i-add-the-sqlite3-module-to-python
#RUN pip install pysqlite
# --> 설치 안해도 필요없다함. 기본 라이브러리에 속해있다고..

RUN pip install sqlparse==0.4.3
RUN pip install marshmallow-enum
RUN pip install --upgrade setuptools pip
RUN pip install apache-superset

ENV FLASK_APP superset
ENV PYTHONPATH "${PYTHONPATH}:/src/config"

FROM base AS final
WORKDIR /src
RUN mkdir -p /sqlite_db

VOLUME ["./db_data/sqlite", "/sqlite_db"]

RUN superset db upgrade
RUN superset fab create-admin --username admin --firstname admin --lastname admin --email admin@admin.com  --password admin
RUN superset init

#ENTRYPOINT [ "tail", "-f", "/dev/null" ]
ENTRYPOINT [ "bash", "./script/run.sh" ]