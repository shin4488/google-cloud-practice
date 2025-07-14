FROM python:3.13-slim

# Cloud Run のログに、ステートメントとログメッセージが即座に出力されるようにする
ENV PYTHONUNBUFFERED True

# requirements.txt をコードと別にコピーすることで、コードの変更毎に pip install が再実行されるのを防止
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# ローカルのコードをコンテナイメージにコピー
WORKDIR /app
COPY . ./

CMD ["functions-framework", "--target=main", "--port=8080"]
