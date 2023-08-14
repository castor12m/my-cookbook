from fastapi import FastAPI
from pydantic import BaseModel
import datetime
import os
import uvicorn

app = FastAPI()

class result_item(BaseModel):
    log: str
    code: str
    id: str
    label: str
    
class container_cmd_item(BaseModel):
    title: str
    cmd: str

class test_item(BaseModel):
    title: str
    test_label: str
    file_name: str

@app.get("/result/")
def result(item: result_item):
    item_dict = item.dict()
    if item.log:
        print(f'[{datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")[:-3]}] [log:{item.log}, code:{item.code}, id:{item.id}, label:{item.label}]')
        return {"message": "ok"}
    
    else:
        return {"message": "ng"}
    
@app.get("/container/")
def result(item: container_cmd_item):
    item_dict = item.dict()
    if item.title:
        if item.cmd:
            os.system(f'{item.cmd}')
            return {"message": "ok"}
    
    return {"message": "ng"}

@app.get("/test/")
def result(item: test_item):
    item_dict = item.dict()
    if item.title:
        return {"message": "ok"}
    
    return {"message": "ng"}
    
@app.get("/hello")
def hello():
    return {"message": "entry hello"}

@app.get("/")
def root():
    return {"message": "entry root"}

# if __name__ == "__main__":
#     uvicorn.run("router_example:app", host='0.0.0.0', port=5900, reload=True)    