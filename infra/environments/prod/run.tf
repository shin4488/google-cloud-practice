module "run" {
  source = "../../resources/run"

  project_id = var.project_id
  region     = var.region
  action_service_account = "${var.action_service_account_id}@${var.project_id}.iam.gserviceaccount.com"
}
