import functions_framework

@functions_framework.http
def main(request):
    print(request)
    return "Hello from Cloud Run!テスト8"
    # テスト

@functions_framework.http
def main2(request):
    print("request2")
    return "Hello from Cloud Run!2"
