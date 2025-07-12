import functions_framework

@functions_framework.http
def main(request):
    print(request)
    print("テスト4")
    return "Hello from Cloud Run!"
