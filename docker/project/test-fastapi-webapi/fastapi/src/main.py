from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/hello")
def hello():
    return {"message": "안녕하세요 파이보"}

@app.get("/")
def root():
    return {"message": "Hello World"}

# if __name__ == "__main__":
#     uvicorn.run("router_example:app", host='0.0.0.0', port=5900, reload=True)    