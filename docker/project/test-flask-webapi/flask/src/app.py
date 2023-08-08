from flask import Flask, jsonify

app = Flask(__name__)

# https://www.activestate.com/blog/flask-vs-django/
app.config["DEBUG"] = True

@app.route('/extract_data', methods=['GET'])
def extract_data():
    # Trigger data extraction process
    # ...
    return jsonify({"message": "Data extraction triggered"})

@app.route('/')
def hello_pybo():
    return 'Hello, Pybo!'

if __name__ == '__main__':
    #app.run()
    
    # flask port 설정 변경
    # https://webisfree.com/2018-01-19/python-%EC%8B%A4%ED%96%89%EC%8B%9C-5000-%ED%8F%AC%ED%8A%B8%EB%A5%BC-80-%ED%8F%AC%ED%8A%B8-%EB%B3%80%EA%B2%BD%ED%95%98%EA%B8%B0
    # https://velog.io/@rhee519/compare-web-frameworks
    app.run(host='0.0.0.0', port=5900) 
    #app.run(host='0.0.0.0', port=5900, debug=True)
    #app.run(host='0.0.0.0', port=5900, debug=False)