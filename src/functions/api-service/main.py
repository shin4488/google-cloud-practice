import functions_framework

@functions_framework.http
def main(request):
    print(request)
    return "Hello from Cloud Run!テスト7"
    # テスト
