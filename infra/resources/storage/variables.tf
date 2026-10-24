variable "project_id" {
  type        = string
  description = "Google Cloud プロジェクト ID"
}

variable "region" {
  type        = string
  description = "Google Cloud リージョン"
}

variable "terraform_state_bucket" {
  type        = string
  description = "Terraform の state を保存するバケットの名前"
}

variable "sport_bucket" {
  type        = string
  description = "Google Cloud Storage バケット名"
}
