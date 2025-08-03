# IAMの定義

resource "google_project_iam_member" "user_owner" {
  member  = "user:efshinya48@gmail.com"
  project = "rising-abacus-465723-f5"
  role    = "roles/owner"
}
