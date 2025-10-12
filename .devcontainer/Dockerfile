# Debian 12 (bookworm) ベースの Dev Containers Python 3.12
FROM mcr.microsoft.com/devcontainers/python:3.12-bookworm

# Google Cloud SDK を APT 経由でインストール（バージョン固定したければ "=<version>" 指定）
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
   | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] \
https://packages.cloud.google.com/apt cloud-sdk main" \
   | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
  && apt-get update && apt-get install -y \
   google-cloud-sdk \
   google-cloud-sdk-gke-gcloud-auth-plugin \
   kubectl \
   google-cloud-cli-skaffold \
   google-cloud-cli-minikube

# --- Docker CLI（DooD 用）---
# RUN . /etc/os-release; \
#    curl -fsSL https://download.docker.com/linux/debian/gpg \
#    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
#   && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
# https://download.docker.com/linux/debian ${VERSION_CODENAME} stable" \
#    | tee /etc/apt/sources.list.d/docker.list \
#   && apt-get update \
#   && apt-get install -y docker-ce-cli \
#   && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["bash", "-lc", "sleep infinity"]
