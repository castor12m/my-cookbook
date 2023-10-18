

```bash
    #https://hub.docker.com/r/apache/superset
    $ docker run -d -p 8080:8088 -e "SUPERSET_SECRET_KEY=your_secret_key_here" --name superset apache/superset
    ex)
    $ docker run -d -p 8080:8088 -e "SUPERSET_SECRET_KEY=1234" --name superset apache/superset
```