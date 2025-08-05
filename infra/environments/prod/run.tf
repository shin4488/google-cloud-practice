module "run" {
  source = "../../resources/run"

  project_id = var.project_id
  region     = var.region
  action_service_account = module.iam.action_service_account_email
}
