from flask import Flask, request, jsonify
from metamask import handle_metamask_login
from ipfs import upload_file_to_ipfs

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

def display_models():
    models_data = fetch_models_from_polygon()  # Implement this function to fetch data from Polygon and IPFS
    sorted_models_data = sorted(models_data, key=lambda x: x['timestamp'], reverse=True)
    return render_template('display.html', models_data=sorted_models_data)

@app.route('/login', methods=['POST'])
def login():
    content = request.json
    return handle_metamask_login(content)

@app.route('/upload', methods=['POST'])
def upload_file():
    return upload_file_to_ipfs(request)


if __name__ == '__main__':
    app.run(debug=True)
