# GCS バケット
import {
  to = module.storage.google_storage_bucket.workflows_sports
  id = "workflows-sports"
}

import {
  to = module.storage.google_storage_bucket.terraform_tfstate_manager
  id = "terraform-tfstate-manager"
}

# Cloud Run サービス
import {
  to = module.run.google_cloud_run_v2_service.api_service
  id = "projects/${var.project_id}/locations/${var.region}/services/api-service"
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
