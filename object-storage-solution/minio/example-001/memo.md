## 0. ref

```
MinIO를 바로 체험해 보실 수 있는 몇 가지 예제를 안내해 드리겠습니다.

MinIO Quickstart Guide

MinIO 공식 Quickstart Guide에서는 Docker를 이용해 간편하게 MinIO 서버를 실행하고 웹 UI를 통해 객체 스토리지를 관리하는 방법을 단계별로 설명하고 있습니다.
이 예제는 MinIO의 기본 기능(버킷 생성, 객체 업로드/다운로드 등)을 직접 확인할 수 있어 학습용으로 적합합니다.
자세한 내용은 공식 문서를 참고하시기 바랍니다(​).
Docker Compose를 이용한 MinIO 설치 예제

docker-compose.yml 파일을 작성하여 MinIO 서버를 컨테이너로 실행하는 방법입니다.
예를 들어, 아래와 같은 구성으로 MinIO 서버를 띄운 후, MinIO Client(mc) 또는 AWS SDK를 이용하여 객체 스토리지 작업을 수행할 수 있습니다.
```

```yaml
version: '3.7'

services:
  minio:
    image: minio/minio:latest
    container_name: minio
    ports:
      - "9000:9000"
      - "9001:9001"
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin
    command: server /data --console-address ":9001"
    volumes:
      - minio-data:/data

volumes:
  minio-data:
```  

```
위 예제를 실행한 후 브라우저에서 http://localhost:9001로 접속하여 MinIO 콘솔에 로그인할 수 있습니다.
프로그래밍 언어를 활용한 예제 (Python SDK 사용)

MinIO는 AWS S3와 호환되는 API를 제공하므로, boto3 라이브러리나 MinIO 전용 Python SDK를 이용하여 객체 업로드, 다운로드 등의 기능을 구현할 수 있습니다.
예를 들어, Python으로 간단한 스크립트를 작성하여 버킷 생성 및 파일 업로드 기능을 시험해 보실 수 있습니다.
```

```python
import boto3
from botocore.client import Config

# MinIO 서버 설정
s3 = boto3.resource('s3',
    endpoint_url='http://localhost:9000',
    aws_access_key_id='minioadmin',
    aws_secret_access_key='minioadmin',
    config=Config(signature_version='s3v4'),
    region_name='us-east-1'
)

# 버킷 생성
bucket_name = 'test-bucket'
s3.create_bucket(Bucket=bucket_name)

# 파일 업로드
data = b'Hello, MinIO!'
s3.Object(bucket_name, 'hello.txt').put(Body=data)
print("파일 업로드 완료")
```

```
이 스크립트를 통해 MinIO와의 연동 과정을 직접 경험해 보실 수 있습니다.
위와 같이 MinIO의 기본 설치부터 API 연동까지 다양한 예제를 통해 직접 체험해 보시면, MinIO의 개념과 사용법을 보다 쉽게 익히실 수 있습니다. 학습 목적에 맞게 단계별로 진행해 보시길 추천드립니다.
```

- 다음으로 접속하면
- minio web 버전으로 접속해서 확인 가능
    - http://localhost:9001/

