# Python 3.11のベースイメージを使用
FROM python:3.11-slim

# 作業ディレクトリを設定
WORKDIR /app

# 依存関係をコピーしてインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションコードをコピー
COPY . .

# 非rootユーザーでアプリケーションを実行
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# ポート8080を公開
EXPOSE 8080

# Gunicornを使用してアプリケーションを起動
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "1", "app:app"] 