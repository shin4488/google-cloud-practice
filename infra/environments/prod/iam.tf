module "iam" {
  source = "../../resources/iam"

  project_id = var.project_id
  owner_email = var.owner_email
  owner_roles = var.owner_roles
  action_service_account_id = var.action_service_account_id
  terraform_service_account_id = var.terraform_service_account_id
}
