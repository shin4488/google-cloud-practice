#! /bin/bash

set -euo pipefail

# gcloud 設定ディレクトリの権限（named volume をマウントしているため）
sudo mkdir -p /home/vscode/.config/gcloud/logs
sudo chown -R vscode:vscode /home/vscode/.config/gcloud
