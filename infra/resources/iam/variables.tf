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
