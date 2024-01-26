
## 0. 참고 

https://github.com/mingrammer/diagrams.git


## 1. 설치 (on Mac OS)

```
    brew install graphviz 

    # using pip (pip3)
    $ pip install diagrams
```


## 2. 파일 생성 

```

# diagram.py
from diagrams import Diagram
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.network import ELB

with Diagram("Web Service", show=False):
    ELB("lb") >> EC2("web") >> RDS("userdb")
```