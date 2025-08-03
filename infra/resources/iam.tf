# IAMの定義

resource "google_project_iam_member" "user_owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "user:efshinya48@gmail.com"
}
