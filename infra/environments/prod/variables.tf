variable "project_id" {
  type        = string
  description = "GCP プロジェクト ID"
}

variable "region" {
  type        = string
  description = "GCP リージョン"
  default     = "asia-northeast1"
}

variable "action_service_account_id" {
  type        = string
  description = "GitHub Actions 用サービスアカウントのアカウント ID"
}

variable "terraform_service_account_id" {
  type        = string
  description = "Terraform の実行に使うサービスアカウントのアカウント ID"
}

variable "terraform_state_bucket" {
  type        = string
  description = "Terraform の state を保存するバケットの名前"
}

variable "sport_bucket" {
  type        = string
  description = "Google Cloud Storage バケット名"
}

variable "owner_email" {
  type        = string
  description = "オーナーの IAM メンバー（user:<メールアドレス> の形式）"
}

variable "owner_roles" {
  type        = list(any)
  description = "オーナー用のロール"
}
