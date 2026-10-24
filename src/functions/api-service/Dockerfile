# https://zenn.dev/abaoaqu/articles/00f87b9f99bc9e
FROM python:3.14-slim

# 標準出力をバッファせず、print などの出力がすぐに Cloud Run のログに出るようにする
ENV PYTHONUNBUFFERED True

# requirements.txt をコードと別にコピーすることで、コードの変更毎に pip install が再実行されるのを防止
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY . ./

CMD ["functions-framework", "--target=main2", "--port=8080", "--host=0.0.0.0"]
