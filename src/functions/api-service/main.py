import functions_framework

@functions_framework.http
def main2(request):
    print("request2")
    return "Hello from Cloud Run!2"
