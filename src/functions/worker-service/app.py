from flask import Flask, jsonify, request
import os
import time
import threading
from datetime import datetime
import json

app = Flask(__name__)

# シンプルなインメモリタスクキュー
task_queue = []
task_results = {}
task_counter = 0

def process_task(task_id, task_data):
    """バックグラウンドでタスクを処理"""
    print(f"Processing task {task_id}: {task_data}")
    
    # 模擬的な処理時間
    processing_time = task_data.get('processing_time', 5)
    time.sleep(processing_time)
    
    # 結果を保存
    task_results[task_id] = {
        'status': 'completed',
        'result': f"Task {task_id} completed successfully",
        'processed_at': datetime.now().isoformat(),
        'processing_time': processing_time
    }
    
    print(f"Task {task_id} completed")

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({
        'status': 'healthy',
        'service': 'worker-service',
        'timestamp': datetime.now().isoformat(),
        'active_tasks': len([t for t in task_results.values() if t['status'] == 'processing']),
        'completed_tasks': len([t for t in task_results.values() if t['status'] == 'completed'])
    }), 200

@app.route('/tasks', methods=['POST'])
def create_task():
    global task_counter
    task_counter += 1
    task_id = f"task_{task_counter}"
    
    task_data = request.get_json() or {}
    
    # タスクを開始
    task_results[task_id] = {
        'status': 'processing',
        'created_at': datetime.now().isoformat()
    }
    
    # バックグラウンドでタスクを処理
    thread = threading.Thread(target=process_task, args=(task_id, task_data))
    thread.daemon = True
    thread.start()
    
    return jsonify({
        'task_id': task_id,
        'status': 'processing',
        'created_at': datetime.now().isoformat()
    }), 201

@app.route('/tasks/<task_id>', methods=['GET'])
def get_task_status(task_id):
    if task_id not in task_results:
        return jsonify({'error': 'Task not found'}), 404
    
    return jsonify({
        'task_id': task_id,
        **task_results[task_id]
    }), 200

@app.route('/tasks', methods=['GET'])
def list_tasks():
    return jsonify({
        'tasks': [
            {'task_id': tid, **data} 
            for tid, data in task_results.items()
        ],
        'total': len(task_results)
    }), 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(debug=True, host='0.0.0.0', port=port) 