module "resources" {
  source = "./resources"
  project_id = var.project_id
  region     = var.region
  action_service_account = var.action_service_account
}
