```bash

    $ docker run -itd --privileged --net mac0 --ip 192.168.0.49 -p 443:443 --name ubuntu_dotnet ubuntu:jammy /bin/bash 

    $ docker exec -it ubuntu_dotnet bash
```

```
    $ apt-get update;
```