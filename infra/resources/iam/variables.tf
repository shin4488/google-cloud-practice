variable "project_id" {
  type        = string
  description = "Google Cloud プロジェクト ID"
}

variable "owner_email" {
  type        = string
  description = "オーナーの IAM メンバー（user:<メールアドレス> の形式）"
}

variable "owner_roles" {
  type        = list
  description = "オーナー用のロール"
}

variable "action_service_account_id" {
  type        = string
  description = "GitHub Actions 用サービスアカウントのアカウント ID"
}

variable "terraform_service_account_id" {
  type        = string
  description = "Terraform の実行に使うサービスアカウントのアカウント ID"
}
