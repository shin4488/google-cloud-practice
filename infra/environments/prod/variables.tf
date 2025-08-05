variable "project_id" {
  type        = string
  description = "GCP プロジェクト ID"
}

variable "region" {
  type        = string
  description = "GCP リージョン"
  default     = "asia-northeast1"
}

variable "default_service_account" {
  type        = string
  description = "Google Cloud デフォルトサービスアカウント"
}

variable "action_service_account_id" {
  type        = string
  description = "Google Cloud デフォルトサービスアカウント"
}

variable "terraform_service_account_id" {
  type        = string
  description = "Google Cloud デフォルトサービスアカウント"
}

variable "terraform_state_bucket" {
  type        = string
  description = "Google Cloud Storage バケット名"
}

variable "sport_bucket" {
  type        = string
  description = "Google Cloud Storage バケット名"
}

variable "owner_email" {
  type        = string
  description = "オーナーのメールアドレス"
}

variable "owner_roles" {
  type        = list
  description = "オーナー用のロール"
}
