variable "project_id" {
  type        = string
  description = "Google Cloud プロジェクト ID"
}

variable "owner_email" {
  type        = string
  description = "オーナーのメールアドレス"
}

variable "owner_roles" {
  type        = list
  description = "オーナー用のロール"
}

variable "action_service_account_id" {
  type        = string
  description = "Google Cloud Action用サービスアカウント"
}

variable "terraform_service_account_id" {
  type        = string
  description = "Google Cloud Terraform用サービスアカウント"
}
