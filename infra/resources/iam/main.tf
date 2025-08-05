# IAMの定義

resource "google_project_iam_member" "user_owner" {
  for_each = toset(var.owner_roles)

  project = var.project_id
  role    = each.key
  member  = var.owner_email
}
