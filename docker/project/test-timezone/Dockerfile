FROM naraspace/base:0.1 AS build

WORKDIR /src


FROM build AS build_fsw
WORKDIR /src/fsw

CMD ["python", "app.py"]