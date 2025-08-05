# GCS バケット
import {
  to = module.storage.google_storage_bucket.workflows_sports # 任意：Terraform 内でのローカル識別子
  id = "workflows-sports" # 必須：GCS 上のバケット名と完全一致
}

import {
  to = module.storage.google_storage_bucket.terraform_tfstate_manager # 任意：Terraform 内でのローカル識別子
  id = "terraform-tfstate-manager" # 必須：GCS 上のバケット名と完全一致
}

# Cloud Run サービス
import {
  to = module.run.google_cloud_run_v2_service.api_service # 任意：Terraform 内でのローカル識別子
  id = "projects/${var.project_id}/locations/${var.region}/services/api-service" # 必須：完全修飾サービス ID と一致
}

# サービスアカウント
import {
  to = module.iam.google_service_account.action
  id = "projects/${var.project_id}/serviceAccounts/${var.action_service_account_id}@${var.project_id}.iam.gserviceaccount.com"
}

import {
  to = module.iam.google_service_account.terraform
  id = "projects/${var.project_id}/serviceAccounts/${var.terraform_service_account_id}@${var.project_id}.iam.gserviceaccount.com"
}
