#! /bin/bash

set -euo pipefail

# gcloud 設定ディレクトリの権限（named volume をマウントしているため）
sudo mkdir -p /home/vscode/.config/gcloud/logs
sudo chown -R vscode:vscode /home/vscode/.config/gcloud

# # docker.sock の GID を取得
# DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
# # その GID のグループを用意（既存でもOK）
# sudo groupadd -for -g "$DOCKER_GID" docker-host
# # vscode をそのグループに追加
# sudo usermod -aG docker-host "$USER"
# # グループに書き込み権を付与
# sudo chmod g+w /var/run/docker.sock

sudo chmod o=rw /var/run/docker.sock
