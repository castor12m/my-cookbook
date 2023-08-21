FROM preset/superset

ENV SUPERSET_SECRET_KEY 1234

WORKDIR /app

RUN pip install mysqlclient

RUN pip install sqlalchemy-redshift

USER superset


VOLUME /app/superset