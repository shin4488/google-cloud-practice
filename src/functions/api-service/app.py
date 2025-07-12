from flask import Flask, jsonify
import os
from datetime import datetime

app = Flask(__name__)

def main():
    print("Hello from API Service!")

# ヘルスチェック用エンドポイント（テスト）
@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({
        'status': 'healthy',
        'service': 'api-service',
        'timestamp': datetime.now().isoformat()
    }), 200

# メインAPI
@app.route('/api/hello', methods=['GET'])
def hello():
    return jsonify({
        'message': 'Hello from API Service!',
        'service': 'api-service',
        'timestamp': datetime.now().isoformat()
    }), 200

# データ取得API
@app.route('/api/data', methods=['GET'])
def get_data():
    sample_data = {
        'users': [
            {'id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
            {'id': 2, 'name': 'Bob', 'email': 'bob@example.com'}
        ],
        'total': 2,
        'timestamp': datetime.now().isoformat()
    }
    return jsonify(sample_data), 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(debug=True, host='0.0.0.0', port=port) 