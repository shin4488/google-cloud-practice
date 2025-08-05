# IAMの定義

resource "google_project_iam_member" "user_owner" {
  for_each = toset(var.owner_roles)

  project = var.project_id
  role    = each.key
  member  = var.owner_email
}

resource "google_service_account" "action" {
  account_id                   = var.action_service_account_id
  create_ignore_already_exists = null
  description                  = "GitHub Actionsから使用されるサービスアカウント。"
  disabled                     = false
  display_name                 = "Action Service Account"
  project                      = var.project_id
}

resource "google_service_account" "terraform" {
  account_id                   = var.terraform_service_account_id
  create_ignore_already_exists = null
  description                  = null
  disabled                     = false
  display_name                 = "terraform"
  project                      = var.project_id
}
