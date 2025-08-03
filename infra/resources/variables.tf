variable "project_id" {
  type        = string
  description = "Google Cloud プロジェクト ID"
}

variable "region" {
  type        = string
  description = "Google Cloud リージョン"
  default     = "asia-northeast1"
}

variable "action_service_account" {
  type        = string
  description = "Google Cloud デフォルトサービスアカウント"
}
