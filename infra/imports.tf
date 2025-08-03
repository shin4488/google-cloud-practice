# GCS バケット
import {
  to = module.resources.google_storage_bucket.workflows_sports # 任意：Terraform 内でのローカル識別子
  id = "workflows-sports" # 必須：GCS 上のバケット名と完全一致
}

import {
  to = module.resources.google_storage_bucket.terraform_tfstate_manager # 任意：Terraform 内でのローカル識別子
  id = "terraform-tfstate-manager" # 必須：GCS 上のバケット名と完全一致
}

# Cloud Run サービス
import {
  to = module.resources.google_cloud_run_v2_service.api_service # 任意：Terraform 内でのローカル識別子
  id = "projects/${var.project_id}/locations/${var.region}/services/api-service" # 必須：完全修飾サービス ID と一致
}

# プロジェクト IAM メンバー
import {
  to = module.resources.google_project_iam_member.user_owner # 任意：Terraform 内でのローカル識別子
  id = "${var.project_id} roles/owner user:efshinya48@gmail.com" # 必須："<PROJECT> roles/<ROLE> <MEMBER>" 形式で完全一致
}
