import functions_framework

@functions_framework.http
def main(request):
    return "Hello from Cloud Run!3"
    # テスト
