# https://blog.naver.com/eye_mong85/222425275468
import pandas as pd
from glob import glob

file_names = glob("./*.csv") #폴더 내의 모든 csv파일 목록을 불러온다
total = pd.DataFrame() #빈 데이터프레임 하나를 생성한다

for file_name in file_names:
    temp = pd.read_csv(file_name, sep='구분자', encoding='utf-8') #csv파일을 하나씩 열어 임시 데이터프레임으로 생성한다
    total = pd.concat([total, temp]) #전체 데이터프레임에 추가하여 넣는다
    print(f'-- {file_name}')

total.to_csv("total.csv")