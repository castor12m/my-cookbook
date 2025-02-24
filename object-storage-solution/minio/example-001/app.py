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