# https://zenn.dev/abaoaqu/articles/00f87b9f99bc9e
FROM python:3.14-slim

# 標準出力をバッファせず、print などの出力がすぐに Cloud Run のログに出るようにする
ENV PYTHONUNBUFFERED=True

# requirements.txt だけを先にコピーし、コードだけを変えたときは pip install の層をビルドキャッシュから再利用する
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY . ./

CMD ["functions-framework", "--target=main2", "--port=8080", "--host=0.0.0.0"]
