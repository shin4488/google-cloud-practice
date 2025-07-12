# Google Cloud Run Services

このプロジェクトは、Google Cloud RunでPythonアプリケーションを実行し、GitHubのmainブランチへのpush/マージで自動デプロイするための設定です。

## プロジェクト構成

```
google-cloud-practice/
├── services/
│   ├── api-service/          # REST APIサービス
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   └── worker-service/       # バックグラウンドタスク処理サービス
│       ├── app.py
│       ├── requirements.txt
│       └── Dockerfile
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actionsワークフロー
└── README.md
```

## サービス概要

### API Service
- **エンドポイント**: `/api/hello`, `/api/data`, `/health`
- **機能**: RESTful APIを提供
- **ポート**: 8080

### Worker Service
- **エンドポイント**: `/tasks`, `/tasks/<task_id>`, `/health`
- **機能**: バックグラウンドタスクの処理
- **ポート**: 8080

## セットアップ手順

### 1. Google Cloud Platformの設定

1. **GCPプロジェクトの作成**
   ```bash
   gcloud projects create YOUR_PROJECT_ID
   gcloud config set project YOUR_PROJECT_ID
   ```

2. **APIの有効化**
   ```bash
   gcloud services enable run.googleapis.com
   gcloud services enable cloudbuild.googleapis.com
   gcloud services enable artifactregistry.googleapis.com
   ```

3. **Artifact Registryの作成**
   ```bash
   gcloud artifacts repositories create cloud-run-services \
     --repository-format=docker \
     --location=asia-northeast1 \
     --description="Docker repository for Cloud Run services"
   ```

4. **サービスアカウントの作成**
   ```bash
   gcloud iam service-accounts create github-actions \
     --description="Service account for GitHub Actions" \
     --display-name="GitHub Actions"
   
   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/run.admin"
   
   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/artifactregistry.writer"
   
   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/iam.serviceAccountUser"
   ```

5. **サービスアカウントキーの作成**
   ```bash
   gcloud iam service-accounts keys create key.json \
     --iam-account=github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com
   ```

### 2. GitHubリポジトリの設定

1. **GitHub Secretsの設定**
   - `GCP_SA_KEY`: サービスアカウントキー（key.jsonの内容）

2. **ワークフローファイルの設定**
   - `.github/workflows/deploy.yml`の`PROJECT_ID`を実際のGCPプロジェクトIDに変更

### 3. ローカル開発環境

1. **依存関係のインストール**
   ```bash
   cd services/api-service
   pip install -r requirements.txt
   
   cd ../worker-service
   pip install -r requirements.txt
   ```

2. **ローカル実行**
   ```bash
   # API Service
   cd services/api-service
   python app.py
   
   # Worker Service
   cd services/worker-service
   python app.py
   ```

3. **Dockerでの実行**
   ```bash
   # API Service
   cd services/api-service
   docker build -t api-service .
   docker run -p 8080:8080 api-service
   
   # Worker Service
   cd services/worker-service
   docker build -t worker-service .
   docker run -p 8081:8080 worker-service
   ```

## デプロイ

### 自動デプロイ
mainブランチにpushまたはマージすると、GitHub Actionsが自動的にCloud Runにデプロイします。

### 手動デプロイ
```bash
# プロジェクトIDの設定
export PROJECT_ID=your-gcp-project-id
export GAR_LOCATION=asia-northeast1
export REPOSITORY=cloud-run-services

# API Service
cd services/api-service
docker build -t $GAR_LOCATION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/api-service:latest .
docker push $GAR_LOCATION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/api-service:latest

gcloud run deploy api-service \
  --image=$GAR_LOCATION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/api-service:latest \
  --platform=managed \
  --region=$GAR_LOCATION \
  --allow-unauthenticated

# Worker Service
cd ../worker-service
docker build -t $GAR_LOCATION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/worker-service:latest .
docker push $GAR_LOCATION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/worker-service:latest

gcloud run deploy worker-service \
  --image=$GAR_LOCATION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/worker-service:latest \
  --platform=managed \
  --region=$GAR_LOCATION \
  --allow-unauthenticated
```

## API使用例

### API Service
```bash
# ヘルスチェック
curl https://api-service-xxx.a.run.app/health

# Hello API
curl https://api-service-xxx.a.run.app/api/hello

# データ取得
curl https://api-service-xxx.a.run.app/api/data
```

### Worker Service
```bash
# ヘルスチェック
curl https://worker-service-xxx.a.run.app/health

# タスク作成
curl -X POST https://worker-service-xxx.a.run.app/tasks \
  -H "Content-Type: application/json" \
  -d '{"processing_time": 3}'

# タスク状況確認
curl https://worker-service-xxx.a.run.app/tasks/task_1

# 全タスク一覧
curl https://worker-service-xxx.a.run.app/tasks
```

## 新しいサービスの追加

1. `services/`ディレクトリに新しいサービスディレクトリを作成
2. `app.py`, `requirements.txt`, `Dockerfile`を作成
3. `.github/workflows/deploy.yml`のmatrixに新しいサービスを追加
4. 必要に応じて変更検知の設定を追加

## トラブルシューティング

### よくある問題
- **認証エラー**: サービスアカウントキーが正しく設定されているか確認
- **権限エラー**: サービスアカウントに必要な権限が付与されているか確認
- **ビルドエラー**: Dockerfileの構文やPythonの依存関係を確認

### ログの確認
```bash
# Cloud Runサービスのログ
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=api-service" --limit=50 --format="table(timestamp,textPayload)"
``` 