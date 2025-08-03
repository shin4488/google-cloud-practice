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

variable "action_service_account" {
  type        = string
  description = "Google Cloud デフォルトサービスアカウント"
}
