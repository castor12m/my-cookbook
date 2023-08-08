from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/extract_data', methods=['GET'])
def extract_data():
    # Trigger data extraction process
    # ...
    return jsonify({"message": "Data extraction triggered"})

if __name__ == '__main__':
    app.run()